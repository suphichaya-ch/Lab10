import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';
import 'user_list_screen.dart';      // แยกหน้า User
import 'product_list_screen.dart';   // แยกหน้า Product

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<ProductProvider>(context, listen: false).fetchProducts();
        Provider.of<UserProvider>(context, listen: false).fetchUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.deepPurple.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Stats ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  _buildStatCard('Users', userProvider.users.length.toString(), Icons.group, Colors.blue),
                  const SizedBox(width: 16),
                  _buildStatCard('Products', productProvider.products.length.toString(), Icons.inventory_2, Colors.orange),
                ],
              ),
            ),
            // --- User Management ---
            ListTile(
              title: const Text('Manage Users', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const UserListScreen()));
                },
              ),
            ),
            // --- Product Management ---
            ListTile(
              title: const Text('Manage Products', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductListScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(title),
          ],
        ),
      ),
    );
  }
}