import 'package:flutter/material.dart';

class SoilDataPage extends StatefulWidget {
  @override
  _SoilDataPageState createState() => _SoilDataPageState();
}

class _SoilDataPageState extends State<SoilDataPage> {
  final List<Map<String, dynamic>> soilData = [
    {
      'land': 'জমি ১',
      'soilType': 'দোআঁশ',
      'ph': '৬.৫',
      'ec': '1.2 dS/m',
      'temperature': '28°C',
      'moisture': '৭৫%',
      'nitrogen': 'মাঝারি',
      'phosphorus': 'উচ্চ',
      'potassium': 'মাঝারি',
      'color': Color(0xFF4CAF50),
    },
    {
      'land': 'জমি ২',
      'soilType': 'বেলে দোআঁশ',
      'ph': '৭.২',
      'ec': '0.8 dS/m',
      'temperature': '30°C',
      'moisture': '৬৫%',
      'nitrogen': 'নিম্ন',
      'phosphorus': 'মাঝারি',
      'potassium': 'উচ্চ',
      'color': Color(0xFF8BC34A),
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
                  Icon(Icons.terrain, size: 30, color: Color(0xFF4CAF50)),
                  SizedBox(width: 12),
                  Text(
                    'মাটি ও পানির তথ্য',
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
                      _showAddSoilDataDialog(context);
                    },
                  ),
                ],
              ),
            ),

            // Soil Data List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: soilData.length,
                itemBuilder: (context, index) {
                  return _buildSoilDataCard(soilData[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSoilDataCard(Map<String, dynamic> soil, int index) {
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
                    color: soil['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.terrain, color: soil['color']),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        soil['land'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        'মাটির ধরন: ${soil['soilType']}',
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
                      value: 'edit',
                      child: Row(
                        children: [Icon(Icons.edit), SizedBox(width: 8), Text('সম্পাদনা')],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [Icon(Icons.delete), SizedBox(width: 8), Text('মুছুন')],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditSoilDataDialog(context, soil, index);
                    } else if (value == 'delete') {
                      _showDeleteConfirmation(context, index);
                    }
                  },
                ),
              ],
            ),
          ),

          // Soil Properties
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[50],
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildPropertyItem(Icons.science, 'pH মান', soil['ph'], Colors.green)),
                    Expanded(child: _buildPropertyItem(Icons.electrical_services, 'EC', soil['ec'], Colors.blue)),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildPropertyItem(Icons.thermostat, 'তাপমাত্রা', soil['temperature'], Colors.red)),
                    Expanded(child: _buildPropertyItem(Icons.water_drop, 'আর্দ্রতা', soil['moisture'], Colors.blue)),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildPropertyItem(Icons.grain, 'N (নাইট্রোজেন)', soil['nitrogen'], Colors.orange)),
                    Expanded(child: _buildPropertyItem(Icons.grain, 'P (ফসফরাস)', soil['phosphorus'], Colors.purple)),
                    Expanded(child: _buildPropertyItem(Icons.grain, 'K (পটাশিয়াম)', soil['potassium'], Colors.teal)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyItem(IconData icon, String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Icon(icon, size: 16, color: color), SizedBox(width: 4), Text(label, style: TextStyle(fontSize: 12))]),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  // === Add/Edit/Delete dialogs ===
  void _showAddSoilDataDialog(BuildContext context) {
    final landController = TextEditingController();
    final typeController = TextEditingController();
    final phController = TextEditingController();
    final ecController = TextEditingController();
    final tempController = TextEditingController();
    final moistureController = TextEditingController();
    final nController = TextEditingController();
    final pController = TextEditingController();
    final kController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('নতুন মাটি তথ্য যোগ করুন'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildInput(landController, 'জমির নাম'),
              _buildInput(typeController, 'মাটির ধরন'),
              _buildInput(phController, 'pH মান', number: true),
              _buildInput(ecController, 'EC (dS/m)', number: true),
              _buildInput(tempController, 'তাপমাত্রা (°C)', number: true),
              _buildInput(moistureController, 'আর্দ্রতা (%)', number: true),
              _buildInput(nController, 'N (নাইট্রোজেন)'),
              _buildInput(pController, 'P (ফসফরাস)'),
              _buildInput(kController, 'K (পটাশিয়াম)'),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('বাতিল')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                soilData.add({
                  'land': landController.text,
                  'soilType': typeController.text,
                  'ph': phController.text,
                  'ec': ecController.text,
                  'temperature': tempController.text,
                  'moisture': moistureController.text,
                  'nitrogen': nController.text,
                  'phosphorus': pController.text,
                  'potassium': kController.text,
                  'color': Color(0xFF4CAF50),
                });
              });
              Navigator.pop(context);
            },
            child: Text('যোগ করুন'),
          ),
        ],
      ),
    );
  }

  void _showEditSoilDataDialog(BuildContext context, Map<String, dynamic> soil, int index) {
    final landController = TextEditingController(text: soil['land']);
    final typeController = TextEditingController(text: soil['soilType']);
    final phController = TextEditingController(text: soil['ph']);
    final ecController = TextEditingController(text: soil['ec']);
    final tempController = TextEditingController(text: soil['temperature']);
    final moistureController = TextEditingController(text: soil['moisture']);
    final nController = TextEditingController(text: soil['nitrogen']);
    final pController = TextEditingController(text: soil['phosphorus']);
    final kController = TextEditingController(text: soil['potassium']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('মাটি তথ্য সম্পাদনা করুন'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _buildInput(landController, 'জমির নাম'),
              _buildInput(typeController, 'মাটির ধরন'),
              _buildInput(phController, 'pH মান', number: true),
              _buildInput(ecController, 'EC (dS/m)', number: true),
              _buildInput(tempController, 'তাপমাত্রা (°C)', number: true),
              _buildInput(moistureController, 'আর্দ্রতা (%)', number: true),
              _buildInput(nController, 'N (নাইট্রোজেন)'),
              _buildInput(pController, 'P (ফসফরাস)'),
              _buildInput(kController, 'K (পটাশিয়াম)'),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('বাতিল')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                soilData[index] = {
                  'land': landController.text,
                  'soilType': typeController.text,
                  'ph': phController.text,
                  'ec': ecController.text,
                  'temperature': tempController.text,
                  'moisture': moistureController.text,
                  'nitrogen': nController.text,
                  'phosphorus': pController.text,
                  'potassium': kController.text,
                  'color': soil['color'],
                };
              });
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
        title: Text('মাটি তথ্য মুছুন'),
        content: Text('আপনি কি নিশ্চিত যে আপনি এই তথ্য মুছতে চান?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('না')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                soilData.removeAt(index);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('হ্যাঁ, মুছুন'),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String label, {bool number = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      ),
    );
  }
}
