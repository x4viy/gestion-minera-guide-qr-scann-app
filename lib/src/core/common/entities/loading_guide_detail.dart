import 'package:flutter/material.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_guide_header.dart';

class LoadingGuideDetail {
  final int id;
  final double quantity;
  final String unit;
  final int miningOwnerMineMaterialId;
  final String? status;
  final String? remarks;
  final int materialId;
  final Material? material;
  final int mineId;
  final Size? mine;
  final int? docGuideHeaderId;
  final LoadingGuideHeader? loadingGuideHeader;

  const LoadingGuideDetail({
    required this.id,
    required this.quantity,
    required this.unit,
    required this.miningOwnerMineMaterialId,
    this.status,
    this.remarks,
    required this.materialId,
    this.material,
    required this.mineId,
    this.mine,
    this.docGuideHeaderId,
    this.loadingGuideHeader,
  });
}
