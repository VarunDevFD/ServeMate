part of 'home_session_bloc_bloc.dart';

class SessionCategoryState {}

class SessionBlocInitial extends SessionCategoryState {
  final String categoryName;

  SessionBlocInitial([this.categoryName = Names.empty]);
}

class SessionBlocLoading extends SessionCategoryState {}

class SessionBlocLoaded extends SessionCategoryState {
  final Map<String, dynamic> data;

  SessionBlocLoaded({
    required this.data,
  });
}

class SessionBlocError extends SessionCategoryState {}
