class User {
  final int? id;
  final String name;
  final String phone;
  final String email;
  final String userType; // 'farmer', 'supervisor', 'admin'
  final String address;
  final String? organization;
  final String? designation;
  final String? adminCode;
  final String? groupName; // For farmers - which group they belong to
  final String? managedGroups; // For supervisors - comma-separated list of groups they manage
  final int? maxFarmers; // For supervisors - maximum number of farmers they can manage
  final DateTime createdAt;
  final bool isActive;

  User({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.userType,
    required this.address,
    this.organization,
    this.designation,
    this.adminCode,
    this.groupName,
    this.managedGroups,
    this.maxFarmers,
    required this.createdAt,
    this.isActive = true,
  });

  User copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? userType,
    String? address,
    String? organization,
    String? designation,
    String? adminCode,
    String? groupName,
    String? managedGroups,
    int? maxFarmers,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      address: address ?? this.address,
      organization: organization ?? this.organization,
      designation: designation ?? this.designation,
      adminCode: adminCode ?? this.adminCode,
      groupName: groupName ?? this.groupName,
      managedGroups: managedGroups ?? this.managedGroups,
      maxFarmers: maxFarmers ?? this.maxFarmers,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'userType': userType,
      'address': address,
      'organization': organization,
      'designation': designation,
      'adminCode': adminCode,
      'groupName': groupName,
      'managedGroups': managedGroups,
      'maxFarmers': maxFarmers,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      userType: map['userType'],
      address: map['address'],
      organization: map['organization'],
      designation: map['designation'],
      adminCode: map['adminCode'],
      groupName: map['groupName'],
      managedGroups: map['managedGroups'],
      maxFarmers: map['maxFarmers'],
      createdAt: DateTime.parse(map['createdAt']),
      isActive: map['isActive'] == 1,
    );
  }

  // Helper methods for group management
  List<String> get managedGroupsList {
    if (managedGroups == null || managedGroups!.isEmpty) {
      return [];
    }
    return managedGroups!.split(',').map((e) => e.trim()).toList();
  }

  bool isInGroup(String groupName) {
    return this.groupName == groupName;
  }

  bool managesGroup(String groupName) {
    return managedGroupsList.contains(groupName);
  }

  bool canManageMoreFarmers() {
    if (maxFarmers == null) return true;
    // This would need to be implemented with actual farmer count
    return true; // Placeholder
  }
}
