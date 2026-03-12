import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';


class UserFormScreen extends StatefulWidget {
  final UserModel? editUser; // ✅ ใช้ชื่อ editUser เป็นมาตรฐาน
  const UserFormScreen({super.key, this.editUser});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late TextEditingController _cityController;
  late TextEditingController _streetController;

  bool get isEditing => widget.editUser != null;

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController(text: widget.editUser?.name.firstname ?? '');
    _lastnameController = TextEditingController(text: widget.editUser?.name.lastname ?? '');
    _usernameController = TextEditingController(text: widget.editUser?.username ?? '');
    _emailController = TextEditingController(text: widget.editUser?.email ?? '');
    _passwordController = TextEditingController(text: widget.editUser?.password ?? '');
    _phoneController = TextEditingController(text: widget.editUser?.phone ?? '');
    _cityController = TextEditingController(text: widget.editUser?.address.city ?? '');
    _streetController = TextEditingController(text: widget.editUser?.address.street ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit User' : 'Add User')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _firstnameController, decoration: const InputDecoration(labelText: 'First Name')),
              TextFormField(controller: _lastnameController, decoration: const InputDecoration(labelText: 'Last Name')),
              TextFormField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Username')),
              TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
              TextFormField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
              TextFormField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone')),
              TextFormField(controller: _cityController, decoration: const InputDecoration(labelText: 'City')),
              TextFormField(controller: _streetController, decoration: const InputDecoration(labelText: 'Street')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: provider.isLoading ? null : _submitForm,
                child: provider.isLoading ? const CircularProgressIndicator() : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final userObject = UserModel(
      id: widget.editUser?.id,
      email: _emailController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
      phone: _phoneController.text.trim(),
      name: NameModel(firstname: _firstnameController.text.trim(), lastname: _lastnameController.text.trim()),
      address: AddressModel(
        city: _cityController.text.trim(),
        street: _streetController.text.trim(),
        number: widget.editUser?.address.number ?? 0,
        zipcode: widget.editUser?.address.zipcode ?? '',
        geolocation: GeoLocationModel(lat: '0', long: '0'),
      ),
    );

    final provider = context.read<UserProvider>();
    bool success;

    if (isEditing) {
      success = await provider.updateUser(widget.editUser!.id!, userObject); // ✅ ส่ง 2 ค่า
    } else {
      success = await provider.createUser(userObject);
    }

    if (mounted && success) Navigator.pop(context);
  }
}