import 'package:loadin_guide_scann/src/core/common/entities/loading_guide_detail.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_guide_header.dart';

class LoadingGuide {
  final LoadingGuideHeader guideHeader;
  final List<LoadingGuideDetail> guideDetails;

  LoadingGuide({
    required this.guideHeader,
    required this.guideDetails,
  });

  factory LoadingGuide.fromJson(Map<String, dynamic> json) {
    return LoadingGuide(
      guideHeader: LoadingGuideHeader.fromJson(json['guideHeader']),
      guideDetails: (json['guideDetails'] as List)
          .map((e) => LoadingGuideDetail.fromJson(e))
          .toList(),
    );
  }
}
