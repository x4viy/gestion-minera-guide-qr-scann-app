import 'package:loadin_guide_scann/src/core/common/entities/mining_owner.dart';
import 'package:loadin_guide_scann/src/core/common/entities/owner_driver_vehicle.dart';
import 'package:loadin_guide_scann/src/core/common/entities/vehicle.dart';

class LoadingGuideHeader {
  final int id;
  final String? guideNumber;
  final String? createdAt;
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
}
