import 'package:flutter/material.dart';

class AdminRegistrationPage extends StatefulWidget {
  @override
  _AdminRegistrationPageState createState() => _AdminRegistrationPageState();
}

class _AdminRegistrationPageState extends State<AdminRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _organizationController = TextEditingController();
  final _designationController = TextEditingController();
  final _adminCodeController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  String _selectedOrganization = 'কৃষি মন্ত্রণালয়';

  final List<String> _organizations = [
    'কৃষি মন্ত্রণালয়',
    'কৃষি সম্প্রসারণ অধিদপ্তর',
    'কৃষি গবেষণা ইনস্টিটিউট',
    'কৃষি বিশ্ববিদ্যালয়',
    'জেলা কৃষি অফিস',
    'উপজেলা কৃষি অফিস',
    'অন্যান্য',
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
          'প্রশাসক নিবন্ধন',
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
                          color: Color(0xFF9C27B0).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.admin_panel_settings,
                          size: 40,
                          color: Color(0xFF9C27B0),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'প্রশাসক হিসাবে নিবন্ধন করুন',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'সিস্টেম পরিচালনার জন্য আপনার তথ্য দিন',
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
                  hint: 'admin@krishimanage.gov.bd',
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
                  label: 'সংস্থা/মন্ত্রণালয়',
                  icon: Icons.business,
                  value: _selectedOrganization,
                  items: _organizations,
                  onChanged: (value) {
                    setState(() {
                      _selectedOrganization = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'সংস্থা নির্বাচন করুন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _designationController,
                  label: 'পদবি',
                  hint: 'উপপরিচালক, সহকারী পরিচালক',
                  icon: Icons.work,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'পদবি প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _organizationController,
                  label: 'বিভাগ/ইউনিট',
                  hint: 'কৃষি সম্প্রসারণ বিভাগ',
                  icon: Icons.account_tree,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'বিভাগের নাম প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 32),
                
                // Admin Code Section
                _buildSectionTitle('প্রশাসক কোড'),
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _adminCodeController,
                  label: 'প্রশাসক কোড',
                  hint: 'ADMIN-2024-001',
                  icon: Icons.security,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'প্রশাসক কোড প্রয়োজন';
                    }
                    if (value.length < 8) {
                      return 'সঠিক প্রশাসক কোড লিখুন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 32),
                
                // Account Information Section
                _buildSectionTitle('অ্যাকাউন্ট তথ্য'),
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _passwordController,
                  label: 'পাসওয়ার্ড',
                  hint: 'কমপক্ষে ১০ অক্ষর',
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
                    if (value.length < 10) {
                      return 'পাসওয়ার্ড কমপক্ষে ১০ অক্ষর হতে হবে';
                    }
                    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]').hasMatch(value)) {
                      return 'পাসওয়ার্ডে বড় হাতের অক্ষর, ছোট হাতের অক্ষর, সংখ্যা এবং বিশেষ অক্ষর থাকতে হবে';
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
                      activeColor: Color(0xFF9C27B0),
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
                
                SizedBox(height: 16),
                
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: Color(0xFF9C27B0),
                    ),
                    Expanded(
                      child: Text(
                        'আমি সিস্টেমের নিরাপত্তা নীতি মেনে চলতে সম্মত',
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
                      backgroundColor: Color(0xFF9C27B0),
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
                            color: Color(0xFF9C27B0),
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
        prefixIcon: Icon(icon, color: Color(0xFF9C27B0)),
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
          borderSide: BorderSide(color: Color(0xFF9C27B0), width: 2),
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
        prefixIcon: Icon(icon, color: Color(0xFF9C27B0)),
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
          borderSide: BorderSide(color: Color(0xFF9C27B0), width: 2),
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
          backgroundColor: Color(0xFF9C27B0),
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
    _organizationController.dispose();
    _designationController.dispose();
    _adminCodeController.dispose();
    super.dispose();
  }
}
