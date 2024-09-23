import 'package:flutter/material.dart';
import 'package:homehub/login_screen.dart';
import 'package:homehub/my_properties.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'change_password_screen.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = 'Sankesh Patil';
  String phoneNumber = '+91 84010 45505';
  String email = 'sankesh4002@gmail.com';
  String username = '@sankesh_07';
  String? profileImage; // To store the profile image path

  final ImagePicker _picker = ImagePicker();

  Future<void> _updateProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        profileImage = image.path; // Store the image path
      });
    }
  }

  void _updateProfile(String updatedName, String updatedPhone) {
    setState(() {
      fullName = updatedName;
      phoneNumber = updatedPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SafeArea(
        child:Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header Section (Profile Photo, Name, and Username)
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _updateProfileImage, // Add tap handler to update profile image
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFF648C8C),
                            backgroundImage: profileImage != null ? FileImage(File(profileImage!)) : null, // Show selected image
                            child: profileImage == null ? Icon(Icons.person, size: 50, color: Colors.white) : null,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              username,
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Account Information Section
                    Text(
                      'Account Information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text('Full Name'),
                        subtitle: Text(fullName),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text('Email Address'),
                        subtitle: Text(email),
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text('Phone Number'),
                        subtitle: Text(phoneNumber),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Security Section
                    Text(
                      'My Data',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text('View  my Properties'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyProperties()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),

                    // Account Settings Section
                    Text(
                      'Account Settings',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text('Update Account'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return UpdateAccountDialog(
                                name: fullName,
                                phone: phoneNumber,
                                onUpdate: _updateProfile,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),

                    // Security Section
                    Text(
                      'Security',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text('Change Password'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                            logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF648C8C),
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Log Out'),
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

  void logout()async {
    try{
      await FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }catch (e) {
      print("Error signing out: $e");
    }
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

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phone);
  }

  Future<void> _updateProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        profileImage = image.path; // Store the image path
      });
    }
  }

  String fullName = 'Sankesh Patil';
  String phoneNumber = '+91 84010 45505';
  String? profileImage;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Account'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile Photo (User can click to update)
            GestureDetector(
              onTap: _updateProfileImage, // Add tap handler to update profile image
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF648C8C),
                backgroundImage: profileImage != null ? FileImage(File(profileImage!)) : null, // Show selected image
                child: profileImage == null ? Icon(Icons.person, size: 50, color: Colors.white) : null,
              ),
            ),
            SizedBox(height: 16),

            // Full Name Input
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 16),

            // Phone Number Input
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 16),

            // Non-editable Email
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'sankesh4002@gmail.com',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onUpdate(nameController.text, phoneController.text);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class ProfileImagePicker extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Handle image here (e.g., update profile picture, save path, etc.)
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Profile Picture'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _pickImage(context),
          child: Text('Open Camera'),
        ),
      ),
    );
  }
}
