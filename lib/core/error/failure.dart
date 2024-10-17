class Failure {
  final String message;

  const Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({String message = 'Server Failure'}) : super(message: message);
}


