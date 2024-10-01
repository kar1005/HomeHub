import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPropertyScreen extends StatefulWidget {
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _bedsController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Variables for dropdown and radio button selections
  String? _category = 'Home';
  String _propertyType = 'Sell';
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Prepare property data
      String propertyName = _nameController.text;
      String description = _descriptionController.text;
      int beds = int.parse(_bedsController.text);
      double area = double.parse(_areaController.text);
      String city = _cityController.text;
      String state = _stateController.text;
      String country = _countryController.text;
      double price = double.parse(_priceController.text);
      String category = _category!;
      String propertyType = _propertyType;

      // Get the current user
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // If no user is logged in, show an error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not logged in')),
        );
        return;
      }

      String userId = currentUser.uid;

      // Property data map to store in Firestore
      Map<String, dynamic> propertyData = {
        'name': propertyName,
        'description': description,
        'beds': beds,
        'area': area,
        'city': city,
        'state': state,
        'country': country,
        'price': price,
        'category': category,
        'propertyType': propertyType,
        'userId': userId, // Store the current user's ID
        'imageUrl': null,  // Placeholder for image URL
      };

      try {
        // Save property to Firestore 'properties' collection
        await FirebaseFirestore.instance.collection('properties').add(propertyData);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Property added successfully!')),
        );

        // Clear the form fields
        _nameController.clear();
        _descriptionController.clear();
        _bedsController.clear();
        _areaController.clear();
        _cityController.clear();
        _stateController.clear();
        _countryController.clear();
        _priceController.clear();
        setState(() {
          _image = null;
          _category = 'Home';
          _propertyType = 'Sell';
        });
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add property: $e')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Section 1: Property Info
              Text("Property Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              // Property Name
              _buildTextField(_nameController, 'Property Name'),

              // Description
              _buildTextField(_descriptionController, 'Description', maxLines: 3),

              // Number of Beds
              _buildTextField(_bedsController, 'Number of Beds', keyboardType: TextInputType.number),

              // Total sqft Area
              _buildTextField(_areaController, 'Total Sqft Area', keyboardType: TextInputType.number),

              // Price
              _buildTextField(_priceController, 'Price', keyboardType: TextInputType.number),

              // Section 2: Location Info
              Text("Location Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              // City
              _buildTextField(_cityController, 'City'),

              // State
              _buildTextField(_stateController, 'State'),

              // Country
              _buildTextField(_countryController, 'Country'),

              // Property Type
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Type of Property', style: TextStyle(fontSize: 16)),
              ),
              _buildRadioOption('Sell', 'Rent'),

              // Property Category
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Category of Property', style: TextStyle(fontSize: 16)),
              ),
              DropdownButtonFormField<String>(
                value: _category,
                items: ['Home', 'Flat', 'Apartment', 'Villa'].map((String value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

              // Image Picker
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text('Select Property Image', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Image.file(_image!, height: 200, width: double.infinity, fit: BoxFit.cover),
                ),

              // Submit Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text('Add Property', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom reusable method for building TextFormFields
  Widget _buildTextField(TextEditingController controller, String label, {TextInputType? keyboardType, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  // Custom method to build Radio buttons for property type
  Widget _buildRadioOption(String option1, String option2) {
    return Row(
      children: [
        Radio<String>(
          value: option1,
          groupValue: _propertyType,
          onChanged: (value) {
            setState(() {
              _propertyType = value!;
            });
          },
        ),
        Text(option1),
        Radio<String>(
          value: option2,
          groupValue: _propertyType,
          onChanged: (value) {
            setState(() {
              _propertyType = value!;
            });
          },
        ),
        Text(option2),
      ],
    );
  }
}
