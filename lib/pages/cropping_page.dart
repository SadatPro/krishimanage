import 'package:flutter/material.dart';

class CroppingPage extends StatefulWidget {
  @override
  _CroppingPageState createState() => _CroppingPageState();
}

class _CroppingPageState extends State<CroppingPage> {
  final List<Map<String, dynamic>> cropData = [
    {
      'name': 'ধান',
      'land': 'জমি ১',
      'plantingDate': '১৫ জুন, ২০২৪',
      'harvestDate': '১৫ সেপ্টেম্বর, ২০২৪',
      'status': 'বর্ধমান',
      'progress': 0.75,
      'color': Color(0xFF4CAF50),
      'icon': Icons.grass,
    },
    {
      'name': 'গম',
      'land': 'জমি ২',
      'plantingDate': '১ নভেম্বর, ২০২৪',
      'harvestDate': '১৫ মার্চ, ২০২৫',
      'status': 'বর্ধমান',
      'progress': 0.45,
      'color': Color(0xFF8BC34A),
      'icon': Icons.grain,
    },
    {
      'name': 'আলু',
      'land': 'জমি ৩',
      'plantingDate': '১ অক্টোবর, ২০২৪',
      'harvestDate': '১৫ জানুয়ারি, ২০২৫',
      'status': 'প্রায় সম্পন্ন',
      'progress': 0.90,
      'color': Color(0xFFFF9800),
      'icon': Icons.crop_square,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.grass,
                    size: 30,
                    color: Color(0xFF4CAF50),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'ফসল ব্যবস্থাপনা',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.add, color: Color(0xFF4CAF50)),
                    onPressed: () {
                      _showAddCropDialog(context);
                    },
                  ),
                ],
              ),
            ),
            
            // Summary Cards
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'সক্রিয় ফসল',
                      value: '৩টি',
                      icon: Icons.grass,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'মোট আয়',
                      value: '৳ ১,২০,০০০',
                      icon: Icons.attach_money,
                      color: Color(0xFFFF9800),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'গড় ফলন',
                      value: '২.৮ টন/একর',
                      icon: Icons.trending_up,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                ],
              ),
            ),
            
            // Crop List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: cropData.length,
                itemBuilder: (context, index) {
                  return _buildCropCard(cropData[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCropCard(Map<String, dynamic> crop, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: crop['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    crop['icon'],
                    color: crop['color'],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        crop['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        crop['land'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('সম্পাদনা'),
                        ],
                      ),
                      value: 'edit',
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20),
                          SizedBox(width: 8),
                          Text('মুছুন'),
                        ],
                      ),
                      value: 'delete',
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditCropDialog(context, crop, index);
                    } else if (value == 'delete') {
                      _showDeleteConfirmation(context, index);
                    }
                  },
                ),
              ],
            ),
          ),
          
          // Progress Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'অগ্রগতি',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      '${(crop['progress'] * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: crop['color'],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: crop['progress'],
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(crop['color']),
                  minHeight: 8,
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          
          // Details
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem(
                        icon: Icons.calendar_today,
                        label: 'রোপণের তারিখ',
                        value: crop['plantingDate'],
                      ),
                    ),
                    Expanded(
                      child: _buildDetailItem(
                        icon: Icons.cut,
                        label: 'ফসল কাটার তারিখ',
                        value: crop['harvestDate'],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: crop['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    crop['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: crop['color'],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.grey[600],
            ),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  void _showAddCropDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('নতুন ফসল যোগ করুন'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'ফসলের নাম',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'জমির নাম',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'রোপণের তারিখ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'ফসল কাটার তারিখ',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('বাতিল'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add crop logic here
              Navigator.pop(context);
            },
            child: Text('যোগ করুন'),
          ),
        ],
      ),
    );
  }

  void _showEditCropDialog(BuildContext context, Map<String, dynamic> crop, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ফসল সম্পাদনা করুন'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'ফসলের নাম',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: crop['name']),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'জমির নাম',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: crop['land']),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'রোপণের তারিখ',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: crop['plantingDate']),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'ফসল কাটার তারিখ',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: crop['harvestDate']),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('বাতিল'),
          ),
          ElevatedButton(
            onPressed: () {
              // Edit crop logic here
              Navigator.pop(context);
            },
            child: Text('আপডেট'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ফসল মুছুন'),
        content: Text('আপনি কি নিশ্চিত যে আপনি এই ফসলটি মুছতে চান?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('না'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                cropData.removeAt(index);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('হ্যাঁ, মুছুন'),
          ),
        ],
      ),
    );
  }
}
