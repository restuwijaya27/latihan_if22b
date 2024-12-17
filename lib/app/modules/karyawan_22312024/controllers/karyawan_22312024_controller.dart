import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class karyawan_22312024Controller extends GetxController {
  //TODO: Implement DosenController
  late TextEditingController cNo_karyawan;
  late TextEditingController cNama_karyawan;
  late TextEditingController cJabatan_karyawan;
  late TextEditingController cAlamat;
  late TextEditingController cJeniskelamin;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference karyawan_22312024 = firestore.collection('karyawan_22312024');

    return karyawan_22312024.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference karyawan_22312024 = firestore.collection('karyawan_22312024');
    return karyawan_22312024.snapshots();
  }

  void add(String nama_karyawan , String no_karyawan, String jabatan_karyawan) async {
    CollectionReference karyawan_22312024 = firestore.collection("karyawan_22312024");

    try {
      await karyawan_22312024.add({
        "nama_karyawan": nama_karyawan,
        "no_karyawan": no_karyawan,
        "jabatan_karyawan": jabatan_karyawan,
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data Karyawan",
          onConfirm: () {
            cNama_karyawan.clear();
            cNo_karyawan.clear();
            cJabatan_karyawan.clear();
            Get.back();
            Get.back();
            "OK";
          });
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Karyawan.",
      );
    }
  }

  Future<DocumentSnapshot<Object?>> GetDataById(String id) async {
    DocumentReference docRef = firestore.collection("karyawan_22312024").doc(id);

    return docRef.get();
  }

  void Update(String nama_karyawan, String no_karyawan, String jabatan_karyawan, String id) async {
    DocumentReference karyawan_22312024ById = firestore.collection("karyawan_22312024").doc(id);

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
      await karyawan_22312024ById.update({
        "nama_karyawan": nama_karyawan,
        "no_karyawan": no_karyawan,
        "jabatan_karyawan": jabatan_karyawan,
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
                  "Data Karyawan berhasil diperbarui.",
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
                    cNama_karyawan.clear();
                    cNo_karyawan.clear();
                    cJabatan_karyawan.clear();
                    
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
                  "Gagal memperbarui data Karyawan. Silakan coba lagi.",
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
      print("Error updating Karyawan: $e");
    }
  }

  void delete(String id) {
    DocumentReference docRef = firestore.collection("karyawan_22312024").doc(id);

    try {
      Get.defaultDialog(
        title: "Konfirmasi Hapus",
        middleText: "Apakah Anda yakin ingin menghapus data Karyawan ini?",
        onConfirm: () {
          docRef.delete().then((_) {
            // Successful deletion
            Get.back(); // Close the confirmation dialog
            Get.snackbar(
              'Sukses',
              'Data Karyawan berhasil dihapus',
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
    cNama_karyawan = TextEditingController();
    cNo_karyawan = TextEditingController();
    cJabatan_karyawan = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    cNama_karyawan.dispose();
    cNo_karyawan.dispose();
    cJabatan_karyawan.dispose();
    super.onClose();
  }
}
