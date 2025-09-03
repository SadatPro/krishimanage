class Land {
  final int? id;
  final int userId;
  final String name;
  final double area; // in acres
  final String location;
  final double? latitude;
  final double? longitude;
  final String soilType;
  final String status; // 'active', 'inactive', 'fallow'
  final String? currentCrop;
  final DateTime createdAt;
  final DateTime? lastUpdated;

  Land({
    this.id,
    required this.userId,
    required this.name,
    required this.area,
    required this.location,
    this.latitude,
    this.longitude,
    required this.soilType,
    required this.status,
    this.currentCrop,
    required this.createdAt,
    this.lastUpdated,
  });

  Land copyWith({
    int? id,
    int? userId,
    String? name,
    double? area,
    String? location,
    double? latitude,
    double? longitude,
    String? soilType,
    String? status,
    String? currentCrop,
    DateTime? createdAt,
    DateTime? lastUpdated,
  }) {
    return Land(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      area: area ?? this.area,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      soilType: soilType ?? this.soilType,
      status: status ?? this.status,
      currentCrop: currentCrop ?? this.currentCrop,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'area': area,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'soilType': soilType,
      'status': status,
      'currentCrop': currentCrop,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  factory Land.fromMap(Map<String, dynamic> map) {
    return Land(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      area: map['area'],
      location: map['location'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      soilType: map['soilType'],
      status: map['status'],
      currentCrop: map['currentCrop'],
      createdAt: DateTime.parse(map['createdAt']),
      lastUpdated: map['lastUpdated'] != null 
          ? DateTime.parse(map['lastUpdated']) 
          : null,
    );
  }
}
