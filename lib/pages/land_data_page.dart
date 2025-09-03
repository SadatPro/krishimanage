import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LandDataPage extends StatelessWidget {
  static const List<Map<String, dynamic>> landData = [
    const {
      'name': 'জমি ১',
      'area': '২.৫ একর',
      'location': 'উত্তর পাশ',
      'soilType': 'দোআঁশ',
      'status': 'সক্রিয়',
      'crop': 'ধান',
      'color': const Color(0xFF4CAF50),
      'latitude': '23.7937',
      'longitude': '90.4066',
      'address': 'মোহাম্মদপুর, ঢাকা',
      'soilData': const {
        'pH': '৬.৫',
        'moisture': '৭০%',
        'nitrogen': 'মাঝারি',
        'phosphorus': 'উচ্চ',
        'potassium': 'নিম্ন',
        'recommendation': 'পটাশ সার প্রয়োগ করুন',
      },
    },
    const {
      'name': 'জমি ২',
      'area': '১.৮ একর',
      'location': 'দক্ষিণ পাশ',
      'soilType': 'বেলে দোআঁশ',
      'status': 'সক্রিয়',
      'crop': 'গম',
      'color': const Color(0xFF8BC34A),
      'latitude': '23.8103',
      'longitude': '90.4125',
      'address': 'গুলশান, ঢাকা',
      'soilData': const {
        'pH': '৭.০',
        'moisture': '৬৫%',
        'nitrogen': 'উচ্চ',
        'phosphorus': 'মাঝারি',
        'potassium': 'মাঝারি',
        'recommendation': 'সেচ দেওয়া প্রয়োজন',
      },
    },
    const {
      'name': 'জমি ৩',
      'area': '০.৯ একর',
      'location': 'পূর্ব পাশ',
      'soilType': 'কাদা',
      'status': 'খালি',
      'crop': 'কোন ফসল নেই',
      'color': const Color(0xFF9E9E9E),
      'latitude': '23.7500',
      'longitude': '90.4000',
      'address': 'লালবাগ, ঢাকা',
      'soilData': const {
        'pH': '৬.৮',
        'moisture': '৬০%',
        'nitrogen': 'নিম্ন',
        'phosphorus': 'মাঝারি',
        'potassium': 'উচ্চ',
        'recommendation': 'নাইট্রোজেন সার ব্যবহার করুন',
      },
    },
  ];

  const LandDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'জমির তথ্য',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: landData.length,
        itemBuilder: (context, index) {
          final land = landData[index];
          return _buildLandCard(land);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add_land');
        },
        backgroundColor: const Color(0xFF4CAF50),
        icon: Icon(Icons.add_location, color: Colors.white),
        label: Text(
          'নতুন জমি',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLandCard(Map<String, dynamic> land) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border(left: BorderSide(color: land['color'], width: 6)),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Land Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  land['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: land['color'],
                  ),
                ),
                Icon(Icons.landscape, color: land['color']),
              ],
            ),

            SizedBox(height: 8),
            _buildInfoRow('আয়তন', land['area']),
            _buildInfoRow('অবস্থান', land['location']),
            _buildInfoRow('মাটির ধরন', land['soilType']),
            _buildInfoRow('ফসল', land['crop']),

            // Location Section with GPS coordinates
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF4CAF50).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: const Color(0xFF4CAF50),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'জিপিএস অবস্থান',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow('ঠিকানা', land['address']),
                  _buildInfoRow('অক্ষাংশ', '${land['latitude']}°'),
                  _buildInfoRow('দ্রাঘিমাংশ', '${land['longitude']}°'),
                  
                  // Distance and Map Preview
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2196F3).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF2196F3).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.straighten,
                                color: const Color(0xFF2196F3),
                                size: 20,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'আনুমানিক দূরত্ব',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: const Color(0xFF2196F3),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '২.৫ কিমি',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xFF2196F3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9800).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFFF9800).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: const Color(0xFFFF9800),
                                size: 20,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'ভ্রমণ সময়',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: const Color(0xFFFF9800),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '৮ মিনিট',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color(0xFFFF9800),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 12),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        children: [
                          // Map background with grid
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFE8F5E8),
                                  const Color(0xFFF1F8E9),
                                  const Color(0xFFE8F5E8),
                                ],
                              ),
                            ),
                            child: CustomPaint(
                              painter: MapGridPainter(),
                            ),
                          ),
                          
                          // Location marker
                          Center(
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                          
                          // Coordinates overlay
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${land['latitude']}, ${land['longitude']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _openInGoogleMaps(
                        land['latitude'],
                        land['longitude'],
                        land['name'],
                      ),
                      icon: Icon(Icons.map, color: const Color(0xFF4CAF50)),
                      label: Text(
                        'Google Maps এ খুলুন',
                        style: TextStyle(color: const Color(0xFF4CAF50)),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: const Color(0xFF4CAF50)),
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12),
            Text(
              '🌱 মাটির তথ্য:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            _buildInfoRow('pH', land['soilData']['pH']),
            _buildInfoRow('আর্দ্রতা', land['soilData']['moisture']),
            _buildInfoRow('নাইট্রোজেন', land['soilData']['nitrogen']),
            _buildInfoRow('ফসফরাস', land['soilData']['phosphorus']),
            _buildInfoRow('পটাশিয়াম', land['soilData']['potassium']),

            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: land['color'].withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.tips_and_updates, color: land['color'], size: 20),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      land['soilData']['recommendation'],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: land['color'],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: land['status'] == 'সক্রিয়'
                    ? const Color(0xFF4CAF50).withOpacity(0.1)
                    : const Color(0xFF9E9E9E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                land['status'],
                style: TextStyle(
                  fontSize: 12,
                  color: land['status'] == 'সক্রিয়'
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openInGoogleMaps(String latitude, String longitude, String landName) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      // Fallback: Show coordinates for manual input
      _showCoordinatesDialog(latitude, longitude, landName);
    }
  }

  void _showCoordinatesDialog(String latitude, String longitude, String landName) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('জমির অবস্থান'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$landName এর GPS স্থানাঙ্ক:'),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('অক্ষাংশ: $latitude°'),
                    Text('দ্রাঘিমাংশ: $longitude°'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'এই স্থানাঙ্কগুলো Google Maps এ কপি করে ব্যবহার করুন।',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('বন্ধ করুন'),
            ),
            ElevatedButton(
              onPressed: () {
                // Copy coordinates to clipboard
                final coordinates = '$latitude, $longitude';
                // You can add clipboard functionality here if needed
                Navigator.of(context).pop();
                ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                  SnackBar(
                    content: Text('স্থানাঙ্ক কপি করা হয়েছে: $coordinates'),
                    backgroundColor: const Color(0xFF4CAF50),
                  ),
                );
              },
              child: Text('স্থানাঙ্ক কপি করুন'),
            ),
          ],
        );
      },
    );
  }
}

// Global navigator key for accessing context in static methods
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Custom Painter for Map Grid
class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 0.5;

    // Draw grid lines
    for (double i = 0; i < size.width; i += 15) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 15) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
