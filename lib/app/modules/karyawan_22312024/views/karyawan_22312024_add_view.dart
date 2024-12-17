import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/karyawan_22312024/controllers/karyawan_22312024_controller.dart';

class karyawan_22312024AddView extends GetView<karyawan_22312024Controller> {
  const karyawan_22312024AddView({Key? key}) : super(key: key);

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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
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
                              'Tambah Data Karyawan',
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
                              controller: controller.cNo_karyawan,
                              label: "NO_Karyawan",
                              icon: Icons.badge_outlined,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              controller: controller.cNama_karyawan,
                              label: "Nama Lengkap",
                              icon: Icons.person_outline,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              controller: controller.cJabatan_karyawan,
                              label: "Jabatan",
                              icon: Icons.work_outline,
                              textInputAction: TextInputAction.done,
                            ),
                            const SizedBox(height: 30),
                            _buildSaveButton(context),
                          ],
                        ),
                      ),
                    ),
                  ),
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
          'Tambah Karyawan',
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
    required String label,
    required IconData icon,
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      autocorrect: false,
      style: TextStyle(color: Colors.deepPurple[900]),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon, 
          color: Colors.deepPurple[600],
        ),
        filled: true,
        fillColor: Colors.deepPurple[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.deepPurple[300]!, 
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.deepPurple[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.add(
        controller.cNama_karyawan.text,
        controller.cNo_karyawan.text,
        controller.cJabatan_karyawan.text,
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
        "Simpan Data",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
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