// this class defines the structure that will be retrieved from the server
//when a qr code is consulted, ther server retrieves a json stringify
// with this structure {loadingGuide :.. , vehicle: ...}

import 'package:loadin_guide_scann/src/core/common/entities/loading_guide.dart';
import 'package:loadin_guide_scann/src/core/common/entities/vehicle.dart';

class LoadingSetServer {
  final LoadingGuide loadingGuide;
  final Vehicle vehicle;

  // Constructor
  LoadingSetServer({
    required this.loadingGuide,
    required this.vehicle,
  });

  factory LoadingSetServer.fromJson(Map<String, dynamic> json) {
    try {
      return LoadingSetServer(
        loadingGuide: LoadingGuide.fromJson(json['loadingGuide']),
        vehicle: Vehicle.fromJson(json['vehicle']),
      );
    } catch (e) {
      throw Exception('Failed to parse LoadingSetServer: $e');
    }
  }
}
