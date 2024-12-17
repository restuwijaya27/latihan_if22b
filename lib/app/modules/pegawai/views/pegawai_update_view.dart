import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/controllers/pegawai_controller.dart';

class PegawaiUpdateView extends GetView<PegawaiController> {
  const PegawaiUpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple[300]!,
              Colors.deepPurple[700]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: FutureBuilder<DocumentSnapshot<Object?>>(
                  future: controller.GetDataById(Get.arguments),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.data!.data() as Map<String, dynamic>;
                      controller.cNama.text = data['nama'];
                      controller.cNo.text = data['no'];
                      controller.cJabatan.text = data['jabatan'];
                      controller.cAlamat.text = data['alamat'];
                      controller.cJeniskelamin.text = data['jeniskelamin'];
                      
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          child: Card(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Ubah Data Pegawai',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.deepPurple[800],
                                      letterSpacing: 1.1,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 25),
                                  _buildTextField(
                                    controller: controller.cNo,
                                    labelText: "NO",
                                    icon: Icons.badge_outlined,
                                  ),
                                  const SizedBox(height: 15),
                                  _buildTextField(
                                    controller: controller.cNama,
                                    labelText: "Nama",
                                    icon: Icons.person_outline,
                                  ),
                                  const SizedBox(height: 15),
                                  _buildTextField(
                                    controller: controller.cJabatan,
                                    labelText: "Jabatan",
                                    icon: Icons.work_outline,
                                  ),
                                  const SizedBox(height: 15),
                                  _buildTextField(
                                    controller: controller.cAlamat,
                                    labelText: "Alamat",
                                    icon: Icons.location_on_outlined,
                                  ),
                                  const SizedBox(height: 15),
                                  _buildTextField(
                                    controller: controller.cJeniskelamin,
                                    labelText: "Jenis Kelamin",
                                    icon: Icons.people_outline,
                                  ),
                                  const SizedBox(height: 30),
                                  _buildUpdateButton(context),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white70,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Ubah Pegawai',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 1.2,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 10.0,
              color: Colors.black54,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
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
      style: TextStyle(color: Colors.deepPurple[900]),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          icon, 
          color: Colors.deepPurple[600],
        ),
        labelStyle: TextStyle(
          color: Colors.deepPurple[700],
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.deepPurple[50],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple.shade200, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple.shade500, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.Update(
        controller.cNama.text,
        controller.cNo.text,
        controller.cJabatan.text,
        controller.cAlamat.text,
        controller.cJeniskelamin.text,
        Get.arguments,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple[600],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
      ),
      child: Text(
        "Ubah Data",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          letterSpacing: 1.2,
          shadows: [
            Shadow(
              blurRadius: 5.0,
              color: Colors.black38,
              offset: Offset(1.0, 1.0),
            ),
          ],
        ),
      ),
    );
  }
}