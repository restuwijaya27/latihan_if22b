import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/controllers/pegawai_controller.dart';

class PegawaiUpdateView extends GetView<PegawaiController> {
  const PegawaiUpdateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Pegawai'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.GetDataById(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.cNama.text = data['nama'];
            controller.cJabatan.text = data['jabatan'];
            controller.cAlamat.text = data['alamat'];
            controller.cJeniskelamin.text = data['jeniskelamin'];
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  TextField(
                    controller: controller.cNama,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Nama"),
                  ),
                  TextField(
                    controller: controller.cJabatan,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Jabatan"),
                  ),
                  TextField(
                    controller: controller.cAlamat,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Alamat"),
                  ),
                  TextField(
                    controller: controller.cJeniskelamin,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: "Jenis_kelamin"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.Update(
                      controller.cNama.text,
                      controller.cJabatan.text,
                      controller.cAlamat.text,
                      controller.cJeniskelamin.text,
                      Get.arguments,
                    ),
                    child: Text("Ubah"),
                  )
                ],
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
