import 'package:equatable/equatable.dart';


class CategoryEntity extends Equatable{

  final int? id;
  final String title;
  final int color;
  final int priority;

  const CategoryEntity({
    required this.id, 
    required this.title,
    required this.color, 
    required this.priority
  });

  CategoryEntity copyWith({
    int? id,
    String? title,
    int? color,
    int? priority,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      priority: priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props => [id, title, color, priority];

}