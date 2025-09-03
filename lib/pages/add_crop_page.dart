import 'package:flutter/material.dart';

class AddCropPage extends StatefulWidget {
  const AddCropPage({super.key});

  @override
  _AddCropPageState createState() => _AddCropPageState();
}

class _AddCropPageState extends State<AddCropPage> {
  final _formKey = GlobalKey<FormState>();
  final _cropNameController = TextEditingController();
  final _varietyController = TextEditingController();
  final _quantityController = TextEditingController();
  final _notesController = TextEditingController();
  
  bool _isLoading = false;
  String _selectedCropType = 'ধান';
  String _selectedSeason = 'রবি';
  String _selectedLand = 'জমি ১';
  String _selectedStatus = 'রোপণ শেষ';

  
  final List<String> _cropTypes = [
    'ধান',
    'গম',
    'ভুট্টা',
    'আলু',
    'টমেটো',
    'পেঁয়াজ',
    'রসুন',
    'মরিচ',
    'বেগুন',
    'লাউ',
    'কুমড়া',
    'শসা',
    'পাট',
    'তামাক',
    'চা',
    'অন্যান্য',
  ];
  
  final List<String> _seasons = [
    'রবি',
    'খরিফ',
    'জায়েদ',
    'বর্ষা',
    'শীত',
    'গ্রীষ্ম',
  ];
  
  final List<String> _lands = [
    'জমি ১',
    'জমি ২',
    'জমি ৩',
    'নতুন জমি',
  ];
  
  final List<String> _statuses = [
    'রোপণ শেষ',
    'বপন সম্পন্ন',
    'চারা প্রস্তুত',
    'পরিকল্পিত',
    'সম্পন্ন',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'নতুন ফসল যোগ করুন',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: const Color(0xFF4CAF50)),
            onPressed: _showHelpDialog,
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
                          Icons.grass,
                          size: 40,
                          color: const Color(0xFF4CAF50),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'নতুন ফসলের তথ্য যোগ করুন',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'ফসলের ধরন, মৌসুম এবং জমি নির্বাচন করুন',
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
                  controller: _cropNameController,
                  label: 'ফসলের নাম',
                  hint: 'উচ্চ ফলনশীল ধান',
                  icon: Icons.grass,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ফসলের নাম প্রয়োজন';
                    }
                    return null;
                  },
                ),
                
                SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownField(
                        label: 'ফসলের ধরন',
                        icon: Icons.category,
                        value: _selectedCropType,
                        items: _cropTypes,
                        onChanged: (value) {
                          setState(() {
                            _selectedCropType = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ফসলের ধরন নির্বাচন করুন';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdownField(
                        label: 'মৌসুম',
                        icon: Icons.calendar_today,
                        value: _selectedSeason,
                        items: _seasons,
                        onChanged: (value) {
                          setState(() {
                            _selectedSeason = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'মৌসুম নির্বাচন করুন';
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
                      child: _buildDropdownField(
                        label: 'জমি নির্বাচন',
                        icon: Icons.landscape,
                        value: _selectedLand,
                        items: _lands,
                        onChanged: (value) {
                          setState(() {
                            _selectedLand = value!;
                            if (value == 'নতুন জমি যোগ করুন') {
                              Navigator.pushNamed(context, '/land-location');
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'জমি নির্বাচন করুন';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdownField(
                        label: 'অবস্থা',
                        icon: Icons.info,
                        value: _selectedStatus,
                        items: _statuses,
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'অবস্থা নির্বাচন করুন';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _varietyController,
                  label: 'ফসলের জাত/ভ্যারাইটি',
                  hint: 'বিআর-২৮, বিআর-২৯, ইত্যাদি',
                  icon: Icons.science,
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _quantityController,
                  label: 'পরিমাণ (কেজি/একর)',
                  hint: '৫০',
                  icon: Icons.scale,
                  keyboardType: TextInputType.number,
                ),
                
                SizedBox(height: 24),
                
                // Planting Information Section
                _buildSectionTitle('রোপণ তথ্য'),
                SizedBox(height: 16),
                
                _buildDateField(
                  label: 'রোপণের তারিখ',
                  icon: Icons.event,
                  onTap: () => _selectDate(context),
                ),
                
                SizedBox(height: 16),
                
                _buildTextField(
                  controller: _notesController,
                  label: 'বিশেষ নোট',
                  hint: 'সার, সেচ, কীটনাশক সম্পর্কিত তথ্য',
                  icon: Icons.note,
                  maxLines: 4,
                ),
                
                SizedBox(height: 32),
                
                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
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
                            'ফসল সংরক্ষণ করুন',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // View Crops Link
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cropping');
                    },
                    child: Text(
                      'আমার সব ফসল দেখুন',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4CAF50),
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
        prefixIcon: Icon(icon, color: const Color(0xFF4CAF50)),
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
          borderSide: BorderSide(color: const Color(0xFF4CAF50), width: 2),
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
        prefixIcon: Icon(icon, color: const Color(0xFF4CAF50)),
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
          borderSide: BorderSide(color: const Color(0xFF4CAF50), width: 2),
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

  Widget _buildDateField({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF4CAF50)),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'তারিখ নির্বাচন করুন',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.calendar_today, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: Locale('bn', 'BD'),
    );
    if (picked != null) {
      // Handle selected date
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('রোপণের তারিখ নির্বাচিত: ${picked.day}/${picked.month}/${picked.year}'),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('সাহায্য'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ফসল যোগ করার জন্য:'),
              SizedBox(height: 8),
              Text('• ফসলের নাম এবং ধরন নির্বাচন করুন'),
              Text('• মৌসুম এবং জমি নির্বাচন করুন'),
              Text('• রোপণের তারিখ নির্বাচন করুন'),
              Text('• প্রয়োজনীয় তথ্য পূরণ করুন'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('বুঝেছি'),
            ),
          ],
        );
      },
    );
  }

  void _handleSave() async {
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
          content: Text('ফসলের তথ্য সফলভাবে সংরক্ষিত হয়েছে!'),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
      
      // Navigate back
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _cropNameController.dispose();
    _varietyController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
