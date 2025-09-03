import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class LandLocationPage extends StatefulWidget {
  @override
  _LandLocationPageState createState() => _LandLocationPageState();
}

class _LandLocationPageState extends State<LandLocationPage> {
  final _formKey = GlobalKey<FormState>();
  final _landNameController = TextEditingController();
  final _landAreaController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  bool _isLoading = false;
  bool _isGettingLocation = false;
  bool _isMapVisible = false;
  String _selectedLandType = 'ধান জমি';
  String _selectedSoilType = 'দোআঁশ মাটি';
  List<Offset> _landBoundary = [];
  bool _isDrawingBoundary = false;
  
  final List<String> _landTypes = [
    'ধান জমি',
    'গম জমি',
    'সবজি জমি',
    'ফল বাগান',
    'মিশ্র জমি',
    'অন্যান্য',
  ];
  
  final List<String> _soilTypes = [
    'দোআঁশ মাটি',
    'বেলে মাটি',
    'কাদা মাটি',
    'পাথুরে মাটি',
    'লাল মাটি',
    'অন্যান্য',
  ];

  @override
  void initState() {
    super.initState();
    _initializeMockBoundary();
  }

  void _initializeMockBoundary() {
    // Create a mock rectangular boundary
    _landBoundary = [
      Offset(50, 50),
      Offset(250, 50),
      Offset(250, 200),
      Offset(50, 200),
    ];
  }

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
          'জমির অবস্থান যোগ করুন',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.map, color: Color(0xFF4CAF50)),
            onPressed: () {
              setState(() {
                _isMapVisible = !_isMapVisible;
              });
            },
          ),
        ],
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
                  margin: EdgeInsets.only(bottom: 24),
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
                          Icons.location_on,
                          size: 40,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'নতুন জমির তথ্য যোগ করুন',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'জমির অবস্থান, আকার এবং বিবরণ দিন',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                
                // Basic Information Section
                _buildSectionTitle('মৌলিক তথ্য'),
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _landNameController,
                  label: 'জমির নাম',
                  hint: 'আমার ধান জমি',
                  icon: Icons.agriculture,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'জমির নাম প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownField(
                        label: 'জমির ধরন',
                        icon: Icons.category,
                        value: _selectedLandType,
                        items: _landTypes,
                        onChanged: (value) {
                          setState(() {
                            _selectedLandType = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'জমির ধরন নির্বাচন করুন';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdownField(
                        label: 'মাটির ধরন',
                        icon: Icons.terrain,
                        value: _selectedSoilType,
                        items: _soilTypes,
                        onChanged: (value) {
                          setState(() {
                            _selectedSoilType = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'মাটির ধরন নির্বাচন করুন';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _landAreaController,
                  label: 'জমির আকার (শতাংশ)',
                  hint: '৫২',
                  icon: Icons.straighten,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'জমির আকার প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 24),
                
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
                        icon: Icons.gps_fixed,
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
                        icon: Icons.gps_fixed,
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
                
                Row(
                  children: [
                    Expanded(
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
                          _isGettingLocation ? 'অবস্থান পাওয়া হচ্ছে...' : 'বর্তমান অবস্থান',
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
                    SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isMapVisible ? _openMapPicker : null,
                        icon: Icon(Icons.map, color: Color(0xFF4CAF50)),
                        label: Text(
                          'মানচিত্র থেকে নির্বাচন',
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
                  ],
                ),
                
                SizedBox(height: 24),
                
                // Address Section
                _buildSectionTitle('ঠিকানা'),
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _addressController,
                  label: 'বিস্তারিত ঠিকানা',
                  hint: 'গ্রাম, ইউনিয়ন, জেলা, বিভাগ',
                  icon: Icons.location_city,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ঠিকানা প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 24),
                
                // Interactive Map Section
                if (_isMapVisible) ...[
                  _buildSectionTitle('ইন্টারেক্টিভ মানচিত্র'),
                  SizedBox(height: 16),
                  
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          // Mock Map Background
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFE8F5E8),
                                  Color(0xFFF1F8E9),
                                  Color(0xFFE8F5E8),
                                ],
                              ),
                            ),
                            child: CustomPaint(
                              painter: MapGridPainter(),
                            ),
                          ),
                          
                          // Land Boundary Drawing
                          CustomPaint(
                            painter: LandBoundaryPainter(
                              boundary: _landBoundary,
                              isDrawing: _isDrawingBoundary,
                            ),
                          ),
                          
                          // Interactive Drawing Area
                          GestureDetector(
                            onPanUpdate: _isDrawingBoundary ? _onPanUpdate : null,
                            onPanStart: _isDrawingBoundary ? _onPanStart : null,
                            onPanEnd: _isDrawingBoundary ? _onPanEnd : null,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.transparent,
                            ),
                          ),
                          
                          // Map Controls
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Column(
                              children: [
                                FloatingActionButton.small(
                                  onPressed: () {
                                    setState(() {
                                      _isDrawingBoundary = !_isDrawingBoundary;
                                    });
                                  },
                                  backgroundColor: _isDrawingBoundary 
                                      ? Color(0xFF4CAF50) 
                                      : Colors.white,
                                  child: Icon(
                                    _isDrawingBoundary ? Icons.stop : Icons.edit,
                                    color: _isDrawingBoundary 
                                        ? Colors.white 
                                        : Color(0xFF4CAF50),
                                  ),
                                ),
                                SizedBox(height: 8),
                                FloatingActionButton.small(
                                  onPressed: _clearBoundary,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Instructions
                          if (!_isDrawingBoundary) ...[
                            Positioned(
                              bottom: 16,
                              left: 16,
                              right: 16,
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'জমির সীমানা আঁকতে "সম্পাদনা" বোতামে ট্যাপ করুন',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Boundary Information
                  if (_landBoundary.length > 2) ...[
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
                                Icons.polyline,
                                color: Color(0xFF4CAF50),
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'জমির সীমানা',
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
                            'মোট বিন্দু: ${_landBoundary.length}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  SizedBox(height: 24),
                ],
                
                // Description Section
                _buildSectionTitle('বিবরণ'),
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _descriptionController,
                  label: 'জমি সম্পর্কে অতিরিক্ত তথ্য',
                  hint: 'জমির বিশেষ বৈশিষ্ট্য, সেচ ব্যবস্থা, রাস্তার অবস্থান ইত্যাদি',
                  icon: Icons.description,
                  maxLines: 4,
                ),
                
                SizedBox(height: 32),
                
                // Save Button
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSave,
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
                            'জমি সংরক্ষণ করুন',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // View Lands Link
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/land-data');
                    },
                    child: Text(
                      'আমার সব জমি দেখুন',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
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
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
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

  void _openMapPicker() {
    // This would open a real map picker
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('মানচিত্র নির্বাচক শীঘ্রই আসছে'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _landBoundary.add(details.localPosition);
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _landBoundary.add(details.localPosition);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    // Close the boundary by connecting to the first point
    if (_landBoundary.isNotEmpty) {
      setState(() {
        _landBoundary.add(_landBoundary.first);
      });
    }
  }

  void _clearBoundary() {
    setState(() {
      _landBoundary.clear();
      _initializeMockBoundary();
    });
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      if (_landBoundary.length < 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('জমির সীমানা আঁকুন (কমপক্ষে ৩ বিন্দু)'),
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
          content: Text('জমির তথ্য সফলভাবে সংরক্ষিত হয়েছে!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      
      // Navigate back
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _landNameController.dispose();
    _landAreaController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

// Custom Painters for Map Visualization
class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    // Draw grid lines
    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LandBoundaryPainter extends CustomPainter {
  final List<Offset> boundary;
  final bool isDrawing;

  LandBoundaryPainter({required this.boundary, required this.isDrawing});

  @override
  void paint(Canvas canvas, Size size) {
    if (boundary.length < 2) return;

    final paint = Paint()
      ..color = isDrawing ? Color(0xFF4CAF50) : Color(0xFF2196F3)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = (isDrawing ? Color(0xFF4CAF50) : Color(0xFF2196F3)).withOpacity(0.2)
      ..style = PaintingStyle.fill;

    // Draw boundary lines
    final path = Path();
    path.moveTo(boundary.first.dx, boundary.first.dy);
    
    for (int i = 1; i < boundary.length; i++) {
      path.lineTo(boundary[i].dx, boundary[i].dy);
    }
    
    if (boundary.length > 2) {
      path.close();
    }

    // Fill the boundary
    canvas.drawPath(path, fillPaint);
    // Draw the boundary lines
    canvas.drawPath(path, paint);

    // Draw boundary points
    final pointPaint = Paint()
      ..color = isDrawing ? Color(0xFF4CAF50) : Color(0xFF2196F3)
      ..style = PaintingStyle.fill;

    for (Offset point in boundary) {
      canvas.drawCircle(point, 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
