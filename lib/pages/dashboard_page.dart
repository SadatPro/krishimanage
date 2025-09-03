import 'package:flutter/material.dart';
import '../providers/app_provider.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedTabIndex = 0;

  final List<String> _tabs = ['সামগ্রিক', 'কৃষক', 'ফসল', 'অগ্রগতি', 'আবহাওয়া'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ড্যাশবোর্ড',
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            Consumer<AppProvider>(
              builder: (context, appProvider, child) {
                return appProvider.currentUser != null
                    ? Text(
                        'স্বাগতম, ${appProvider.currentUser!.name}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Color(0xFF4CAF50)),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: _tabs.asMap().entries.map((entry) {
                int index = entry.key;
                String tab = entry.value;
                bool isSelected = _selectedTabIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Color(0xFF4CAF50)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[600],
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Tab Content
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildFarmersTab();
      case 2:
        return _buildCropsTab();
      case 3:
        return _buildProgressTab();
      case 4:
        return _buildWeatherTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistics Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'মোট কৃষক',
                  '১২৫',
                  Icons.people,
                  Color(0xFF4CAF50),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'মোট জমি',
                  '৮৯',
                  Icons.landscape,
                  Color(0xFF2196F3),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'সক্রিয় ফসল',
                  '৪৫',
                  Icons.grass,
                  Color(0xFF8BC34A),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'মোট আয়',
                  '২.৫ লক্ষ',
                  Icons.attach_money,
                  Color(0xFFFF9800),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Quick Actions
          Text(
            'দ্রুত কার্যক্রম',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  'নতুন ফসল',
                  Icons.add_circle,
                  Color(0xFF4CAF50),
                  () => Navigator.pushNamed(context, '/add-crop'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  'নতুন জমি',
                  Icons.add_location,
                  Color(0xFF2196F3),
                  () => Navigator.pushNamed(context, '/land-location'),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Recent Activities
          Text(
            'সাম্প্রতিক কার্যক্রম',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),

          _buildActivityCard(
            'নতুন ফসল রোপণ',
            'আজ সকাল ৯:৩০',
            'ধান রোপণ করা হয়েছে',
            Icons.grass,
            Color(0xFF4CAF50),
          ),
          _buildActivityCard(
            'জমি তথ্য আপডেট',
            'গতকাল বিকাল ৪:১৫',
            'মাটির pH মাপা হয়েছে',
            Icons.update,
            Color(0xFF2196F3),
          ),
          _buildActivityCard(
            'সেচ দেওয়া হয়েছে',
            '২ দিন আগে',
            'জমি ১ এ সেচ দেওয়া হয়েছে',
            Icons.water_drop,
            Color(0xFF8BC34A),
          ),
        ],
      ),
    );
  }

  Widget _buildFarmersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Supervisor Info
          _buildSectionCard(
            'সুপারভাইজার তথ্য',
            Icons.supervisor_account,
            Color(0xFF4CAF50),
            [
              _buildInfoRow('নাম', 'আব্দুল রহমান'),
              _buildInfoRow('মোবাইল', '০১৭১২-৩৪৫৬৭৮'),
              _buildInfoRow('ইমেইল', 'abdul@example.com'),
              _buildInfoRow('জেলা', 'ঢাকা'),
              _buildInfoRow('উপজেলা', 'মোহাম্মদপুর'),
              _buildInfoRow('গ্রাম', 'মোহাম্মদপুর'),
              _buildInfoRow('গ্রুপ', 'A, B, C'),
              _buildInfoRow('কৃষক সংখ্যা', '৪৫ জন'),
            ],
          ),

          SizedBox(height: 16),

          // Farmer Groups
          _buildSectionCard(
            'কৃষক গ্রুপসমূহ',
            Icons.group_work,
            Color(0xFF2196F3),
            [
              _buildGroupInfo('গ্রুপ A', '১৫ জন', 'ধান, গম'),
              _buildGroupInfo('গ্রুপ B', '১৮ জন', 'সবজি, ফল'),
              _buildGroupInfo('গ্রুপ C', '১২ জন', 'মিশ্র ফসল'),
            ],
          ),

          SizedBox(height: 16),

          // Location Distribution
          _buildSectionCard(
            'অবস্থান অনুযায়ী কৃষক',
            Icons.location_on,
            Color(0xFFFF9800),
            [
              _buildLocationInfo('ঢাকা জেলা', '৩৫ জন'),
              _buildLocationInfo('মোহাম্মদপুর উপজেলা', '২৫ জন'),
              _buildLocationInfo('গুলশান', '২০ জন'),
              _buildLocationInfo('লালবাগ', '১৫ জন'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCropsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Crop Statistics
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'মোট ফসল',
                  '৪৫',
                  Icons.grass,
                  Color(0xFF4CAF50),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'সক্রিয়',
                  '৩২',
                  Icons.check_circle,
                  Color(0xFF8BC34A),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'পরিকল্পিত',
                  '৮',
                  Icons.schedule,
                  Color(0xFFFF9800),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'সম্পন্ন',
                  '৫',
                  Icons.done_all,
                  Color(0xFF2196F3),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Crop Types
          _buildSectionCard(
            'ফসলের ধরন অনুযায়ী',
            Icons.category,
            Color(0xFF4CAF50),
            [
              _buildCropTypeInfo('ধান', '২০', '৮০%'),
              _buildCropTypeInfo('গম', '১২', '৪৮%'),
              _buildCropTypeInfo('সবজি', '৮', '৩২%'),
              _buildCropTypeInfo('ফল', '৫', '২০%'),
            ],
          ),

          SizedBox(height: 16),

          // Season-wise Crops
          _buildSectionCard(
            'মৌসুম অনুযায়ী ফসল',
            Icons.calendar_today,
            Color(0xFF2196F3),
            [
              _buildSeasonInfo('রবি', '১৮', 'ধান, গম, আলু'),
              _buildSeasonInfo('খরিফ', '১৫', 'ধান, ভুট্টা, পাট'),
              _buildSeasonInfo('জায়েদ', '১২', 'সবজি, ফল'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overall Progress
          _buildSectionCard(
            'সামগ্রিক অগ্রগতি',
            Icons.trending_up,
            Color(0xFF4CAF50),
            [
              _buildProgressInfo('ফসল রোপণ', 75, '৭৫%'),
              _buildProgressInfo('সেচ ব্যবস্থা', 60, '৬০%'),
              _buildProgressInfo('সার প্রয়োগ', 80, '৮০%'),
              _buildProgressInfo('কীটনাশক', 45, '৪৫%'),
            ],
          ),

          SizedBox(height: 16),

          // Monthly Progress
          _buildSectionCard(
            'মাসিক অগ্রগতি',
            Icons.calendar_month,
            Color(0xFF2196F3),
            [
              _buildMonthlyProgress('জানুয়ারি', 85),
              _buildMonthlyProgress('ফেব্রুয়ারি', 78),
              _buildMonthlyProgress('মার্চ', 92),
              _buildMonthlyProgress('এপ্রিল', 88),
            ],
          ),

          SizedBox(height: 16),

          // Target vs Achievement
          _buildSectionCard(
            'লক্ষ্য বনাম অর্জন',
            Icons.track_changes,
            Color(0xFFFF9800),
            [
              _buildTargetInfo('ফসল উৎপাদন', 80, 75, 'টন'),
              _buildTargetInfo('আয়', 3.0, 2.5, 'লক্ষ টাকা'),
              _buildTargetInfo('জমি ব্যবহার', 90, 85, '%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Weather
          _buildSectionCard(
            'বর্তমান আবহাওয়া',
            Icons.wb_sunny,
            Color(0xFFFF9800),
            [
              _buildWeatherInfo('তাপমাত্রা', '৩২°C', Icons.thermostat),
              _buildWeatherInfo('আর্দ্রতা', '৭৫%', Icons.opacity),
              _buildWeatherInfo('বাতাস', '১২ কিমি/ঘ', Icons.air),
              _buildWeatherInfo('চাপ', '১০১৩ hPa', Icons.compress),
            ],
          ),

          SizedBox(height: 16),

          // Weather Forecast
          _buildSectionCard(
            'আবহাওয়ার পূর্বাভাস',
            Icons.cloud,
            Color(0xFF2196F3),
            [
              _buildForecastInfo('আজ', '৩২°C', 'সূর্য', 'সুন্দর দিন'),
              _buildForecastInfo('কাল', '৩০°C', 'মেঘ', 'হালকা বৃষ্টি'),
              _buildForecastInfo('পরশু', '২৮°C', 'বৃষ্টি', 'মাঝারি বৃষ্টি'),
            ],
          ),

          SizedBox(height: 16),

          // Weather Alerts
          _buildSectionCard(
            'আবহাওয়া সতর্কতা',
            Icons.warning,
            Color(0xFFFF5722),
            [
              _buildAlertInfo('বৃষ্টি সতর্কতা', 'আজ রাতে ভারী বৃষ্টি হতে পারে'),
              _buildAlertInfo(
                'তাপমাত্রা সতর্কতা',
                'আগামীকাল তাপমাত্রা বাড়তে পারে',
              ),
            ],
          ),

          SizedBox(height: 16),

          // Agricultural Advice
          _buildSectionCard(
            'কৃষি পরামর্শ',
            Icons.lightbulb,
            Color(0xFF4CAF50),
            [
              _buildAdviceInfo('সেচ', 'আজ সেচ দেওয়ার উপযুক্ত সময়'),
              _buildAdviceInfo('সার', 'সপ্তাহের শেষে সার প্রয়োগ করুন'),
              _buildAdviceInfo('কীটনাশক', 'কীটপতঙ্গের আক্রমণ রোধে সতর্ক থাকুন'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(
    String title,
    String time,
    String description,
    IconData icon,
    Color color,
  ) {
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
            child: Icon(icon, color: color, size: 20),
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
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    String title,
    IconData icon,
    Color color,
    List<Widget> children,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupInfo(String groupName, String memberCount, String crops) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                groupName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                crops,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          Text(
            memberCount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4CAF50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo(String location, String farmerCount) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            location,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          Text(
            farmerCount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2196F3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCropTypeInfo(String cropType, String count, String percentage) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cropType,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          Row(
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
              SizedBox(width: 8),
              Text(
                percentage,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonInfo(String season, String count, String crops) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                season,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                crops,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2196F3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressInfo(
    String task,
    int percentage,
    String percentageText,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                percentageText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyProgress(String month, int percentage) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            month,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          Row(
            children: [
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3),
                ),
              ),
              SizedBox(width: 8),
              Icon(
                percentage >= 80 ? Icons.trending_up : Icons.trending_down,
                color: percentage >= 80 ? Color(0xFF4CAF50) : Color(0xFFFF9800),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetInfo(
    String target,
    double targetValue,
    double achievedValue,
    String unit,
  ) {
    double percentage = (achievedValue / targetValue) * 100;
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                target,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                '${achievedValue.toStringAsFixed(1)}/$targetValue $unit',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage >= 80 ? Color(0xFF4CAF50) : Color(0xFFFF9800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFFF9800), size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastInfo(
    String day,
    String temperature,
    String condition,
    String description,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(
            condition == 'সূর্য'
                ? Icons.wb_sunny
                : condition == 'মেঘ'
                ? Icons.cloud
                : Icons.grain,
            color: Color(0xFF2196F3),
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            temperature,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2196F3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertInfo(String alertType, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFF5722).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFFF5722).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: Color(0xFFFF5722), size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alertType,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF5722),
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceInfo(String category, String advice) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF4CAF50).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF4CAF50).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb, color: Color(0xFF4CAF50), size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                Text(
                  advice,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
