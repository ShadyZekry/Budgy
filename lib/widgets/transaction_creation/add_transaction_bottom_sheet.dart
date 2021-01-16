import 'package:Budgy/resources/colors.dart';
import 'package:flutter/material.dart';

class AddTransactionBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.backgroundColor,
      ),
      child: GridView.count(
        crossAxisCount: 5,
        children: [
          _buildKeyboardButtonWidget(title: '÷'),
          _buildKeyboardButtonWidget(title: '7'),
          _buildKeyboardButtonWidget(title: '8'),
          _buildKeyboardButtonWidget(title: '9'),
          _buildKeyboardButtonWidget(icon: Icon(Icons.remove_circle)),
          _buildKeyboardButtonWidget(title: 'x'),
          _buildKeyboardButtonWidget(title: '4'),
          _buildKeyboardButtonWidget(title: '5'),
          _buildKeyboardButtonWidget(title: '6'),
          _buildKeyboardButtonWidget(icon: Icon(Icons.calendar_today)),
          _buildKeyboardButtonWidget(icon: Icon(Icons.remove)),
          _buildKeyboardButtonWidget(title: '1'),
          _buildKeyboardButtonWidget(title: '2'),
          _buildKeyboardButtonWidget(title: '3'),
          _buildKeyboardButtonWidget(icon: Icon(Icons.check)),
          _buildKeyboardButtonWidget(icon: Icon(Icons.add)),
          _buildKeyboardButtonWidget(title: '0'),
          _buildKeyboardButtonWidget(title: '.'),
        ],
      ),
    );
  }

  Widget _buildKeyboardButtonWidget({
    String title,
    Icon icon,
    Color fillColor,
    Function function,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(color: AppColors.white, width: 0.1),
      ),
      child: Center(
        child: title == null
            ? icon
            : Text(
                title,
                style: TextStyle(fontSize: 35),
              ),
      ),
    );
  }
}
