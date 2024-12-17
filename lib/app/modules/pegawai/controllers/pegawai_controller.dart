import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PegawaiController extends GetxController {
  //TODO: Implement DosenController
  late TextEditingController cNama;
  late TextEditingController cNo;
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

  void add(String nama , String no, String jabatan, String alamat,
      String jeniskelamin) async {
    CollectionReference pegawai = firestore.collection("pegawai");

    try {
      await pegawai.add({
        "nama": nama,
        "no": no,
        "jabatan": jabatan,
        "alamat": alamat,
        "jeniskelamin": jeniskelamin,
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data Pegawai",
          onConfirm: () {
            cNama.clear();
            cNo.clear();
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

  void Update(String nama, String no, String jabatan, String alamat,
      String jeniskelamin, String id) async {
    DocumentReference pegawaiById = firestore.collection("pegawai").doc(id);

    try {
      // Show loading dialog
      Get.dialog(
        Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 5,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
                SizedBox(height: 5),
                Text(
                  "Sedang Memperbarui Data...",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      // Perform update
      await pegawaiById.update({
        "nama": nama,
        "no": no,
        "jabatan": jabatan,
        "alamat": alamat,
        "jeniskelamin": jeniskelamin,
      });

      // Close loading dialog
      Get.back();

      // Show success dialog
      Get.dialog(
        Center(
          child: Container(
            width: Get.width * 0.8,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple[400]!,
                  Colors.deepPurple[600]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  spreadRadius: 5,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 80,
                ),
                SizedBox(height: 20),
                Text(
                  "Berhasil",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Data Pegawai berhasil diperbarui.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    // Clear controllers
                    cNama.clear();
                    cNo.clear();
                    cJabatan.clear();
                    cAlamat.clear();
                    cJeniskelamin.clear();
                    
                    // Navigate back twice
                    Get.back();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40, 
                      vertical: 12
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      // Close any existing dialogs
      Get.back();

      // Show error dialog
      Get.dialog(
        Center(
          child: Container(
            width: Get.width * 0.8,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 80,
                ),
                SizedBox(height: 20),
                Text(
                  "Kesalahan",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Gagal memperbarui data Pegawai. Silakan coba lagi.",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40, 
                      vertical: 12
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Tutup",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      // Log the error
      print("Error updating pegawai: $e");
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
    cNo = TextEditingController();
    cJabatan = TextEditingController();
    cAlamat = TextEditingController();
    cJeniskelamin = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNama.dispose();
    cNo.dispose();
    cJabatan.dispose();
    cAlamat.dispose();
    cJeniskelamin.dispose();
    super.onClose();
  }
}
