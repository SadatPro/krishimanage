class Crop {
  final int? id;
  final int landId;
  final String name;
  final String variety;
  final DateTime plantingDate;
  final DateTime? expectedHarvestDate;
  final DateTime? actualHarvestDate;
  final double plantedArea; // in acres
  final double? expectedYield; // in tons
  final double? actualYield; // in tons
  final String status; // 'planted', 'growing', 'ready', 'harvested'
  final double progress; // 0.0 to 1.0
  final String? notes;
  final DateTime createdAt;
  final DateTime? lastUpdated;

  Crop({
    this.id,
    required this.landId,
    required this.name,
    required this.variety,
    required this.plantingDate,
    this.expectedHarvestDate,
    this.actualHarvestDate,
    required this.plantedArea,
    this.expectedYield,
    this.actualYield,
    required this.status,
    required this.progress,
    this.notes,
    required this.createdAt,
    this.lastUpdated,
  });

  Crop copyWith({
    int? id,
    int? landId,
    String? name,
    String? variety,
    DateTime? plantingDate,
    DateTime? expectedHarvestDate,
    DateTime? actualHarvestDate,
    double? plantedArea,
    double? expectedYield,
    double? actualYield,
    String? status,
    double? progress,
    String? notes,
    DateTime? createdAt,
    DateTime? lastUpdated,
  }) {
    return Crop(
      id: id ?? this.id,
      landId: landId ?? this.landId,
      name: name ?? this.name,
      variety: variety ?? this.variety,
      plantingDate: plantingDate ?? this.plantingDate,
      expectedHarvestDate: expectedHarvestDate ?? this.expectedHarvestDate,
      actualHarvestDate: actualHarvestDate ?? this.actualHarvestDate,
      plantedArea: plantedArea ?? this.plantedArea,
      expectedYield: expectedYield ?? this.expectedYield,
      actualYield: actualYield ?? this.actualYield,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'landId': landId,
      'name': name,
      'variety': variety,
      'plantingDate': plantingDate.toIso8601String(),
      'expectedHarvestDate': expectedHarvestDate?.toIso8601String(),
      'actualHarvestDate': actualHarvestDate?.toIso8601String(),
      'plantedArea': plantedArea,
      'expectedYield': expectedYield,
      'actualYield': actualYield,
      'status': status,
      'progress': progress,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  factory Crop.fromMap(Map<String, dynamic> map) {
    return Crop(
      id: map['id'],
      landId: map['landId'],
      name: map['name'],
      variety: map['variety'],
      plantingDate: DateTime.parse(map['plantingDate']),
      expectedHarvestDate: map['expectedHarvestDate'] != null 
          ? DateTime.parse(map['expectedHarvestDate']) 
          : null,
      actualHarvestDate: map['actualHarvestDate'] != null 
          ? DateTime.parse(map['actualHarvestDate']) 
          : null,
      plantedArea: map['plantedArea'],
      expectedYield: map['expectedYield'],
      actualYield: map['actualYield'],
      status: map['status'],
      progress: map['progress'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
      lastUpdated: map['lastUpdated'] != null 
          ? DateTime.parse(map['lastUpdated']) 
          : null,
    );
  }

  int get daysSincePlanting {
    return DateTime.now().difference(plantingDate).inDays;
  }

  int get daysUntilHarvest {
    if (expectedHarvestDate == null) return 0;
    return expectedHarvestDate!.difference(DateTime.now()).inDays;
  }

  bool get isReadyForHarvest {
    return status == 'ready' || (expectedHarvestDate != null && 
        DateTime.now().isAfter(expectedHarvestDate!));
  }
}
