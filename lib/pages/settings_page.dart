import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoSyncEnabled = true;
  String _selectedLanguage = 'বাংলা';
  String _selectedUnit = 'একর';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'সেটিংস',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              
              // Profile Section
              _buildSectionCard(
                title: 'প্রোফাইল',
                icon: Icons.person,
                children: [
                  _buildProfileItem(
                    icon: Icons.person_outline,
                    title: 'ব্যক্তিগত তথ্য',
                    subtitle: 'নাম, ফোন, ঠিকানা',
                    onTap: () {
                      _showProfileDialog(context);
                    },
                  ),
                  _buildProfileItem(
                    icon: Icons.agriculture,
                    title: 'কৃষক তথ্য',
                    subtitle: 'জমির বিবরণ, অভিজ্ঞতা',
                    onTap: () {
                      _showFarmerInfoDialog(context);
                    },
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // App Settings Section
              _buildSectionCard(
                title: 'অ্যাপ সেটিংস',
                icon: Icons.settings,
                children: [
                  _buildSwitchItem(
                    icon: Icons.notifications,
                    title: 'বিজ্ঞপ্তি',
                    subtitle: 'সেচ, সার, রোগের সতর্কতা',
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  _buildSwitchItem(
                    icon: Icons.dark_mode,
                    title: 'ডার্ক মোড',
                    subtitle: 'অন্ধকার থিম ব্যবহার করুন',
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                  ),
                  _buildSwitchItem(
                    icon: Icons.sync,
                    title: 'স্বয়ংক্রিয় সিঙ্ক',
                    subtitle: 'ডেটা স্বয়ংক্রিয়ভাবে আপডেট করুন',
                    value: _autoSyncEnabled,
                    onChanged: (value) {
                      setState(() {
                        _autoSyncEnabled = value;
                      });
                    },
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // Preferences Section
              _buildSectionCard(
                title: 'পছন্দসমূহ',
                icon: Icons.tune,
                children: [
                  _buildDropdownItem(
                    icon: Icons.language,
                    title: 'ভাষা',
                    subtitle: _selectedLanguage,
                    onTap: () {
                      _showLanguageDialog(context);
                    },
                  ),
                  _buildDropdownItem(
                    icon: Icons.straighten,
                    title: 'একক',
                    subtitle: _selectedUnit,
                    onTap: () {
                      _showUnitDialog(context);
                    },
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // Data Management Section
              _buildSectionCard(
                title: 'ডেটা ব্যবস্থাপনা',
                icon: Icons.storage,
                children: [
                  _buildActionItem(
                    icon: Icons.backup,
                    title: 'ডেটা ব্যাকআপ',
                    subtitle: 'সব তথ্য সুরক্ষিত করুন',
                    onTap: () {
                      _showBackupDialog(context);
                    },
                  ),
                  _buildActionItem(
                    icon: Icons.restore,
                    title: 'ডেটা পুনরুদ্ধার',
                    subtitle: 'সুরক্ষিত ডেটা ফিরিয়ে আনুন',
                    onTap: () {
                      _showRestoreDialog(context);
                    },
                  ),
                  _buildActionItem(
                    icon: Icons.delete_forever,
                    title: 'সব ডেটা মুছুন',
                    subtitle: 'সতর্কতা: এটি অপরিবর্তনীয়',
                    onTap: () {
                      _showDeleteAllDataDialog(context);
                    },
                    isDestructive: true,
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // About Section
              _buildSectionCard(
                title: 'সম্পর্কে',
                icon: Icons.info,
                children: [
                  _buildActionItem(
                    icon: Icons.description,
                    title: 'ব্যবহারের শর্তাবলী',
                    subtitle: 'অ্যাপ ব্যবহারের নিয়ম',
                    onTap: () {
                      _showTermsDialog(context);
                    },
                  ),
                  _buildActionItem(
                    icon: Icons.privacy_tip,
                    title: 'গোপনীয়তা নীতি',
                    subtitle: 'ডেটা সুরক্ষা সম্পর্কে',
                    onTap: () {
                      _showPrivacyDialog(context);
                    },
                  ),
                  _buildActionItem(
                    icon: Icons.help,
                    title: 'সাহায্য ও সহায়তা',
                    subtitle: 'অ্যাপ ব্যবহারের নির্দেশিকা',
                    onTap: () {
                      _showHelpDialog(context);
                    },
                  ),
                  _buildActionItem(
                    icon: Icons.feedback,
                    title: 'মতামত দিন',
                    subtitle: 'আমাদের আপনার মতামত জানান',
                    onTap: () {
                      _showFeedbackDialog(context);
                    },
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // Logout Button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'লগআউট',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // App Version
              Center(
                child: Text(
                  'সংস্করণ ১.০.০',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
          // Section Header
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: Color(0xFF4CAF50),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          
          // Section Items
          ...children,
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Color(0xFF4CAF50),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Color(0xFF4CAF50),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Color(0xFF4CAF50),
      ),
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Color(0xFF4CAF50),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDestructive 
              ? Colors.red.withOpacity(0.1)
              : Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isDestructive ? Colors.red : Color(0xFF4CAF50),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDestructive ? Colors.red : Colors.grey[800],
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ব্যক্তিগত তথ্য'),
        content: Text('এখানে ব্যক্তিগত তথ্য সম্পাদনা করা যাবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  void _showFarmerInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('কৃষক তথ্য'),
        content: Text('এখানে কৃষক তথ্য সম্পাদনা করা যাবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ভাষা নির্বাচন করুন'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('বাংলা'),
              onTap: () {
                setState(() {
                  _selectedLanguage = 'বাংলা';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('English'),
              onTap: () {
                setState(() {
                  _selectedLanguage = 'English';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showUnitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('একক নির্বাচন করুন'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('একর'),
              onTap: () {
                setState(() {
                  _selectedUnit = 'একর';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('হেক্টর'),
              onTap: () {
                setState(() {
                  _selectedUnit = 'হেক্টর';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBackupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ডেটা ব্যাকআপ'),
        content: Text('আপনার সব ডেটা সুরক্ষিত করা হচ্ছে...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ডেটা পুনরুদ্ধার'),
        content: Text('সুরক্ষিত ডেটা থেকে পুনরুদ্ধার করা হচ্ছে...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAllDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('সব ডেটা মুছুন'),
        content: Text('আপনি কি নিশ্চিত যে আপনি সব ডেটা মুছতে চান? এটি অপরিবর্তনীয়।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('না'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Delete all data logic here
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

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ব্যবহারের শর্তাবলী'),
        content: Text('এখানে ব্যবহারের শর্তাবলী দেখানো হবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('গোপনীয়তা নীতি'),
        content: Text('এখানে গোপনীয়তা নীতি দেখানো হবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('সাহায্য ও সহায়তা'),
        content: Text('এখানে সাহায্য ও সহায়তা দেখানো হবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('মতামত দিন'),
        content: Text('এখানে মতামত দেওয়ার ফর্ম দেখানো হবে।'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ঠিক আছে'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('লগআউট'),
        content: Text('আপনি কি নিশ্চিত যে আপনি লগআউট করতে চান?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('না'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Logout logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('হ্যাঁ, লগআউট'),
          ),
        ],
      ),
    );
  }
}
