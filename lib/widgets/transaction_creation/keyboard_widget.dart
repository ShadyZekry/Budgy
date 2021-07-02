import 'package:budgy/bloc/keyboard/bloc.dart';
import 'package:budgy/bloc/keyboard/events.dart';
import 'package:budgy/bloc/keyboard/states.dart';
import 'package:budgy/resources/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyboardWidget extends StatelessWidget {
  final bool isExpense;
  // TODO:: THIS IS WRONG, DON'T LEAVE IT AS IT IS PLEASE
  late final BuildContext crntContext;
  KeyboardWidget({required this.isExpense});

  @override
  Widget build(BuildContext context) {
    crntContext = context;
    return Expanded(
      child: GridView.count(
        crossAxisCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildCalculationButton('÷'),
          _buildNumberButton(7),
          _buildNumberButton(8),
          _buildNumberButton(9),
          _buildBackspaceButton(),
          _buildCalculationButton('x'),
          _buildNumberButton(4),
          _buildNumberButton(5),
          _buildNumberButton(6),
          _buildKeyboardButtonWidget(
              icon: const Icon(Icons.calendar_today, color: AppColors.white)),
          _buildCalculationButton('-'),
          _buildNumberButton(1),
          _buildNumberButton(2),
          _buildNumberButton(3),
          _buildSubmitButton(),
          _buildCalculationButton('+'),
          _buildNumberButton(0),
          _buildKeyboardButtonWidget(title: '.'),
        ],
      ),
    );
  }

  Widget _buildKeyboardButtonWidget(
      {String? title, Icon? icon, Function? function}) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () {
          if (function != null) function(title);
        },
        child: Center(
          child: title == null
              ? icon
              : Text(title,
                  style: const TextStyle(fontSize: 35, color: AppColors.white)),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () {
          crntContext.read<KeyboardBloc>().add(BackButtonPressed());
        },
        onLongPress: () {
          crntContext.read<KeyboardBloc>().add(BackButtonLongPressed());
        },
        child:
            const Center(child: Icon(Icons.backspace, color: AppColors.white)),
      ),
    );
  }

  Widget _buildCalculationButton(String calculation) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () => crntContext
            .read<KeyboardBloc>()
            .add(OperatorButtonPressed(calculation)),
        child: Center(
          child: Text(calculation,
              style: const TextStyle(fontSize: 35, color: AppColors.white)),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () =>
            crntContext.read<KeyboardBloc>().add(SubmitButtonPressed()),
        child: BlocBuilder<KeyboardBloc, KeyboardState>(
          builder: (context, state) {
            return Center(
              child: state.hasCalculation
                  ? const Text('=',
                      style: TextStyle(fontSize: 35, color: AppColors.white))
                  : const Icon(Icons.check, color: AppColors.white),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: TextButton(
        onPressed: () =>
            crntContext.read<KeyboardBloc>().add(NumberButtonPressed(number)),
        child: Center(
          child: Text(number.toString(),
              style: const TextStyle(fontSize: 35, color: AppColors.white)),
        ),
      ),
    );
  }
}
