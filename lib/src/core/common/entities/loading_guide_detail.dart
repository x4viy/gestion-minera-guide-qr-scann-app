import 'package:loadin_guide_scann/src/core/common/entities/material.dart';
import 'package:loadin_guide_scann/src/core/common/entities/mine.dart';
import 'package:loadin_guide_scann/src/core/common/entities/mining_owner_mine_material.dart';

class LoadingGuideDetail {
  final int id;
  final double quantity;
  final String unit;
  final String? status;
  final String? remarks;
  final int materialId;
  final MineMaterial? material;
  final int mineId;
  final Mine? mine;
  final int miningOwnerMineMaterialId;
  final MiningOwnerMineMaterial? miningOwnerMineMaterial;

  LoadingGuideDetail({
    required this.id,
    required this.quantity,
    required this.unit,
    this.status,
    this.remarks,
    required this.materialId,
    this.material,
    required this.mineId,
    this.mine,
    required this.miningOwnerMineMaterialId,
    this.miningOwnerMineMaterial,
  });

  factory LoadingGuideDetail.fromJson(Map<String, dynamic> json) {
    return LoadingGuideDetail(
      id: json['id'],
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'],
      status: json['status'],
      remarks: json['remarks'],
      materialId: json['material_id'],
      material: json['MaterialId'] != null
          ? MineMaterial.fromJson(json['MaterialId'])
          : null,
      mineId: json['mine_id'],
      mine: json['MineId'] != null ? Mine.fromJson(json['MineId']) : null,
      miningOwnerMineMaterialId: json['miningowner_mine_material_id'],
      miningOwnerMineMaterial: json['MiningOwnerMineMaterialId'] != null
          ? MiningOwnerMineMaterial.fromJson(json['MiningOwnerMineMaterialId'])
          : null,
    );
  }
}
