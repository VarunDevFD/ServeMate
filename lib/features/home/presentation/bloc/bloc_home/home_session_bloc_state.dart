part of 'home_session_bloc_bloc.dart';

class SessionCategoryState {}

class SessionBlocInitial extends SessionCategoryState {
  final String categoryName;

  SessionBlocInitial([this.categoryName = Names.empty]);
}

class SessionBlocLoading extends SessionCategoryState {}

class SessionBlocLoaded extends SessionCategoryState {
  final Map<String, dynamic> data;
  double? minHeight;
  double? maxHeight;

  SessionBlocLoaded({
    required this.data,
    this.minHeight,
    this.maxHeight,
  });
}

class SessionBlocError extends SessionCategoryState {}
