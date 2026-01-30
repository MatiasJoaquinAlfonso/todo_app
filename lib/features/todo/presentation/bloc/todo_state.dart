part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();
  
  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoaded extends TodoState {
  final List<EventEntity> events;

  const TodoLoaded(this.events);

  @override
  List<Object> get props => [events];
}

final class TodoError extends TodoState {

  final String errorMessage;

  const TodoError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
