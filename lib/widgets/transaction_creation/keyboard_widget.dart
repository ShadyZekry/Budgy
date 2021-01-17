import 'package:Budgy/resources/res.dart';
import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  final TextEditingController textController;
  final Function refreshResult;
  KeyboardWidget({this.textController, this.refreshResult});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 5,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildKeyboardButtonWidget(title: '÷'),
          _buildKeyboardButtonWidget(title: '7', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '8', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '9', function: _addStringToResult),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.backspace, color: AppColors.white),
              function: _removeLastValueFromResult),
          _buildKeyboardButtonWidget(title: 'x'),
          _buildKeyboardButtonWidget(title: '4', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '5', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '6', function: _addStringToResult),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.calendar_today, color: AppColors.white)),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.remove, color: AppColors.white)),
          _buildKeyboardButtonWidget(title: '1', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '2', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '3', function: _addStringToResult),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.check, color: AppColors.white)),
          _buildKeyboardButtonWidget(
              icon: Icon(Icons.add, color: AppColors.white)),
          _buildKeyboardButtonWidget(title: '0', function: _addStringToResult),
          _buildKeyboardButtonWidget(title: '.'),
        ],
      ),
    );
  }

  Widget _buildKeyboardButtonWidget(
      {String title, Icon icon, Function function}) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.white, width: 0.1)),
      child: FlatButton(
        onPressed: () {
          if (function != null) function(title);
          refreshResult(() {});
        },
        child: Center(
          child: title == null
              ? icon
              : Text(title,
                  style: TextStyle(fontSize: 35, color: AppColors.white)),
        ),
      ),
    );
  }

  void _addStringToResult(String value) {
    textController.text += value;
  }

  void _removeLastValueFromResult(_) {
    if (textController.text.isEmpty || double.parse(textController.text) <= 0)
      return;

    textController.text =
        textController.text.substring(0, textController.text.length - 1);
  }
}
