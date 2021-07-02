abstract class KeyboardEvent {
  const KeyboardEvent();
}

class NumberButtonPressed extends KeyboardEvent {
  final int number;
  const NumberButtonPressed(this.number);
}

class OperatorButtonPressed extends KeyboardEvent {
  final String caclculation;
  const OperatorButtonPressed(this.caclculation);
}

class BackButtonPressed extends KeyboardEvent {}

class BackButtonLongPressed extends KeyboardEvent {}

class SubmitButtonPressed extends KeyboardEvent {}