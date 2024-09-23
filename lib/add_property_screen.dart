import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'dart:io'; // For handling file paths

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
  String? _category = 'Home'; // Default category
  String _propertyType = 'Sell'; // Default type
  File? _image; // Property image

  // Method to pick an image
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Method to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String propertyName = _nameController.text;
      String description = _descriptionController.text;
      String beds = _bedsController.text;
      String area = _areaController.text;
      String city = _cityController.text;
      String state = _stateController.text;
      String country = _countryController.text;
      String price = _priceController.text;

      // For now, just print the property data
      print("Property Name: $propertyName");
      print("Description: $description");
      print("Beds: $beds");
      print("Area: $area sqft");
      print("City: $city");
      print("State: $state");
      print("Country: $country");
      print("Price: $price");
      print("Category: $_category");
      print("Type: $_propertyType");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Property added successfully!')),
      );

      // Clear the form
      _nameController.clear();
      _descriptionController.clear();
      _bedsController.clear();
      _areaController.clear();
      _cityController.clear();
      _stateController.clear();
      _countryController.clear();
      _priceController.clear();
      setState(() {
        _category = 'Home';
        _propertyType = 'Sell';
        _image = null;
      });
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
              // Property Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Property Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the property name';
                  }
                  return null;
                },
              ),
              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              // Number of Beds
              TextFormField(
                controller: _bedsController,
                decoration: InputDecoration(labelText: 'Number of Beds'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of beds';
                  }
                  return null;
                },
              ),
              // Total sqft Area
              TextFormField(
                controller: _areaController,
                decoration: InputDecoration(labelText: 'Total Sqft Area'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the area';
                  }
                  return null;
                },
              ),
              // Price
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              // City
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the city';
                  }
                  return null;
                },
              ),
              // State
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the state';
                  }
                  return null;
                },
              ),
              // Country
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the country';
                  }
                  return null;
                },
              ),
              // Type of Property (Sell or Rent)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Type of Property', style: TextStyle(fontSize: 16)),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Sell',
                    groupValue: _propertyType,
                    onChanged: (value) {
                      setState(() {
                        _propertyType = value!;
                      });
                    },
                  ),
                  Text('Sell'),
                  Radio<String>(
                    value: 'Rent',
                    groupValue: _propertyType,
                    onChanged: (value) {
                      setState(() {
                        _propertyType = value!;
                      });
                    },
                  ),
                  Text('Rent'),
                ],
              ),
              // Category of Property
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Category of Property', style: TextStyle(fontSize: 16)),
              ),
              DropdownButtonFormField<String>(
                value: _category,
                items: [
                  DropdownMenuItem(value: 'Home', child: Text('Home')),
                  DropdownMenuItem(value: 'Flat', child: Text('Flat')),
                  DropdownMenuItem(value: 'Apartment', child: Text('Apartment')),
                  DropdownMenuItem(value: 'Villa', child: Text('Villa')),
                ],
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Select Category'),
              ),
              // Property Image Picker
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
                  child: Image.file(
                    _image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
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
}
