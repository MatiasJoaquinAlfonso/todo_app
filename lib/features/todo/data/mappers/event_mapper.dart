import 'package:drift/drift.dart';
import 'package:todo_app/features/database/database.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';


extension EventMapper on Event {
  EventEntity toEntity() {
    return EventEntity(
      id: id,
      title: title, 
      subTitle: subTitle,
      description: description,
      dateInit: dateInit,
      dateFinish: dateFinish,
      isAllDay: isAllDay,
      color: color,
      isDone: isDone
    );
  }
}

extension EventEntityMapper on EventEntity {
  EventsCompanion toCompanion() {
    return EventsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      title: Value(title), 
      subTitle: Value(subTitle),
      description: Value(description),
      dateInit: Value(dateInit),
      dateFinish: Value(dateFinish),
      isAllDay: Value(isAllDay),
      color: Value(color),
      isDone: Value(isDone),
    );
  }
}