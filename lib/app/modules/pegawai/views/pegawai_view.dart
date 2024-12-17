import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/views/pegawai_add_view.dart';
import 'package:myapp/app/modules/pegawai/views/pegawai_update_view.dart';
import '../controllers/pegawai_controller.dart';

class PegawaiView extends GetView<PegawaiController> {
  void _showDetailBottomSheet(Map<String, dynamic> data) {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A11CB).withOpacity(0.9),
              Color(0xFF2575FC).withOpacity(0.9)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5)
                    )
                  ]
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Color(0xFF6A11CB),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                data["nama"],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "No ${data["no"]}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 10),
              _buildDetailRow("Jabatan", data["jabatan"] ?? "N/A"),
              _buildDetailRow("Alamat", data["alamat"] ?? "N/A"),
              _buildDetailRow("Jenis Kelamin", data["jeniskelamin"] ?? "N/A"),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showEnhancedOptionsDialog(String id) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Pilih Aksi',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF6A11CB),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAnimatedActionButton(
              icon: Icons.edit,
              label: 'Update',
              color: Color(0xFF6A11CB),
              onTap: () {
                Get.back();
                Get.to(
                  PegawaiUpdateView(),
                  arguments: id,
                  transition: Transition.rightToLeft,
                );
              },
            ),
             SizedBox(height: 20),
            _buildAnimatedActionButton(
                icon: Icons.delete,
                label: 'Delete',
                color: Colors.redAccent,
                onTap: () {
                  Get.back();
                  controller.delete(id);
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Batal',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: Get.put(PegawaiController()).streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocs = snapshot.data?.docs ?? [];
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF6A11CB).withOpacity(0.1),
                        Color(0xFF2575FC).withOpacity(0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: listAllDocs.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.only(
                            top: 16, 
                            bottom: 100, // Space for the floating button
                            left: 16, 
                            right: 16
                          ),
                          itemCount: listAllDocs.length,
                          itemBuilder: (context, index) {
                            var data = listAllDocs[index].data() as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: GestureDetector(
                                onTap: () => _showDetailBottomSheet(data),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF6A11CB).withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Color(0xFF6A11CB).withOpacity(0.1),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    leading: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF6A11CB),
                                            Color(0xFF2575FC),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF6A11CB).withOpacity(0.5),
                                            blurRadius: 6,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${data["nama"]}",
                                      style: TextStyle(
                                        color: Color(0xFF6A11CB),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${data["no"]}",
                                      style: TextStyle(
                                        color: Color(0xFF2575FC),
                                        fontSize: 15,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () => _showEnhancedOptionsDialog(listAllDocs[index].id),
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Color(0xFF6A11CB),
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_alt_outlined,
                                size: 120,
                                color: Color(0xFF6A11CB),
                              ),
                              SizedBox(height: 25),
                              Text(
                                "Tidak Ada Data Pegawai",
                                style: TextStyle(
                                  color: Color(0xFF6A11CB),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Silakan tambahkan pegawai baru",
                                style: TextStyle(
                                  color: Color(0xFF2575FC),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                
                // Floating Add Button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          PegawaiAddView(),
                          transition: Transition.cupertino,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40, 
                          vertical: 15
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF6A11CB),
                              Color(0xFF2575FC),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF6A11CB).withOpacity(0.6),
                              spreadRadius: 1,
                              blurRadius: 15,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Tambah Pegawai',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF6A11CB).withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6A11CB)),
                  strokeWidth: 4,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}