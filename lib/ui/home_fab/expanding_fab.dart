import 'dart:math';

import 'package:budgy/resources/res.dart';
import 'package:flutter/material.dart';

import 'expandable_button.dart';

@immutable
class ExpandingFAB extends StatefulWidget {
  const ExpandingFAB({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandingFABState createState() => _ExpandingFABState();
}

class _ExpandingFABState extends State<ExpandingFAB>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  // ...

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    _open = !_open;
    if (_open)
      _controller.forward();
    else
      _controller.reverse();
    setState(() {});
  }

  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          _buildCloseButton(),
          ..._buildExpandingActionButtons(),
          _buildPlusButton(),
        ],
      ),
    );
  }

  Transform _buildPlusButton() {
    return Transform.rotate(
      angle: pi / 4,
      child: IgnorePointer(
        ignoring: _open,
        child: AnimatedContainer(
          transformAlignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            _open ? 0.7 : 1.0,
            _open ? 0.7 : 1.0,
            1.0,
          ),
          duration: const Duration(milliseconds: 250),
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: _open ? 0.0 : 1.0,
            curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
            child: FloatingActionButton(
              onPressed: () => _toggle(),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Transform.rotate(
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: AppColors.white,
                ),
                angle: -pi / 4,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Transform.rotate(
      angle: pi / 4,
      child: FloatingActionButton(
        onPressed: () => _toggle(),
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Transform.rotate(
          child: const Icon(
            Icons.close,
            size: 30,
            color: AppColors.expenseIndicatorColor,
          ),
          angle: -pi / 4,
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 45.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }
}
