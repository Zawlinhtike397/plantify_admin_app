import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({super.key});

  @override
  State<AddPlant> createState() => AddPlantState();
}

class AddPlantState extends State<AddPlant> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  int? _activeImageIndex;
  final db = FirebaseFirestore.instance;

  Future _pickImages() async {
    final images = await _picker.pickMultiImage(
      requestFullMetadata: false,
    );

    if (images.isEmpty) return;

    setState(() {
      _selectedImages = images.map((img) => File(img.path)).toList();
    });
  }

  Future<void> _replaceImage(int index) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 350,
      requestFullMetadata: false,
    );
    if (pickedFile == null) return;

    setState(() {
      _selectedImages[index] = File(pickedFile.path);
      _activeImageIndex = null;
    });
  }

  void _viewImage(File file) {
    final imageProvider = Image.file(file).image;

    imageProvider.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        if (!mounted) return;

        final width = info.image.width.toDouble();
        final height = info.image.height.toDouble();
        final aspectRatio = width / height;

        showDialog(
          context: context,
          builder: (_) => Dialog(
            insetPadding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: InteractiveViewer(
                child: Image.file(
                  file,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      }),
    );
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
                          horizontal: 12.0,
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
                                      onTap: _pickImages,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                        ),
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
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(height: 10.0),
                                              _selectedImages.isNotEmpty
                                                  ? Wrap(
                                                      spacing: 8.0,
                                                      runSpacing: 10.0,
                                                      children: _selectedImages
                                                          .asMap()
                                                          .entries
                                                          .map((entry) {
                                                        final index = entry.key;
                                                        final file =
                                                            entry.value;

                                                        return GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (_activeImageIndex ==
                                                                  index) {
                                                                _activeImageIndex =
                                                                    null;
                                                              } else {
                                                                _activeImageIndex =
                                                                    index;
                                                              }
                                                            });
                                                          },
                                                          child: Stack(
                                                            clipBehavior:
                                                                Clip.none,
                                                            children: [
                                                              Image.file(file),
                                                              Positioned(
                                                                top: -13,
                                                                right: -4,
                                                                child:
                                                                    Container(
                                                                  width: 35.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .secondary,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      IconButton(
                                                                    iconSize:
                                                                        15.0,
                                                                    color: Colors
                                                                        .white,
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        _selectedImages
                                                                            .removeAt(index);
                                                                        if (_activeImageIndex ==
                                                                            index) {
                                                                          _activeImageIndex =
                                                                              null;
                                                                        }
                                                                      });
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .close),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (_activeImageIndex ==
                                                                  index)
                                                                Positioned.fill(
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.5),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        ElevatedButton(
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                            foregroundColor:
                                                                                Colors.black,
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                          onPressed: () =>
                                                                              _replaceImage(index),
                                                                          child:
                                                                              const Text('Replace'),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                8),
                                                                        TextButton(
                                                                          style:
                                                                              TextButton.styleFrom(
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                            foregroundColor:
                                                                                Colors.black,
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                          ),
                                                                          onPressed: () =>
                                                                              _viewImage(file),
                                                                          child:
                                                                              const Text('View'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    )
                                                  : Column(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .add_photo_alternate_outlined,
                                                          size: 60.0,
                                                          color: Colors.grey,
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          'Click here to add plant images.',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  fontSize:
                                                                      13.0,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ],
                                                    ),
                                              const SizedBox(height: 10.0),
                                            ],
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
