abstract class KeyboardEvent {
  const KeyboardEvent();
}

class NumberButtonPressed extends KeyboardEvent {
  final int number;
  const NumberButtonPressed(this.number);
}

class CalculationButtonPressed extends KeyboardEvent {
  final String caclculation;
  const CalculationButtonPressed(this.caclculation);
}

class SubmitButtonPressed extends KeyboardEvent {}
