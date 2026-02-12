part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class TodoSubscriptionRequested extends TodoEvent {
  final bool isDone;

  const TodoSubscriptionRequested({this.isDone = false});

  @override
  List<Object> get props => [isDone];
}

final class TodoAdded extends TodoEvent {
  final EventEntity event;

  const TodoAdded(this.event);

  @override
  List<Object> get props => [event];
}

final class TodoDeleted extends TodoEvent {
  final EventEntity event;

  const TodoDeleted(this.event);

  @override
  List<Object> get props => [event];
}

final class TodoUpdated extends TodoEvent {
  final EventEntity event;

  const TodoUpdated(this.event);

  @override
  List<Object> get props => [event];

}