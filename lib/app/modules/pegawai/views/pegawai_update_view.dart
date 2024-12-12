import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/controllers/pegawai_controller.dart';

class PegawaiUpdateView extends GetView<PegawaiController> {
  const PegawaiUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[500],
        title: Text(
          'Ubah Pegawai', 
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.GetDataById(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.cNama.text = data['nama'];
            controller.cNip.text = data['nip'];
            controller.cJabatan.text = data['jabatan'];
            controller.cAlamat.text = data['alamat'];
            controller.cJeniskelamin.text = data['jeniskelamin'];
            
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(
                      controller: controller.cNip,
                      labelText: "NIP",
                      icon: Icons.badge_outlined,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: controller.cNama,
                      labelText: "Nama",
                      icon: Icons.person_outline,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: controller.cJabatan,
                      labelText: "Jabatan",
                      icon: Icons.work_outline,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: controller.cAlamat,
                      labelText: "Alamat",
                      icon: Icons.location_on_outlined,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: controller.cJeniskelamin,
                      labelText: "Jenis Kelamin",
                      icon: Icons.people_outline,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => controller.Update(
                        controller.cNama.text,
                        controller.cNip.text,
                        controller.cJabatan.text,
                        controller.cAlamat.text,
                        controller.cJeniskelamin.text,
                        Get.arguments,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[500],
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Ubah Data",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              color: Colors.teal[500],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.teal[500]),
        labelStyle: TextStyle(color: Colors.teal[500]),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade200, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade500, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}