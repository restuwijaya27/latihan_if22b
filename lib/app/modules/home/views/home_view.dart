import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/dosen/views/dosen_add_view.dart';
import 'package:myapp/app/modules/dosen/views/dosen_view.dart';
import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_add_view.dart';
import 'package:myapp/app/modules/mahasiswa/views/mahasiswa_view.dart';
import 'package:myapp/app/modules/karyawan_22312024/views/karyawan_22312024_add_view.dart';
import 'package:myapp/app/modules/karyawan_22312024/views/karyawan_22312024_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final cAuth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return DashboardAdmin();
  }
}

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  final cAuth = Get.find<AuthController>();
  int _index = 0;
  
  List<Map> _fragment = [
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard_customize_outlined,
      'view': MahasiswaView(),
      'add': () => MahasiswaAddView(),
      'color': Color(0xFF8E44AD), // Royal Purple
    },
    {
      'title': 'Data Mahasiswa',
      'icon': Icons.school_outlined,
      'view': MahasiswaView(),
      'add': () => MahasiswaAddView(),
      'color': Color(0xFF2980B9), // Deep Blue
    },
    {
      'title': 'Data Dosen',
      'icon': Icons.person_outline,
      'view': DosenView(),
      'add': () => DosenAddView(),
      'color': Color(0xFF27AE60), // Emerald Green
    },
    {
      'title': 'Data Karyawan_22312024',
      'icon': Icons.work_outline,
      'view': karyawan_22312024View(),
      'add': () => karyawan_22312024AddView(),
      'color': Color(0xFF6A11CB), // Golden Orange
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          _fragment[_index]['title'], 
          style: TextStyle(
            fontWeight: FontWeight.w900, 
            color: Colors.white,
            letterSpacing: 1.2
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _fragment[_index]['color'],
                _fragment[_index]['color'].withOpacity(0.7)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10,
        shadowColor: Colors.black45,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
          )
        ],
      ),
      drawer: _buildDrawer(),
      body: _fragment[_index]['view'],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6A11CB), // Deep Purple
              Color(0xFF2575FC)  // Blue
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              accountName: Text(
                "Restu Wijaya", 
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1
                )
              ),
              accountEmail: Text(
                'Administrator', 
                style: TextStyle(
                  fontSize: 15, 
                  color: Colors.white70,
                  fontWeight: FontWeight.w300
                )
              ),
              currentAccountPicture: Container(
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
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person, 
                    color: Color(0xFF6A11CB), 
                    size: 50
                  ),
                ),
              ),
            ),
            ...List.generate(_fragment.length + 1, (index) {
              if (index < _fragment.length) {
                return _buildDrawerItem(
                  icon: _fragment[index]['icon'], 
                  title: _fragment[index]['title'], 
                  color: _fragment[index]['color'],
                  onTap: () {
                    setState(() => _index = index);
                    Get.back();
                  }
                );
              } else {
                return _buildDrawerItem(
                  icon: Icons.logout, 
                  title: 'Logout', 
                  color: Colors.redAccent,
                  onTap: () {
                    Get.back();
                    cAuth.logout();
                  }
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon, 
    required String title, 
    required Color color,
    required VoidCallback onTap
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title, 
        style: TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.w600
        )
      ),
      onTap: onTap,
      trailing: Icon(Icons.chevron_right, color: Colors.white),
      hoverColor: color.withOpacity(0.2),
    );
  }
}