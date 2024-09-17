part of 'groups_cubit.dart';

abstract class GroupsState {}

class GroupsInitial extends GroupsState {}

class AddGroupsLoading extends GroupsState {}

class AddGroupsSuccess extends GroupsState {
  final String success_message;

  AddGroupsSuccess({required this.success_message});
}

class AddGroupsFailure extends GroupsState {
  final String error_message;

  AddGroupsFailure({required this.error_message});
}

class GetGroupsSuccess extends GroupsState {
  final String success_message;

  GetGroupsSuccess({required this.success_message});
}

class GetGroupsFailure extends GroupsState {
  final String error_message;

  GetGroupsFailure({required this.error_message});
}

class GetGroupsLoading extends GroupsState {}

class ChangeDropApp extends GroupsState {}
