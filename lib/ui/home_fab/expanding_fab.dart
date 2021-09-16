import 'dart:math';

import 'package:budgy/resources/res.dart';
import 'package:flutter/material.dart';

import 'expandable_button.dart';

@immutable
class ExpandingFAB extends StatefulWidget {
  const ExpandingFAB({
    this.initialOpen,
    required this.distance,
    required this.children,
    required this.durationTime,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;
  final int durationTime;

  @override
  _ExpandingFABState createState() => _ExpandingFABState();
}

class _ExpandingFABState extends State<ExpandingFAB>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: Duration(milliseconds: widget.durationTime),
      vsync: this,
    );
    ;
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
          angle: -pi / 4,
          child: const Icon(
            Icons.close,
            size: 30,
            color: AppColors.expenseIndicatorColor,
          ),
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
          progress: CurvedAnimation(
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.easeOutQuad,
            parent: _controller,
          ),
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Transform _buildPlusButton() {
    return Transform.rotate(
      angle: pi / 4,
      child: IgnorePointer(
        ignoring: _open,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: widget.durationTime),
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          child: FloatingActionButton(
            onPressed: () => _toggle(),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [AppColors.accentYellow, AppColors.accentGreen],
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: AnimatedRotation(
                // 0 => -1/4 pi (move an octant counter clockwise)
                turns: _open ? 0 : -0.125,
                duration: Duration(milliseconds: widget.durationTime),
                curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
