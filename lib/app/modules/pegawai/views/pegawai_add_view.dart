import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/pegawai/controllers/pegawai_controller.dart';

class PegawaiAddView extends GetView<PegawaiController> {
  const PegawaiAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pegawai'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: controller.cNama,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: controller.cJabatan,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Jabatan"),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: controller.cAlamat,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Alamat"),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: controller.cJeniskelamin,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: "Jenis Kelamin"),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () => controller.add(
                controller.cNama.text,
                controller.cJabatan.text,
                controller.cJeniskelamin.text,
                controller.cAlamat.text,
              ),
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}