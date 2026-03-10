
import 'package:equatable/equatable.dart';
import 'package:todo_app/features/todo/domain/entities/category_entity.dart';

class EventEntity extends Equatable {

  final int? id;
  final String title;
  final String? subTitle;
  final String? description;
  final DateTime dateInit;
  final DateTime dateFinish;
  final bool isAllDay;
  final bool isDone;
  final int? color;
  final CategoryEntity? category;

  const EventEntity({ 
    this.id,
    required this.title,
    this.subTitle,
    this.description,
    required this.dateInit,
    required this.dateFinish,
    this.isAllDay = false,
    this.isDone = false,
    this.color, 
    this.category,
  });

  EventEntity copyWith({
    int? id,
    String? title,
    String? subTitle,
    String? description,
    DateTime? dateInit,
    DateTime? dateFinish,
    bool? isAllDay,
    bool? isDone,
    int? color,
    CategoryEntity? category,
  }) {
    return EventEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      description: description ?? this.description,
      dateInit: dateInit ?? this.dateInit,
      dateFinish: dateFinish ?? this.dateFinish,
      isAllDay: isAllDay ?? this.isAllDay,
      isDone: isDone ?? this.isDone,
      color: color ?? this.color,
      category: category ?? this.category,
    );
  }
  
  @override
  List<Object?> get props => [id, title, subTitle, description, dateInit, dateFinish, isAllDay, isDone, color, category];
}