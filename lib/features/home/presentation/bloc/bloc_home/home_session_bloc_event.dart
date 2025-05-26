part of 'home_session_bloc_bloc.dart';

class SessionCtegoryEvent {}

class UserCategoryListEvent extends SessionCtegoryEvent {}

class LoadSessionCategoryEvent extends SessionCtegoryEvent {
  final String uid;

  LoadSessionCategoryEvent({this.uid = 'Not Found'});
}
