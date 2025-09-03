import 'package:flutter/material.dart';

class UserTypeSelectionPage extends StatelessWidget {
  const UserTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'কৃষক ও জমি ব্যবস্থাপনা',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'আপনার ব্যবহারকারী ধরন নির্বাচন করুন',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 60),
              _buildUserTypeCard(
                context: context,
                title: 'কৃষক',
                description: 'আপনি যদি কৃষক হন এবং আপনার জমি ব্যবস্থাপনা করতে চান',
                icon: Icons.agriculture,
                color: Color(0xFF4CAF50),
                onTap: () => Navigator.pushNamed(context, '/farmer_registration'),
              ),
              SizedBox(height: 20),
              _buildUserTypeCard(
                context: context,
                title: 'কৃষি পরিদর্শক',
                description: 'আপনি যদি কৃষি পরিদর্শক হন এবং কৃষকদের সহায়তা করতে চান',
                icon: Icons.supervisor_account,
                color: Color(0xFF2196F3),
                onTap: () => Navigator.pushNamed(context, '/supervisor_registration'),
              ),
              SizedBox(height: 20),
              _buildUserTypeCard(
                context: context,
                title: 'অ্যাডমিন',
                description: 'আপনি যদি সিস্টেম অ্যাডমিন হন',
                icon: Icons.admin_panel_settings,
                color: Color(0xFF9C27B0),
                onTap: () => Navigator.pushNamed(context, '/admin_registration'),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                  child: Text(
                    'অ্যাপে প্রবেশ করুন',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildUserTypeCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
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
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
