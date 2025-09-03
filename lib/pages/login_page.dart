import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  
  String _selectedUserType = 'farmer';
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isOtpSent = false;
  bool _isOtpVerified = false;
  int _otpResendTimer = 30;
  bool _canResendOtp = false;
  
  final List<String> _userTypes = ['farmer', 'supervisor', 'admin'];
  
  final Map<String, String> _userTypeLabels = {
    'farmer': 'কৃষক',
    'supervisor': 'কৃষি পরিদর্শক',
    'admin': 'অ্যাডমিন'
  };
  
  final Map<String, IconData> _userTypeIcons = {
    'farmer': Icons.agriculture,
    'supervisor': Icons.supervisor_account,
    'admin': Icons.admin_panel_settings,
  };

  @override
  void initState() {
    super.initState();
    _startOtpTimer();
  }

  void _startOtpTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_otpResendTimer > 0) {
            _otpResendTimer--;
            _startOtpTimer();
          } else {
            _canResendOtp = true;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                              Text(
                                'লগইন করুন',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'আপনার অ্যাকাউন্টে প্রবেশ করুন',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        // User Type Selection
                        _buildSectionTitle('ব্যবহারকারীর ধরন'),
                        SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          child: DropdownButtonFormField<String>(
                            value: _selectedUserType,
                            decoration: InputDecoration(
                              labelText: 'ব্যবহারকারীর ধরন নির্বাচন করুন',
                              prefixIcon: Icon(Icons.person, color: Color(0xFF4CAF50)),
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
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: _userTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Row(
                                  children: [
                                    Icon(_userTypeIcons[type]!, color: Color(0xFF4CAF50)),
                                    SizedBox(width: 12),
                                    Text(_userTypeLabels[type]!),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedUserType = value!;
                                _isOtpSent = false;
                                _isOtpVerified = false;
                                _otpResendTimer = 30;
                                _canResendOtp = false;
                                _startOtpTimer();
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ব্যবহারকারীর ধরন নির্বাচন করুন';
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 24),

                        // Phone Number
                        _buildSectionTitle('ফোন নম্বর'),
                        SizedBox(height: 16),

                        _buildTextField(
                          controller: _phoneController,
                          label: 'ফোন নম্বর',
                          hint: '০১৭১২-৩৪৫৬৭৮',
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
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

                        SizedBox(height: 24),

                        // Authentication Method
                        if (_selectedUserType == 'farmer') ...[
                          // OTP Section for Farmers
                          _buildSectionTitle('ওটিপি যাচাইকরণ'),
                          SizedBox(height: 16),

                          if (!_isOtpSent) ...[
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _sendOtp,
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
                                        'ওটিপি পাঠান',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ] else ...[
                            _buildTextField(
                              controller: _otpController,
                              label: 'ওটিপি কোড',
                              hint: '৬ অঙ্কের কোড লিখুন',
                              icon: Icons.security,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'ওটিপি কোড প্রয়োজন';
                                }
                                if (value.length != 6) {
                                  return '৬ অঙ্কের কোড লিখুন';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _verifyOtp,
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
                                            'ওটিপি যাচাই করুন',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                OutlinedButton(
                                  onPressed: _canResendOtp ? _resendOtp : null,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Color(0xFF4CAF50)),
                                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    _canResendOtp ? 'পুনরায় পাঠান' : '${_otpResendTimer}s',
                                    style: TextStyle(
                                      color: _canResendOtp ? Color(0xFF4CAF50) : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ] else ...[
                          // Password Section for Supervisors and Admins
                          _buildSectionTitle('পাসওয়ার্ড'),
                          SizedBox(height: 16),

                          _buildTextField(
                            controller: _passwordController,
                            label: 'পাসওয়ার্ড',
                            hint: 'আপনার পাসওয়ার্ড লিখুন',
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
                              return null;
                            },
                          ),
                        ],

                        SizedBox(height: 32),

                        // Login Button
                        if ((_selectedUserType == 'farmer' && _isOtpVerified) ||
                            (_selectedUserType != 'farmer')) ...[
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
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
                                      'লগইন করুন',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ],

                        SizedBox(height: 24),

                        // Registration Link
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'অ্যাকাউন্ট নেই? ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/user_type_selection');
                                },
                                child: Text(
                                  'নিবন্ধন করুন',
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

                        SizedBox(height: 16),

                        // Forgot Password (for supervisors and admins)
                        if (_selectedUserType != 'farmer') ...[
                          Center(
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('পাসওয়ার্ড পুনরুদ্ধার বৈশিষ্ট্য শীঘ্রই আসছে'),
                                    backgroundColor: Colors.orange,
                                  ),
                                );
                              },
                              child: Text(
                                'পাসওয়ার্ড ভুলে গেছেন?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF4CAF50),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Center(
                  child: Image.asset(
                    'assets/images/waziup.png',
                    height: 80,
                  ),
                ),
              ),
            ],
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
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    bool isPassword = false,
    bool isPasswordVisible = false,
    Function(bool)? onPasswordVisibilityChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
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

  void _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate OTP sending
      await Future.delayed(Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
        _isOtpSent = true;
        _otpResendTimer = 30;
        _canResendOtp = false;
      });
      
      _startOtpTimer();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ওটিপি পাঠানো হয়েছে: 123456'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    }
  }

  void _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate OTP verification
      await Future.delayed(Duration(seconds: 1));
      
      setState(() {
        _isLoading = false;
        _isOtpVerified = true;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ওটিপি যাচাইকরণ সফল!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    }
  }

  void _resendOtp() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate OTP resending
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      _isLoading = false;
      _otpResendTimer = 30;
      _canResendOtp = false;
    });
    
    _startOtpTimer();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('ওটিপি পুনরায় পাঠানো হয়েছে: 123456'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate login process
      await Future.delayed(Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('লগইন সফল হয়েছে!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      
      // Navigate to main app
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}
