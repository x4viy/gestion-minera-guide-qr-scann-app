import 'package:loadin_guide_scann/src/core/common/entities/mining_owner.dart';
import 'package:loadin_guide_scann/src/core/common/entities/owner_driver_vehicle.dart';
import 'package:loadin_guide_scann/src/core/common/entities/vehicle.dart';

class LoadingGuideHeader {
  final int id;
  final String? guideNumber;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final String? remarks;
  final int vehicleId;
  final Vehicle? vehicle;
  final int driverId;
  final OwnerDriverVehicle? driver;
  final int ownerId;
  final OwnerDriverVehicle? owner;
  final int miningOwnerId;
  final MiningOwner? miningOwner;

  LoadingGuideHeader({
    required this.id,
    this.guideNumber,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.remarks,
    required this.vehicleId,
    this.vehicle,
    required this.driverId,
    this.driver,
    required this.ownerId,
    this.owner,
    required this.miningOwnerId,
    this.miningOwner,
  });

  factory LoadingGuideHeader.fromJson(Map<String, dynamic> json) {
    return LoadingGuideHeader(
      id: json['id'],
      guideNumber: json['guide_number'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
      remarks: json['remarks'],
      vehicleId: json['vehicle_id'],
      vehicle: json['VehicleId'] != null
          ? Vehicle.fromJson(json['VehicleId'])
          : null,
      driverId: json['driver_id'],
      driver: json['DriverId'] != null
          ? OwnerDriverVehicle.fromJson(json['DriverId'])
          : null,
      ownerId: json['owner_id'],
      owner: json['OwnerId'] != null
          ? OwnerDriverVehicle.fromJson(json['OwnerId'])
          : null,
      miningOwnerId: json['miningowner_id'],
      miningOwner: json['MiningOwnerId'] != null
          ? MiningOwner.fromJson(json['MiningOwnerId'])
          : null,
    );
  }
}
