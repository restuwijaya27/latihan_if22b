import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PegawaiController extends GetxController {
  //TODO: Implement DosenController
  late TextEditingController cNama;
  late TextEditingController cNip;
  late TextEditingController cJabatan;
  late TextEditingController cAlamat;
  late TextEditingController cJeniskelamin;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference pegawai = firestore.collection('pegawai');

    return pegawai.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference pegawai = firestore.collection('pegawai');
    return pegawai.snapshots();
  }

  void add(String nama, String nip, String jabatan, String alamat,
      String jeniskelamin) async {
    CollectionReference pegawai = firestore.collection("pegawai");

    try {
      await pegawai.add({
        "nama": nama,
        "nip": nip,
        "jabatan": jabatan,
        "alamat": alamat,
        "jeniskelamin": jeniskelamin,
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data Pegawai",
          onConfirm: () {
            cNama.clear();
            cNip.clear();
            cJabatan.clear();
            cAlamat.clear();
            cJeniskelamin.clear();
            Get.back();
            Get.back();
            "OK";
          });
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Pegawai.",
      );
    }
  }

  Future<DocumentSnapshot<Object?>> GetDataById(String id) async {
    DocumentReference docRef = firestore.collection("pegawai").doc(id);

    return docRef.get();
  }

  void Update(String nama, String nip, String jabatan, String alamat,
      String jeniskelamin, String id) async {
    DocumentReference pegawaiById = firestore.collection("pegawai").doc(id);

    try {
      await pegawaiById.update({
        "nama": nama,
        "nip": nip,
        "jabatan": jabatan,
        "alamat": alamat,
        "jeniskelamin": jeniskelamin,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data Pegawai.",
        onConfirm: () {
          cNama.clear();
          cNip.clear();
          cJabatan.clear();
          cAlamat.clear();
          cJeniskelamin.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Pegawai.",
      );
    }
  }

  void delete(String id) {
    DocumentReference docRef = firestore.collection("pegawai").doc(id);

    try {
      Get.defaultDialog(
        title: "Konfirmasi Hapus",
        middleText: "Apakah Anda yakin ingin menghapus data pegawai ini?",
        onConfirm: () {
          docRef.delete().then((_) {
            // Successful deletion
            Get.back(); // Close the confirmation dialog
            Get.snackbar(
              'Sukses',
              'Data pegawai berhasil dihapus',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.shade100,
              colorText: Colors.green.shade900,
              duration: Duration(seconds: 3),
            );
          }).catchError((error) {
            // Handle deletion error
            Get.back(); // Close the confirmation dialog
            Get.snackbar(
              'Kesalahan',
              'Gagal menghapus data: $error',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.shade100,
              colorText: Colors.red.shade900,
              duration: Duration(seconds: 3),
            );
          });
        },
        onCancel: () {
          // Optional: Add any cleanup or additional logic when canceling
          Get.back();
        },
        textConfirm: "Hapus",
        textCancel: "Batal",
        confirmTextColor: Colors.white,
        cancelTextColor: Colors.teal.shade900,
        buttonColor: Colors.red,
      );
    } catch (e) {
      // Catch any unexpected errors during the delete process
      print('Unexpected error during delete: $e');
      Get.snackbar(
        'Kesalahan',
        'Terjadi kesalahan tidak terduga',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: Duration(seconds: 3),
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    cNama = TextEditingController();
    cNip = TextEditingController();
    cJabatan = TextEditingController();
    cAlamat = TextEditingController();
    cJeniskelamin = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNama.dispose();
    cNip.dispose();
    cJabatan.dispose();
    cAlamat.dispose();
    cJeniskelamin.dispose();
    super.onClose();
  }
}
