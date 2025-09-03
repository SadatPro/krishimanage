import 'package:flutter/material.dart';

class FarmerRegistrationPage extends StatefulWidget {
  @override
  _FarmerRegistrationPageState createState() => _FarmerRegistrationPageState();
}

class _FarmerRegistrationPageState extends State<FarmerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _landAreaController = TextEditingController();
  final _experienceController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _isGettingLocation = false;
  String _selectedGroup = 'গ্রুপ A';
  List<String> _selectedCrops = [];

  final List<String> _availableGroups = [
    'গ্রুপ A',
    'গ্রুপ B',
    'গ্রুপ C',
    'গ্রুপ D',
    'গ্রুপ E',
    'গ্রুপ F',
    'গ্রুপ G',
    'গ্রুপ H',
  ];

  final List<String> _availableCrops = [
    'Balsam Apple',
    'Banana',
    'Mustard Oil Seed',
    'Tomato',
    'Papaya',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'কৃষক নিবন্ধন',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  margin: EdgeInsets.only(bottom: 32),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFF4CAF50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.agriculture,
                          size: 40,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'কৃষক হিসাবে নিবন্ধন করুন',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'আপনার তথ্য দিয়ে অ্যাকাউন্ট তৈরি করুন',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                // Personal Information Section
                _buildSectionTitle('ব্যক্তিগত তথ্য'),
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _nameController,
                  label: 'পূর্ণ নাম',
                  hint: 'আপনার পূর্ণ নাম লিখুন',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'নাম প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _phoneController,
                  label: 'ফোন নম্বর',
                  hint: '০১৭১২-৩৪৫৬৭৮',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ফোন নম্বর প্রয়োজন';
                    }
                    if (value.length < 11) {
                      return 'সঠিক ফোন নম্বর লিখুন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _emailController,
                  label: 'ইমেইল (ঐচ্ছিক)',
                  hint: 'example@email.com',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _addressController,
                  label: 'ঠিকানা',
                  hint: 'গ্রাম, ইউনিয়ন, জেলা',
                  icon: Icons.location_on,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ঠিকানা প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 32),
                
                // Farming Information Section
                _buildSectionTitle('কৃষি তথ্য'),
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _landAreaController,
                  label: 'মোট জমির পরিমাণ (শতাংশ)',
                  hint: '৫২',
                  icon: Icons.agriculture,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'জমির পরিমাণ প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                // GPS Location Section
                _buildSectionTitle('জিপিএস অবস্থান'),
                SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _latitudeController,
                        label: 'অক্ষাংশ',
                        hint: '২৩.৭৯৩৭',
                        icon: Icons.location_on,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'অক্ষাংশ প্রয়োজন';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _longitudeController,
                        label: 'দ্রাঘিমাংশ',
                        hint: '৯০.৪০৬৬',
                        icon: Icons.location_on,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'দ্রাঘিমাংশ প্রয়োজন';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16),
                
                Container(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _isGettingLocation ? null : _getCurrentLocation,
                    icon: _isGettingLocation 
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(Icons.my_location, color: Color(0xFF4CAF50)),
                    label: Text(
                      _isGettingLocation ? 'অবস্থান পাওয়া হচ্ছে...' : 'বর্তমান অবস্থান ব্যবহার করুন',
                      style: TextStyle(color: Color(0xFF4CAF50)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF4CAF50)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Crop Selection Section
                _buildSectionTitle('সম্ভাব্য ফসলসমূহ'),
                SizedBox(height: 16),
                
                Text(
                  'আপনি যে ফসলগুলো চাষ করতে চান সেগুলো নির্বাচন করুন:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                
                SizedBox(height: 16),
                
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _availableCrops.map((crop) {
                    bool isSelected = _selectedCrops.contains(crop);
                    return FilterChip(
                      label: Text(crop),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            _selectedCrops.add(crop);
                          } else {
                            _selectedCrops.remove(crop);
                          }
                        });
                      },
                      selectedColor: Color(0xFF4CAF50).withOpacity(0.2),
                      checkmarkColor: Color(0xFF4CAF50),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey[300]!),
                      labelStyle: TextStyle(
                        color: isSelected ? Color(0xFF4CAF50) : Colors.grey[700],
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
                
                SizedBox(height: 16),
                
                if (_selectedCrops.isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFF4CAF50).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Color(0xFF4CAF50),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'নির্বাচিত ফসলসমূহ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          _selectedCrops.join(', '),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _experienceController,
                  label: 'কৃষি অভিজ্ঞতা (বছর)',
                  hint: '১০',
                  icon: Icons.work,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'অভিজ্ঞতা প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 32),
                
                // Group Assignment Section
                _buildSectionTitle('গ্রুপ নির্ধারণ'),
                SizedBox(height: 16),
                
                _buildDropdownField(
                  label: 'আপনার গ্রুপ নির্বাচন করুন',
                  icon: Icons.group,
                  value: _selectedGroup,
                  items: _availableGroups,
                  onChanged: (value) {
                    setState(() {
                      _selectedGroup = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'গ্রুপ নির্বাচন করুন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 12),
                
                // Group Information Card
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFF4CAF50).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Color(0xFF4CAF50),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'গ্রুপ সম্পর্কে তথ্য',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'আপনার নির্বাচিত গ্রুপে একজন কৃষি পরিদর্শক থাকবেন যিনি আপনাকে পরামর্শ দিবেন। গ্রুপের অন্যান্য কৃষকদের সাথে আপনি অভিজ্ঞতা বিনিময় করতে পারবেন।',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 32),
                
                // Account Information Section
                _buildSectionTitle('অ্যাকাউন্ট তথ্য'),
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _passwordController,
                  label: 'পাসওয়ার্ড',
                  hint: 'কমপক্ষে ৬ অক্ষর',
                  icon: Icons.lock,
                  isPassword: true,
                  isPasswordVisible: _isPasswordVisible,
                  onPasswordVisibilityChanged: (value) {
                    setState(() {
                      _isPasswordVisible = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'পাসওয়ার্ড প্রয়োজন';
                    }
                    if (value.length < 6) {
                      return 'পাসওয়ার্ড কমপক্ষে ৬ অক্ষর হতে হবে';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'পাসওয়ার্ড নিশ্চিত করুন',
                  hint: 'পাসওয়ার্ড আবার লিখুন',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  isPasswordVisible: _isConfirmPasswordVisible,
                  onPasswordVisibilityChanged: (value) {
                    setState(() {
                      _isConfirmPasswordVisible = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'পাসওয়ার্ড নিশ্চিত করুন';
                    }
                    if (value != _passwordController.text) {
                      return 'পাসওয়ার্ড মিলছে না';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 32),
                
                // Terms and Conditions
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: Color(0xFF4CAF50),
                    ),
                    Expanded(
                      child: Text(
                        'আমি ব্যবহারের শর্তাবলী এবং গোপনীয়তা নীতি মেনে চলতে সম্মত',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 32),
                
                // Register Button
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegistration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'নিবন্ধন করুন',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Login Link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ইতিমধ্যে একটি অ্যাকাউন্ট আছে? ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'লগইন করুন',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    bool isPassword = false,
    bool isPasswordVisible = false,
    Function(bool)? onPasswordVisibilityChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: isPassword && !isPasswordVisible,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Color(0xFF4CAF50)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  onPasswordVisibilityChanged?.call(!isPasswordVisible);
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF4CAF50)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  void _getCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });
    
    try {
      // Simulate getting GPS location
      await Future.delayed(Duration(seconds: 2));
      
      // Mock GPS coordinates (Dhaka, Bangladesh)
      _latitudeController.text = '23.7937';
      _longitudeController.text = '90.4066';
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('বর্তমান অবস্থান পাওয়া গেছে!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('অবস্থান পাওয়া যায়নি। দয়া করে ম্যানুয়ালি লিখুন।'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  void _handleRegistration() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedCrops.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('অন্তত একটি ফসল নির্বাচন করুন'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('নিবন্ধন সফল হয়েছে!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      
      // Navigate to main app
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    _landAreaController.dispose();
    _experienceController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }
}
