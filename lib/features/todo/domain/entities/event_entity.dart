
import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {

  final int? id;
  final String title;
  final String? subTitle;
  final String? description;
  final DateTime dateInit;
  final DateTime? dateFinish;
  final bool isAllDay;
  final int? color;

  const EventEntity({ 
    this.id,
    required this.title,
    this.subTitle,
    this.description,
    required this.dateInit,
    this.dateFinish,
    this.isAllDay = false,
    this.color,
  });

  EventEntity copyWith({
    int? id,
    String? title,
    String? subTitle,
    String? description,
    DateTime? dateInit,
    DateTime? dateFinish,
    bool? isAllDay,
    int? color,
  }) {
    return EventEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      description: description ?? this.description,
      dateInit: dateInit ?? this.dateInit,
      dateFinish: dateFinish ?? this.dateFinish,
      isAllDay: isAllDay ?? this.isAllDay,
      color: color ?? this.color,
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, title, subTitle, description, dateInit, dateFinish, isAllDay, color];

}