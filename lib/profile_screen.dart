import 'package:flutter/material.dart';
import 'package:homehub/login_screen.dart';
import 'package:homehub/my_properties.dart';
import 'package:image_picker/image_picker.dart';
import 'change_password_screen.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email;
  String? phoneNumber;
  String? fullName;
  String? profileImage;
  bool _isLoading = true;

  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            email = user.email;
            phoneNumber = userDoc['contactNumber'];
            fullName = userDoc['name'];
            profileImage = userDoc['profileImage'];
            _isLoading = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User profile does not exist')),
          );
        }
      } catch (e) {
        print('Error fetching user profile: $e');
      }
    }
  }

  Future<void> _updateProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        profileImage = image.path;
      });
      // Here, you would upload the image to Firebase Storage and update Firestore.
    }
  }

  void _updateProfile(String updatedName, String updatedPhone) async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        await _firestore.collection('users').doc(currentUser.uid).update({
          'fullName': updatedName,
          'contactNumber': updatedPhone,
        });
        setState(() {
          fullName = updatedName;
          phoneNumber = updatedPhone;
        });
      } catch (e) {
        print("Error updating profile: $e");
      }
    }
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _updateProfileImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFF648C8C),
                            backgroundImage: profileImage != null
                                ? FileImage(File(profileImage!))
                                : null,
                            child: profileImage == null
                                ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName ?? '',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Account Information',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: const Text('Full Name'),
                        subtitle: Text(fullName ?? ''),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: const Text('Email Address'),
                        subtitle: Text(email ?? ''),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: const Text('Phone Number'),
                        subtitle: Text(phoneNumber ?? ''),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'My Data',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: const Text('View my Properties'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProperties()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Account Settings',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: const Text('Update Account'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return UpdateAccountDialog(
                                name: fullName ?? '',
                                phone: phoneNumber ?? '',
                                onUpdate: _updateProfile,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Security',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: const Text('Change Password'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChangePasswordScreen()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF648C8C),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Log Out'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateAccountDialog extends StatefulWidget {
  final String name;
  final String phone;
  final Function(String, String) onUpdate;

  UpdateAccountDialog({
    required this.name,
    required this.phone,
    required this.onUpdate,
  });

  @override
  _UpdateAccountDialogState createState() => _UpdateAccountDialogState();
}

class _UpdateAccountDialogState extends State<UpdateAccountDialog> {
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Account'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onUpdate(nameController.text, phoneController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
