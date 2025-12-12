import 'dart:io';

import 'package:battle_app/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../api/profile_api.dart';
import '../models/profile_model.dart';
import '../widgets/app_bar.dart';
import '../widgets/gradient_container.dart';
import '../widgets/text_widget.dart';

class EditProfile extends StatefulWidget {
  final ProfileScreenData userProfile;

  const EditProfile({super.key, required this.userProfile});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _bioController = TextEditingController();
  final _socialLinksController = TextEditingController();
  final _interestsController = TextEditingController();
  List<String> _selectedLanguages = [];

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  DateTime? _selectedDate;
  String? _selectedGender;
  final List<String> _listGender = ["Male", "Female", "Other"];

  @override
  void initState() {
    super.initState();
    final profile = widget.userProfile.profile;
    if (profile != null) {
      _fullNameController.text = profile.name ?? '';
      _addressController.text = profile.address ?? '';
      _phoneNumberController.text = profile.phoneNumber ?? '';
      _bioController.text = profile.bio ?? '';
      _socialLinksController.text = profile.socialLinks!.links.entries
          .map((e) => '${e.key}:${e.value}')
          .join(', ') ?? '';

      _interestsController.text = profile.interests.join(', ');
      _selectedLanguages = List<String>.from(profile.languages);
      if (profile.dateOfBirth != null) {
        _selectedDate = profile.dateOfBirth;
      }
      if (_listGender.contains(profile.gender)) {
        _selectedGender = profile.gender;
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _bioController.dispose();
    _socialLinksController.dispose();
    _interestsController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70, // compression
    );

    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.userProfile.profile;
    final imageUrl = profile?.imageProfile?.filePathUrl != null
        ? 'http://10.0.2.2:8080${profile?.imageProfile?.filePathUrl}'
        : 'https://via.placeholder.com/150';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: RapupAppBar(
        leading: const BackButton(color: Colors.black),
        center: const Text("Edit Profile",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        height: MediaQuery.of(context).size.height / 10,
        trailing: IconButton(
          icon: const Icon(
            FontAwesomeIcons.check,
            color: Colors.black,
          ),
          onPressed: () async {
            final updatedProfile = ProfileModel(
              userId: profile!.userId,
              name: _fullNameController.text,
              address: _addressController.text,
              phoneNumber: _phoneNumberController.text,
              bio: _bioController.text,
              gender: _selectedGender.toString(),
              dateOfBirth: _selectedDate,
              imageProfile: profile.imageProfile,
              socialLinks: profile.socialLinks, // or parse from text
              interests: _interestsController.text.split(',').map((e) => e.trim()).toList(),
              languages: List<String>.from(_selectedLanguages),
              id: profile.id,
              createdAt: profile.createdAt,
              updatedAt: DateTime.now(),
              active: false,
            );

            bool success = await ProfileApi.updateProfileWithImage(
              updatedProfile,
              _pickedImage,
            );

            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Profile updated successfully!")),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Failed to update profile.")),
              );
            }

          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          const GradientContainer(),
          Form(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 80, 10, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: _pickedImage != null
                              ? FileImage(File(_pickedImage!.path))
                              : NetworkImage(imageUrl) as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black54,
                            ),
                            child: IconButton(
                              icon: const Icon(FontAwesomeIcons.camera, color: Colors.white),
                              onPressed: _pickImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextWidget(
                    controller: _fullNameController,
                    label: 'Full Name',
                    icon: FontAwesomeIcons.user,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    controller: _addressController,
                    label: 'Address',
                    icon: FontAwesomeIcons.addressCard,
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    controller: _phoneNumberController,
                    label: 'Phone Number',
                    icon: FontAwesomeIcons.phone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    controller: _bioController,
                    label: 'Bio',
                    icon: FontAwesomeIcons.book,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLines: null,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    controller: _socialLinksController,
                    label: 'Social Links',
                    icon: FontAwesomeIcons.link,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    controller: _interestsController,
                    label: 'Interests',
                    icon: FontAwesomeIcons.heart,
                    hint: 'Example, Example, Example',
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
        MultiSelectBottomSheetField<String?>(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.transparent),
          ),
          searchHint: 'Search',
          searchTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          searchHintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          searchIcon:  Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.white, size: 18),
          closeSearchIcon: const Icon(FontAwesomeIcons.xmark, color: Colors.white, size: 18),
          cancelText: Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          confirmText: Text("Confirm", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white.withOpacity(0.5),
          listType: MultiSelectListType.CHIP,
          itemsTextStyle:const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          items: languages
              .map((lang) => MultiSelectItem<String?>(lang, lang))
              .toList(),
          initialValue: _selectedLanguages.cast<String?>(),
          searchable: true,
          title: Text("Select languages", style: const TextStyle(fontWeight: FontWeight.bold)),
          buttonText: Text("Languages",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          chipDisplay: MultiSelectChipDisplay(
            textStyle: TextStyle(color: Colors.black54, fontSize: 15),
            chipColor: Colors.transparent,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black26),
            ),
            onTap: (value) {
              setState(() {
                _selectedLanguages.remove(value);
              });
            },
          ),

          onConfirm: (List<String?> results) {
            setState(() {
              _selectedLanguages = results.whereType<String>().toList();
            });
          },

          buttonIcon: Icon(FontAwesomeIcons.language, color: Colors.white, size: 18),

        ),


        const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: Text('Date of birth', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () => _selectDate(context),
                          child: Row(
                            spacing: 15,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 3),
                                child: Icon(FontAwesomeIcons.calendarDays, color: Colors.black54),
                              ),
                              Text(
                                _selectedDate == null
                                    ? 'Select Date'
                                    : '${_selectedDate!.toLocal()}'.split(' ')[0],
                                style: const TextStyle(color: Colors.black54, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: Text('Gender', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          spacing: 15,
                          children: [
                            Icon(FontAwesomeIcons.venusMars, size: 20, color: Colors.black54,),
                            Expanded(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text('Select Gender'),
                                dropdownColor: Colors.white.withOpacity(0.8),
                                iconSize: 30,
                                underline: const SizedBox(),
                                style: const TextStyle(color: Colors.black87, fontSize: 15),
                                value: _selectedGender,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedGender = newValue;
                                  });
                                },
                                items: _listGender
                                    .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> languages = [
  "Arabic",
  "English",
  "French",
  "Spanish",
  "German",
  "Italian",
  "Portuguese",
  "Russian",
  "Mandarin Chinese",
  "Cantonese",
  "Japanese",
  "Korean",
  "Hindi",
  "Urdu",
  "Bengali",
  "Punjabi",
  "Gujarati",
  "Marathi",
  "Tamil",
  "Telugu",
  "Kannada",
  "Malayalam",
  "Sinhala",
  "Nepali",
  "Pashto",
  "Persian (Farsi)",
  "Turkish",
  "Kurdish",
  "Hebrew",
  "Greek",
  "Dutch",
  "Swedish",
  "Norwegian",
  "Danish",
  "Finnish",
  "Polish",
  "Czech",
  "Slovak",
  "Hungarian",
  "Romanian",
  "Bulgarian",
  "Serbian",
  "Croatian",
  "Bosnian",
  "Slovenian",
  "Ukrainian",
  "Belarusian",
  "Lithuanian",
  "Latvian",
  "Estonian",
  "Thai",
  "Vietnamese",
  "Myanmar (Burmese)",
  "Khmer",
  "Lao",
  "Malay",
  "Indonesian",
  "Filipino (Tagalog)",
  "Javanese",
  "Sundanese",
  "Swahili",
  "Amharic",
  "Somali",
  "Yoruba",
  "Igbo",
  "Hausa",
  "Zulu",
  "Xhosa",
  "Afrikaans",
  "Maori",
  "Samoan",
  "Tongan",
  "Mongolian",
  "Armenian",
  "Georgian",
  "Albanian",
  "Icelandic",
  "Irish",
  "Welsh",
  "Basque",
  "Catalan"
];

