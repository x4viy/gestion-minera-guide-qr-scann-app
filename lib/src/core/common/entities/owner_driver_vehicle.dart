class OwnerDriverVehicle {
  final int id;
  final String name;
  final String lastname;
  final String? status;
  final String? numberIdentification;
  final String? direction;
  final String? phone1;
  final String? phone2;
  final String? typeDriver;
  final int? parentId;
  final OwnerDriverVehicle? parent;

  OwnerDriverVehicle({
    required this.id,
    required this.name,
    required this.lastname,
    this.status,
    this.numberIdentification,
    this.direction,
    this.phone1,
    this.phone2,
    this.typeDriver,
    this.parentId,
    this.parent,
  });

  factory OwnerDriverVehicle.fromJson(Map<String, dynamic> json) {
    return OwnerDriverVehicle(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      status: json['status'],
      numberIdentification: json['number_identification'],
      direction: json['direction'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      typeDriver: json['typeDriver'],
      parentId: json['parentId'],
      parent: json['parent'] != null
          ? OwnerDriverVehicle.fromJson(json['parent'])
          : null,
    );
  }
}
