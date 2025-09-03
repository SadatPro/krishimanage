import 'package:flutter/material.dart';

class WaterDataPage extends StatefulWidget {
  @override
  _WaterDataPageState createState() => _WaterDataPageState();
}

class _WaterDataPageState extends State<WaterDataPage> {
  final List<Map<String, dynamic>> waterData = [
    {
      'land': 'জমি ১',
      'waterSource': 'নলকূপ',
      'irrigationType': 'স্প্রিংকলার',
      'lastIrrigation': '২ দিন আগে',
      'nextIrrigation': '৩ দিন পর',
      'waterLevel': 'মাঝারি',
      'quality': 'উত্তম',
      'color': Color(0xFF4CAF50),
    },
    {
      'land': 'জমি ২',
      'waterSource': 'পুকুর',
      'irrigationType': 'ফ্লাড',
      'lastIrrigation': '১ দিন আগে',
      'nextIrrigation': '২ দিন পর',
      'waterLevel': 'উচ্চ',
      'quality': 'ভাল',
      'color': Color(0xFF2196F3),
    },
    {
      'land': 'জমি ৩',
      'waterSource': 'ক্যানাল',
      'irrigationType': 'ড্রিপ',
      'lastIrrigation': '৪ দিন আগে',
      'nextIrrigation': 'আজ',
      'waterLevel': 'নিম্ন',
      'quality': 'মাঝারি',
      'color': Color(0xFFFF9800),
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
                    Icons.water_drop,
                    size: 30,
                    color: Color(0xFF2196F3),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'পানি ব্যবস্থাপনা',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.add, color: Color(0xFF2196F3)),
                    onPressed: () {
                      _showAddWaterDataDialog(context);
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
                      title: 'সেচ প্রয়োজন',
                      value: '২টি জমি',
                      icon: Icons.water_drop,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'গড় পানির মান',
                      value: 'ভাল',
                      icon: Icons.eco,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'মোট সেচ',
                      value: '১২ বার',
                      icon: Icons.trending_up,
                      color: Color(0xFFFF9800),
                    ),
                  ),
                ],
              ),
            ),
            
            // Water Data List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: waterData.length,
                itemBuilder: (context, index) {
                  return _buildWaterDataCard(waterData[index], index);
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

  Widget _buildWaterDataCard(Map<String, dynamic> water, int index) {
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
                    color: water['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.water_drop,
                    color: water['color'],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        water['land'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        'উৎস: ${water['waterSource']}',
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
                      _showEditWaterDataDialog(context, water, index);
                    } else if (value == 'delete') {
                      _showDeleteConfirmation(context, index);
                    }
                  },
                ),
              ],
            ),
          ),
          
          // Water Properties
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
                      child: _buildPropertyItem(
                        icon: Icons.water_drop,
                        label: 'সেচের ধরন',
                        value: water['irrigationType'],
                        color: Color(0xFF2196F3),
                      ),
                    ),
                    Expanded(
                      child: _buildPropertyItem(
                        icon: Icons.calendar_today,
                        label: 'শেষ সেচ',
                        value: water['lastIrrigation'],
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildPropertyItem(
                        icon: Icons.schedule,
                        label: 'পরবর্তী সেচ',
                        value: water['nextIrrigation'],
                        color: Color(0xFFFF9800),
                      ),
                    ),
                    Expanded(
                      child: _buildPropertyItem(
                        icon: Icons.height,
                        label: 'পানির স্তর',
                        value: water['waterLevel'],
                        color: _getWaterLevelColor(water['waterLevel']),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildPropertyItem(
                        icon: Icons.eco,
                        label: 'পানির মান',
                        value: water['quality'],
                        color: _getQualityColor(water['quality']),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getIrrigationStatusColor(water['nextIrrigation']).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getIrrigationStatus(water['nextIrrigation']),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getIrrigationStatusColor(water['nextIrrigation']),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: color,
            ),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getWaterLevelColor(String level) {
    switch (level) {
      case 'উচ্চ':
        return Color(0xFF4CAF50);
      case 'মাঝারি':
        return Color(0xFFFF9800);
      case 'নিম্ন':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getQualityColor(String quality) {
    switch (quality) {
      case 'উত্তম':
        return Color(0xFF4CAF50);
      case 'ভাল':
        return Color(0xFF8BC34A);
      case 'মাঝারি':
        return Color(0xFFFF9800);
      case 'খারাপ':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getIrrigationStatus(String nextIrrigation) {
    if (nextIrrigation == 'আজ') return 'সেচ প্রয়োজন';
    if (nextIrrigation.contains('দিন পর')) return 'শীঘ্রই সেচ';
    return 'সেচ সম্পন্ন';
  }

  Color _getIrrigationStatusColor(String nextIrrigation) {
    if (nextIrrigation == 'আজ') return Colors.red;
    if (nextIrrigation.contains('দিন পর')) return Color(0xFFFF9800);
    return Color(0xFF4CAF50);
  }

  void _showAddWaterDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('নতুন পানি তথ্য যোগ করুন'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'জমির নাম',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'পানির উৎস',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'সেচের ধরন',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'শেষ সেচের তারিখ',
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
              // Add water data logic here
              Navigator.pop(context);
            },
            child: Text('যোগ করুন'),
          ),
        ],
      ),
    );
  }

  void _showEditWaterDataDialog(BuildContext context, Map<String, dynamic> water, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('পানি তথ্য সম্পাদনা করুন'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'জমির নাম',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: water['land']),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'পানির উৎস',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: water['waterSource']),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'সেচের ধরন',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: water['irrigationType']),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'শেষ সেচের তারিখ',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: water['lastIrrigation']),
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
              // Edit water data logic here
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
        title: Text('পানি তথ্য মুছুন'),
        content: Text('আপনি কি নিশ্চিত যে আপনি এই পানি তথ্যটি মুছতে চান?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('না'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                waterData.removeAt(index);
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
