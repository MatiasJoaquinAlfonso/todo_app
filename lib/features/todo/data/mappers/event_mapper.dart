import 'package:drift/drift.dart';
import 'package:todo_app/features/database/database.dart';
import 'package:todo_app/features/database/tables/events.dart';
import 'package:todo_app/features/todo/domain/entities/category_entity.dart';
import 'package:todo_app/features/todo/domain/entities/event_entity.dart';


extension EventMapper on Event {
  EventEntity toEntity({CategoryEntity? category}) {
    return EventEntity(
      id: id,
      title: title, 
      subTitle: subTitle,
      description: description,
      dateInit: dateInit,
      dateFinish: dateFinish,
      isAllDay: isAllDay,
      color: color,
      priority: priority,
      isDone: isDone,
      category: category,
      googleEventId: googleEventId,
      isSynced: isSynced,
      lastSyncedAt: lastSyncedAt,
      syncStatus: syncStatus?.name,
    );
  }
}

extension EventEntityMapper on EventEntity {
  EventsCompanion toCompanion() {
    return EventsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      fkCategoryID: Value(category?.id),
      title: Value(title), 
      subTitle: Value(subTitle),
      description: Value(description),
      dateInit: Value(dateInit),
      dateFinish: Value(dateFinish),
      isAllDay: Value(isAllDay),
      color: Value(color),
      priority: Value(priority),
      isDone: Value(isDone),
      googleEventId: Value(googleEventId),
      isSynced: Value(isSynced),
      lastSyncedAt: Value(lastSyncedAt),
      syncStatus: syncStatus != null ? Value(SyncStatus.values.firstWhere((e) => e.name == syncStatus)) : const Value.absent(),
    );
  }
}