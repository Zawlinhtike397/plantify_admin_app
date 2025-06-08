import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({super.key});

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;
    setState(() {
      _selectedImage = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Add New Plant',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 18,
              ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  Text(
                    'Please fill below form  to add a new plant.',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width > 600
                          ? 600
                          : MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Form(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Plant Name',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 13,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      // controller: _userNameController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter plant name',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Username must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Description',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 13,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      // controller: _emailController,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Enter description about plant',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Email must not be empty';
                                        }
                                        String pattern =
                                            r'^[a-zA-Z0-9._%+$-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{3,}$';
                                        RegExp regex = RegExp(pattern);

                                        if (!regex.hasMatch(value)) {
                                          return 'Enter a valid email address';
                                        }

                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 13,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      // controller: _passwordController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Enter price',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Password must not be empty';
                                        }

                                        String pattern =
                                            r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!!@#$%^&*(),.?\":{}|<>]).{8,}$';
                                        RegExp regex = RegExp(pattern);

                                        if (!regex.hasMatch(value)) {
                                          return 'require one letter, one number, one special character and 8 character password length';
                                        }

                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Height',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 13,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      // controller: _confirmPasswordController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter height of plant',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Temperature',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 13,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      // controller: _confirmPasswordController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter temperature of plant',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pot',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 13,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      // controller: _confirmPasswordController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter pot for plant',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE1E1E1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Plant Image',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 13,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: _pickImage,
                                      child: SizedBox(
                                        width: MediaQuery.sizeOf(context)
                                                    .width >
                                                600
                                            ? 560
                                            : MediaQuery.sizeOf(context).width,
                                        child: DottedBorder(
                                          stackFit: StackFit.passthrough,
                                          borderType: BorderType.RRect,
                                          dashPattern: const [4, 4],
                                          color: Colors.grey,
                                          radius: const Radius.circular(5.0),
                                          child: SizedBox(
                                            height: 100.0,
                                            width: 150.0,
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 10.0),
                                                _selectedImage != null
                                                    ? Image.file(
                                                        _selectedImage!)
                                                    : const Icon(
                                                        Icons
                                                            .add_photo_alternate_outlined,
                                                        size: 60.0,
                                                        color: Colors.grey,
                                                      ),
                                                Text(
                                                  'Click here to add plant images.',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          fontSize: 13.0,
                                                          color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 45.0,
                                width: MediaQuery.sizeOf(context).width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Text(
                                    'Add Product',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
