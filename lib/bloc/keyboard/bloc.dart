import 'package:budgy/bloc/keyboard/events.dart';
import 'package:budgy/bloc/keyboard/states.dart';
import 'package:budgy/models/transaction.dart';
import 'package:budgy/my_app.dart';
import 'package:budgy/services/transaction.dart';
import 'package:budgy/utils/transaction_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyboardBloc extends Bloc<KeyboardEvent, KeyboardState> {
  KeyboardBloc() : super(KeyboardState(text: '0', isExpense: true));

  @override
  Stream<KeyboardState> mapEventToState(KeyboardEvent event) async* {
    if (event is NumberButtonPressed) yield onNumberPress(event.number);
    if (event is OperatorButtonPressed)
      yield onOperatorPress(event.caclculation);
    if (event is BackButtonPressed) yield onBackPress();
    if (event is BackButtonLongPressed) yield onBackLongPress();
    if (event is SubmitButtonPressed) yield onSubmitPress();
  }

  KeyboardState onNumberPress(int number) {
    String resultText = state.text;
    if (state.isInputZero)
      resultText = number.toString();
    else
      resultText += number.toString();

    return state.copyWith(text: resultText);
  }

  KeyboardState onOperatorPress(String calculation) {
    String resultText = state.text;
    if (state.lastDigitIsCalc)
      resultText = resultText.replaceFirst(
          TransactionRepository.operatorRegex, calculation);
    else if (!TransactionRepository.isValidOperation(state.text))
      resultText = state.text;
    else if (state.hasCalculation)
      resultText =
          TransactionRepository.performCalculation(state.text) + calculation;
    else
      resultText += calculation;
    return state.copyWith(text: resultText);
  }

  KeyboardState onBackPress() {
    if (!state.shouldRemoveFromInput) return state;

    String result = TransactionRepository.removeLastCharFrom(state.text);
    return state.copyWith(text: result);
  }

  KeyboardState onBackLongPress() {
    return state.copyWith(text: '0');
  }

  KeyboardState onSubmitPress() {
    if (state.hasCalculation && !state.lastDigitIsCalc)
      return KeyboardState(
          text: TransactionRepository.performCalculation(state.text),
          isExpense: state.isExpense);

    if (!state.isInputZero) _createTransaction();

    return state;
  }

  void _createTransaction() async {
    Transaction _newTransaction =
        await TransactionService.createTransactionWithData(
      Transaction(
        datetime: DateTime.now(),
        currency: "EGP",
        categoryId: 1,
        isExpense: state.isExpense,
        amount: state.textAsNum!,
      ),
    );
    appRouter.root.pop(_newTransaction);
  }
}