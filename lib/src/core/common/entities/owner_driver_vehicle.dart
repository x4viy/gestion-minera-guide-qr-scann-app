class OwnerDriverVehicle {
  final int id;
  final String name;
  final String lastname;
  final String? status;
  final String numberIdentification;
  final String direction;
  final String phone1;
  final String phone2;
  final String? typeDriver;
  final int? parentId;
  final OwnerDriverVehicle? parent;

  OwnerDriverVehicle({
    required this.id,
    required this.name,
    required this.lastname,
    this.status,
    required this.numberIdentification,
    required this.direction,
    required this.phone1,
    required this.phone2,
    this.typeDriver,
    this.parentId,
    this.parent,
  });
}
