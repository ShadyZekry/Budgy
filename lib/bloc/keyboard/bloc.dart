import 'package:budgy/bloc/keyboard/events.dart';
import 'package:budgy/bloc/keyboard/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyboardBloc extends Bloc<KeyboardEvent, KeyboardState> {
  KeyboardBloc() : super(KeyboardState('0'));

  @override
  Stream<KeyboardState> mapEventToState(KeyboardEvent event) async* {
    if (event is NumberButtonPressed) yield onNumberButtonPressed(event.number);
  }

  KeyboardState onNumberButtonPressed(int number) {
    if (state.isInputZero)
      return KeyboardState(number.toString());
    else
      return KeyboardState(state.text + number.toString());
  }
}
