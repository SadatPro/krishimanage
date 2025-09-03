import 'package:flutter/material.dart';

class AnalysisPage extends StatelessWidget {
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
                'ফসল বিশ্লেষণ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),

              // Analysis Cards
              _buildAnalysisCard(
                title: 'ধান ফসলের বিশ্লেষণ',
                subtitle: 'জমি ১ - ২.৫ একর',
                status: 'উত্তম',
                color: Color(0xFF4CAF50),
                icon: Icons.grass,
                details: [
                  'ফসলের স্বাস্থ্য: ৯০%',
                  'পানির প্রয়োজন: ৭৫%',
                  'সারের প্রয়োজন: ৬০%',
                  'রোগের ঝুঁকি: নিম্ন',
                ],
              ),

              _buildAnalysisCard(
                title: 'গম ফসলের বিশ্লেষণ',
                subtitle: 'জমি ২ - ১.৮ একর',
                status: 'ভাল',
                color: Color(0xFF8BC34A),
                icon: Icons.grain,
                details: [
                  'ফসলের স্বাস্থ্য: ৭৫%',
                  'পানির প্রয়োজন: ৮৫%',
                  'সারের প্রয়োজন: ৪০%',
                  'রোগের ঝুঁকি: মাঝারি',
                ],
              ),

              _buildAnalysisCard(
                title: 'আলু ফসলের বিশ্লেষণ',
                subtitle: 'জমি ৩ - ০.৯ একর',
                status: 'সতর্কতা',
                color: Color(0xFFFF9800),
                icon: Icons.crop_square,
                details: [
                  'ফসলের স্বাস্থ্য: ৬৫%',
                  'পানির প্রয়োজন: ৯০%',
                  'সারের প্রয়োজন: ৮০%',
                  'রোগের ঝুঁকি: উচ্চ',
                ],
              ),

              SizedBox(height: 25),

              // Recommendations Section
              Text(
                'সুপারিশসমূহ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 15),

              _buildRecommendationCard(
                icon: Icons.water_drop,
                title: 'সেচ ব্যবস্থাপনা',
                description:
                    'জমি ৩-এ আজ সেচ দেওয়া প্রয়োজন। পানির স্তর নিম্ন।',
                color: Color(0xFF2196F3),
                priority: 'উচ্চ',
              ),

              _buildRecommendationCard(
                icon: Icons.eco,
                title: 'সার প্রয়োগ',
                description: 'জমি ১-এ নাইট্রোজেন সার প্রয়োগ করুন।',
                color: Color(0xFF8BC34A),
                priority: 'মাঝারি',
              ),

              _buildRecommendationCard(
                icon: Icons.bug_report,
                title: 'রোগ প্রতিরোধ',
                description: 'জমি ৩-এ ছত্রাকনাশক স্প্রে করুন।',
                color: Color(0xFFFF5722),
                priority: 'উচ্চ',
              ),

              SizedBox(height: 25),

              // Weather Impact Section
              Text(
                'আবহাওয়ার প্রভাব',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 15),

              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.wb_sunny, size: 30, color: Colors.white),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'আজকের আবহাওয়া',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'তাপমাত্রা: ২৮°C, আর্দ্রতা: ৭৫%',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'ফসলের উপর প্রভাব:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• উচ্চ তাপমাত্রায় পানির প্রয়োজন বাড়বে\n• আর্দ্রতা ফসলের জন্য উপকারী\n• সকালে সেচ দেওয়া ভাল',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

              // Yield Prediction Section
              Text(
                'ফসলের ফলন পূর্বাভাস',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 15),

              _buildYieldPredictionCard(
                crop: 'ধান',
                predictedYield: '২.৮ টন/একর',
                confidence: '৮৫%',
                trend: 'উর্ধ্বমুখী',
                color: Color(0xFF4CAF50),
              ),

              _buildYieldPredictionCard(
                crop: 'গম',
                predictedYield: '২.২ টন/একর',
                confidence: '৭৫%',
                trend: 'স্থিতিশীল',
                color: Color(0xFF8BC34A),
              ),

              _buildYieldPredictionCard(
                crop: 'আলু',
                predictedYield: '১.৫ টন/একর',
                confidence: '৬০%',
                trend: 'নিম্নমুখী',
                color: Color(0xFFFF9800),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisCard({
    required String title,
    required String subtitle,
    required String status,
    required Color color,
    required IconData icon,
    required List<String> details,
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
          // Header
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color),
                ),
                SizedBox(width: 15),
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
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
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
              children: details
                  .map(
                    (detail) => Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.circle, size: 8, color: color),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              detail,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required String priority,
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
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: priority == 'উচ্চ'
                            ? Colors.red.withOpacity(0.1)
                            : Color(0xFFFF9800).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        priority,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: priority == 'উচ্চ'
                              ? Colors.red
                              : Color(0xFFFF9800),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYieldPredictionCard({
    required String crop,
    required String predictedYield,
    required String confidence,
    required String trend,
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.trending_up, color: color),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crop,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'প্রত্যাশিত ফলন: $predictedYield',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  'আত্মবিশ্বাস: $confidence',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              trend,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
