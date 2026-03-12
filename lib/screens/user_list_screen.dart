import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'user_form_screen.dart';
// อย่าลืม import ไฟล์นี้ถ้ามีการเรียกใช้ปุ่มไปหน้าจัดการสินค้า
// import 'admin_product_screen.dart'; 

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    // ดึงข้อมูลเมื่อหน้าจอโหลด
    Future.microtask(() => 
      Provider.of<UserProvider>(context, listen: false).fetchUsers()
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => provider.fetchUsers(),
          ),
        ],
      ),
      body: _buildBody(provider),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(UserProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // แก้ไข: เช็ค errorMessage จาก provider (ถ้าใน provider มีตัวแปรนี้)
    // if (provider.errorMessage != null) { ... } 

    if (provider.users.isEmpty) {
      return const Center(child: Text('No users found. Tap + to add a user.'));
    }

    return ListView.builder(
      itemCount: provider.users.length,
      itemBuilder: (context, index) {
        final user = provider.users[index];
        
        // ดึงชื่อออกมาป้องกัน error กรณี Model เป็นแบบ Nested (u.name.firstname)
        final String firstName = user.name?.firstname ?? 'No';
        final String lastName = user.name?.lastname ?? 'Name';

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(firstName.isNotEmpty ? firstName[0].toUpperCase() : '?'),
            ),
            title: Text("$firstName $lastName"), // ใช้การต่อ String แทน fullName ถ้ายังไม่ได้สร้าง getter
            subtitle: Text('${user.username ?? ''} • ${user.email ?? ''}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // ตรวจสอบชื่อ parameter ใน UserFormScreen ว่าชื่อ user หรือ editUser
                        builder: (context) => UserFormScreen(editUser: user), 
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(user.id!),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
           // ในฟังก์ชัน _confirmDelete
onPressed: () {
  Navigator.pop(context);
  // แก้จาก removeUser เป็น deleteUser
  context.read<UserProvider>().deleteUser(id); 
},
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}