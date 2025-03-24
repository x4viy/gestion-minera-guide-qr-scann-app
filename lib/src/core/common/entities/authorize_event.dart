import 'package:loadin_guide_scann/src/core/common/entities/loading_guide.dart';
import 'package:loadin_guide_scann/src/core/common/entities/vehicle.dart';

class AuthorizeEvent {
  final String card;
  final String rfidCode;
  final List<Vehicle> vehicles;
  final bool isValid;
  final List<String> errorMessage;
  final List<LoadingGuide> loadingGuides;

  AuthorizeEvent({
    required this.card,
    required this.rfidCode,
    required this.vehicles,
    required this.isValid,
    required this.errorMessage,
    required this.loadingGuides,
  });
}
