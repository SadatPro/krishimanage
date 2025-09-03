import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/wsbd.png',
              height: 40,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Text(
              'কৃষি ব্যবস্থাপনা',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Notification functionality to be implemented
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF45a049)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 35,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<AppProvider>(
                            builder: (context, appProvider, child) {
                              return appProvider.currentUser != null
                                  ? Text(
                                      'স্বাগতম, ${appProvider.currentUser!.name}!',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'স্বাগতম!',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    );
                            },
                          ),
                          Text(
                            'আপনার কৃষি ব্যবস্থাপনা',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Farmer Profile Section
              Consumer<AppProvider>(
                builder: (context, appProvider, child) {
                  if (appProvider.currentUser != null) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'কৃষক প্রোফাইল',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          Divider(),
                          _buildProfileItem(
                            icon: Icons.person,
                            title: 'নাম',
                            value: appProvider.currentUser!.name,
                          ),
                          _buildProfileItem(
                            icon: Icons.phone,
                            title: 'ফোন',
                            value: appProvider.currentUser!.phone,
                          ),
                          _buildProfileItem(
                            icon: Icons.email,
                            title: 'ইমেইল',
                            value: appProvider.currentUser!.email,
                          ),
                          _buildProfileItem(
                            icon: Icons.location_on,
                            title: 'ঠিকানা',
                            value: appProvider.currentUser!.address,
                          ),
                          if (appProvider.currentUser!.groupName != null)
                            _buildProfileItem(
                              icon: Icons.group,
                              title: 'গ্রুপ',
                              value: appProvider.currentUser!.groupName!,
                            ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                icon: Icon(Icons.edit, size: 16),
                                label: Text('প্রোফাইল সম্পাদনা'),
                                onPressed: () {
                                  // Navigate to profile edit page
                                  // This will be implemented later
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Color(0xFF4CAF50),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              
              SizedBox(height: 25),
              
              // Quick Actions Section
              Text(
                'দ্রুত কার্যক্রম',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 15),
              
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.1,
                children: [
                  _buildQuickActionCard(
                    icon: Icons.agriculture,
                    title: 'জমি তথ্য',
                    subtitle: 'জমির বিবরণ দেখুন',
                    color: Color(0xFF4CAF50),
                    onTap: () {
                      Navigator.pushNamed(context, '/land_data');
                    },
                  ),
                  _buildQuickActionCard(
                    icon: Icons.add_location,
                    title: 'জমি যোগ করুন',
                    subtitle: 'জমির অবস্থান যোগ করুন',
                    color: Color(0xFF9C27B0),
                    onTap: () {
                      Navigator.pushNamed(context, '/add_land');
                    },
                  ),
                                     _buildQuickActionCard(
                     icon: Icons.grass,
                     title: 'ফসল',
                     subtitle: 'ফসলের তথ্য',
                     color: Color(0xFF8BC34A),
                     onTap: () {
                       Navigator.pushNamed(context, '/cropping');
                     },
                   ),
                   _buildQuickActionCard(
                     icon: Icons.add_circle,
                     title: 'নতুন ফসল',
                     subtitle: 'ফসল যোগ করুন',
                     color: Color(0xFFFF9800),
                     onTap: () {
                       Navigator.pushNamed(context, '/add_crop');
                     },
                   ),
                  _buildQuickActionCard(
                    icon: Icons.water_drop,
                    title: 'মাটি ও পানি',
                    subtitle: 'মাটি ও পানির তথ্য',
                    color: Color(0xFF2196F3),
                    onTap: () {
                      Navigator.pushNamed(context, '/soil_data');
                    },
                  ),
                  _buildQuickActionCard(
                    icon: Icons.analytics,
                    title: 'বিশ্লেষণ',
                    subtitle: 'ফসল বিশ্লেষণ',
                    color: Color(0xFFFF9800),
                    onTap: () {
                      Navigator.pushNamed(context, '/analysis');
                    },
                  ),
                ],
              ),
              
              SizedBox(height: 25),
              
              // Recent Activities Section
              Text(
                'সাম্প্রতিক কার্যক্রম',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 15),
              
              _buildActivityCard(
                icon: Icons.update,
                title: 'জমি তথ্য আপডেট',
                subtitle: 'আজ সকাল ৯:৩০',
                color: Color(0xFF4CAF50),
              ),
              _buildActivityCard(
                icon: Icons.water_drop,
                title: 'সেচ দেওয়া হয়েছে',
                subtitle: 'গতকাল বিকাল ৪:১৫',
                color: Color(0xFF2196F3),
              ),
              _buildActivityCard(
                icon: Icons.grass,
                title: 'নতুন ফসল রোপণ',
                subtitle: '২ দিন আগে',
                color: Color(0xFF8BC34A),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: color,
                ),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProfileItem({required IconData icon, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Color(0xFF4CAF50),
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
