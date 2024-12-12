import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/views/pegawai_update_view.dart';
import '../controllers/pegawai_controller.dart';

class PegawaiView extends GetView<PegawaiController> {
  void showOption(id) async {
    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal.shade50,
                Colors.teal.shade100,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.shade200.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Pilih Aksi',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.teal[900],
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Divider(color: Colors.teal[300], thickness: 1.5),
              _buildOptionTile(
                icon: Icons.edit,
                title: 'Update',
                color: Colors.teal,
                onTap: () {
                  Get.back();
                  Get.to(
                    PegawaiUpdateView(),
                    arguments: id,
                  );
                },
              ),
              _buildOptionTile(
                icon: Icons.delete,
                title: 'Delete',
                color: Colors.red,
                onTap: () {
                  Get.back();
                  controller.delete(id);
                },
              ),
              _buildOptionTile(
                icon: Icons.close,
                title: 'Close',
                color: Colors.grey,
                onTap: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: color.withOpacity(0.7),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pegawai List',
          style: TextStyle(
            color: Colors.teal[900],
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: Get.put(PegawaiController()).streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocs = snapshot.data?.docs ?? [];
            return listAllDocs.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.teal.shade50,
                          Colors.teal.shade100,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      itemCount: listAllDocs.length,
                      itemBuilder: (context, index) {
                        var data = listAllDocs[index].data() as Map<String, dynamic>;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.teal.shade100.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: Colors.teal[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: Colors.teal[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "${data["nama"]}",
                                style: TextStyle(
                                  color: Colors.teal[900],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                "${data["nip"]}",
                                style: TextStyle(
                                  color: Colors.teal[700],
                                  fontSize: 14,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () => showOption(listAllDocs[index].id),
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.teal[700],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list_alt,
                          size: 100,
                          color: Colors.teal[300],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Data Kosong",
                          style: TextStyle(
                            color: Colors.teal[900],
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tidak ada data pegawai yang tersedia",
                          style: TextStyle(
                            color: Colors.teal[700],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade700),
            ),
          );
        },
      ),
    );
  }
}