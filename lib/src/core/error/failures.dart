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

  const ServerFailure(super.errorMessage, this.statusCode);
}

/// Cancel token failure
class CancelTokenFailure extends Failure {
  final int? statusCode;

  const CancelTokenFailure(super.errorMessage, this.statusCode);
}

class RetrieveToken extends Failure {
  const RetrieveToken(super.errorMessage);
}

// no internet connection failure
class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure()
      : super(
          'Sin conexión a internet',
        );
}
