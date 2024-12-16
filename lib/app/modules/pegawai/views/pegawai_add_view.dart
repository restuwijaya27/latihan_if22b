import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/controllers/pegawai_controller.dart';

class PegawaiAddView extends GetView<PegawaiController> {
  const PegawaiAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Tambah Pegawai',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal[600],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: controller.cNip,
                label: "NIP",
                icon: Icons.card_membership,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: controller.cNama,
                label: "Nama Lengkap",
                icon: Icons.person,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: controller.cJabatan,
                label: "Jabatan",
                icon: Icons.work,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: controller.cAlamat,
                label: "Alamat",
                icon: Icons.location_on,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: controller.cJeniskelamin,
                label: "Jenis Kelamin",
                icon: Icons.people,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 25),
              _buildSaveButton(context),
            ],
          ),
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
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal[600]),
        filled: true,
        fillColor: Colors.teal[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.teal[300]!, width: 2),
        ),
        labelStyle: TextStyle(color: Colors.teal[800]),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.add(
        controller.cNama.text,
        controller.cNip.text,
        controller.cJabatan.text,
        controller.cJeniskelamin.text,
        controller.cAlamat.text,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal[600],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
      child: const Text(
        "Simpan Data",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}