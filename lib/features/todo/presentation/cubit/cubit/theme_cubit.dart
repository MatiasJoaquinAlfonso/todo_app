import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_cubit_state.dart';

class ThemeCubit extends Cubit<ThemeCubitState> {
  ThemeCubit() : super(ThemeInitial());
}
