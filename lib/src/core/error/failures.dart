abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);

  String get message => errorMessage;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(String errorMessage, this.statusCode)
      : super(
          errorMessage,
        );
}

/// Cancel token failure
class CancelTokenFailure extends Failure {
  final int? statusCode;

  const CancelTokenFailure(String errorMessage, this.statusCode)
      : super(
          errorMessage,
        );
}

class MdbsScannerFailure extends Failure {
  const MdbsScannerFailure(String errorMessage)
      : super(
          errorMessage,
        );
}

// no internet connection failure
class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure()
      : super(
          'No internet connection',
        );
}

class BleScanFailure extends Failure {
  const BleScanFailure(String errorMessage)
      : super(
          errorMessage,
        );
}
