import 'package:flutter/material.dart';

class SupervisorRegistrationPage extends StatefulWidget {
  @override
  _SupervisorRegistrationPageState createState() => _SupervisorRegistrationPageState();
}

class _SupervisorRegistrationPageState extends State<SupervisorRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _organizationController = TextEditingController();
  final _maxFarmersController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  String _selectedQualification = 'কৃষি বিজ্ঞান স্নাতক';
  List<String> _selectedGroups = ['গ্রুপ A'];

  final List<String> _qualifications = [
    'কৃষি বিজ্ঞান স্নাতক',
    'কৃষি বিজ্ঞান স্নাতকোত্তর',
    'কৃষি প্রকৌশল স্নাতক',
    'কৃষি প্রকৌশল স্নাতকোত্তর',
    'কৃষি সম্প্রসারণ স্নাতক',
    'অন্যান্য',
  ];

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
          'কৃষি পরিদর্শক নিবন্ধন',
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
                          color: Color(0xFF2196F3).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.supervisor_account,
                          size: 40,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'কৃষি পরিদর্শক হিসাবে নিবন্ধন করুন',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'কৃষকদের সহায়তা করার জন্য আপনার তথ্য দিন',
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
                  label: 'ইমেইল',
                  hint: 'example@email.com',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ইমেইল প্রয়োজন';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'সঠিক ইমেইল লিখুন';
                    }
                    return null;
                  },
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
                
                // Professional Information Section
                _buildSectionTitle('পেশাগত তথ্য'),
                SizedBox(height: 16),
                
                _buildDropdownField(
                  label: 'শিক্ষাগত যোগ্যতা',
                  icon: Icons.school,
                  value: _selectedQualification,
                  items: _qualifications,
                  onChanged: (value) {
                    setState(() {
                      _selectedQualification = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'শিক্ষাগত যোগ্যতা নির্বাচন করুন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _experienceController,
                  label: 'কৃষি পরামর্শ অভিজ্ঞতা (বছর)',
                  hint: '৫',
                  icon: Icons.work,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'অভিজ্ঞতা প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _organizationController,
                  label: 'সংস্থা/কর্মস্থল',
                  hint: 'কৃষি সম্প্রসারণ অধিদপ্তর',
                  icon: Icons.business,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'সংস্থার নাম প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _qualificationController,
                  label: 'বিশেষজ্ঞতা ক্ষেত্র',
                  hint: 'ফসল উৎপাদন, কীটপতঙ্গ ব্যবস্থাপনা',
                  icon: Icons.science,
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'বিশেষজ্ঞতা ক্ষেত্র প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 32),
                
                // Group Management Section
                _buildSectionTitle('গ্রুপ ব্যবস্থাপনা'),
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _maxFarmersController,
                  label: 'সর্বোচ্চ কৃষক সংখ্যা',
                  hint: '৫০',
                  icon: Icons.people,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'কৃষক সংখ্যা প্রয়োজন';
                    }
                    int? number = int.tryParse(value);
                    if (number == null || number <= 0) {
                      return 'সঠিক সংখ্যা লিখুন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                // Group Selection
                Text(
                  'ব্যবস্থাপনা করা গ্রুপসমূহ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                
                // Selected Groups Display
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedGroups.map((group) => Chip(
                    label: Text(group),
                    backgroundColor: Color(0xFF2196F3).withOpacity(0.1),
                    deleteIcon: Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _selectedGroups.remove(group);
                      });
                    },
                  )).toList(),
                ),
                
                SizedBox(height: 12),
                
                // Add Group Button
                Container(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showGroupSelectionDialog();
                    },
                    icon: Icon(Icons.add, color: Color(0xFF2196F3)),
                    label: Text(
                      'গ্রুপ যোগ করুন',
                      style: TextStyle(color: Color(0xFF2196F3)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF2196F3)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 32),
                
                // Account Information Section
                _buildSectionTitle('অ্যাকাউন্ট তথ্য'),
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _passwordController,
                  label: 'পাসওয়ার্ড',
                  hint: 'কমপক্ষে ৮ অক্ষর',
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
                    if (value.length < 8) {
                      return 'পাসওয়ার্ড কমপক্ষে ৮ অক্ষর হতে হবে';
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
                      activeColor: Color(0xFF2196F3),
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
                      backgroundColor: Color(0xFF2196F3),
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
                          // Navigate to login page
                        },
                        child: Text(
                          'লগইন করুন',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2196F3),
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

  void _showGroupSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('গ্রুপ নির্বাচন করুন'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _availableGroups.length,
            itemBuilder: (context, index) {
              String group = _availableGroups[index];
              bool isSelected = _selectedGroups.contains(group);
              
              return CheckboxListTile(
                title: Text(group),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      if (!_selectedGroups.contains(group)) {
                        _selectedGroups.add(group);
                      }
                    } else {
                      _selectedGroups.remove(group);
                    }
                  });
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('বাতিল'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('নিশ্চিত করুন'),
          ),
        ],
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
        prefixIcon: Icon(icon, color: Color(0xFF2196F3)),
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
          borderSide: BorderSide(color: Color(0xFF2196F3), width: 2),
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
        prefixIcon: Icon(icon, color: Color(0xFF2196F3)),
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
          borderSide: BorderSide(color: Color(0xFF2196F3), width: 2),
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

  void _handleRegistration() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedGroups.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('অন্তত একটি গ্রুপ নির্বাচন করুন'),
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
          backgroundColor: Color(0xFF2196F3),
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
    _qualificationController.dispose();
    _experienceController.dispose();
    _organizationController.dispose();
    _maxFarmersController.dispose();
    super.dispose();
  }
}
