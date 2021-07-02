import 'package:budgy/bloc/keyboard/events.dart';
import 'package:budgy/bloc/keyboard/states.dart';
import 'package:budgy/models/transaction.dart';
import 'package:budgy/my_app.dart';
import 'package:budgy/services/transaction.dart';
import 'package:budgy/utils/transaction_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyboardBloc extends Bloc<KeyboardEvent, KeyboardState> {
  KeyboardBloc() : super(KeyboardState(text: '0', isExpense: true));

  @override
  Stream<KeyboardState> mapEventToState(KeyboardEvent event) async* {
    if (event is NumberButtonPressed) yield onNumberPressed(event.number);
    if (event is CalculationButtonPressed)
      yield onCalculationPressed(event.caclculation);
    if (event is SubmitButtonPressed) yield onSubmitPressed();
  }

  KeyboardState onNumberPressed(int number) {
    String resultText = state.text;
    if (state.isInputZero)
      resultText = number.toString();
    else
      resultText += number.toString();

    return state.copyWith(text: resultText);
  }

  KeyboardState onCalculationPressed(String calculation) {
    String resultText = state.text;
    if (state.lastDigitIsCalc)
      resultText = resultText.replaceFirst(
          TransactionRepository.operatorRegex, calculation);
    else if (state.hasCalculation) {
      TransactionRepository();
      resultText += calculation;
    } else
      resultText += calculation;
    return state.copyWith(text: resultText);
  }

  KeyboardState onSubmitPressed() {
    if (state.hasCalculation)
      return KeyboardState(
          text: TransactionRepository.performCalculation(state.text),
          isExpense: state.isExpense);

    if (!state.isInputZero) _createTransaction();

    return state;
  }

  void _createTransaction() async {
    Transaction _newTransaction =
        await TransactionService.createTransactionWithData(Transaction(
      datetime: DateTime.now(),
      currency: "EGP",
      categoryId: 1,
      isExpense: state.isExpense,
      amount: state.textAsNum!,
    ));
    appRouter.root.pop(_newTransaction);
  }
}
