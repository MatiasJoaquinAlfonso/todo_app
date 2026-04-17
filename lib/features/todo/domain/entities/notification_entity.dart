import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final int? id;
  final int eventId;
  final DateTime scheduleDate;

  const NotificationEntity({
    this.id,
    required this.eventId,
    required this.scheduleDate,
  });

  NotificationEntity copyWith({
    int? id,
    int? eventId,
    DateTime? scheduleDate,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      scheduleDate: scheduleDate ?? this.scheduleDate,
    );
  }

  @override
  List<Object?> get props => [id, eventId, scheduleDate];
}
