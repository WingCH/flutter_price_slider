library flutter_price_slider;

import 'package:flutter/material.dart';

class FlutterPriceSlider extends StatefulWidget {
  const FlutterPriceSlider({
    Key? key,
    this.width = 200,
    required this.selectedBoxColor,
    required this.unselectedBoxColor,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    required this.onSelected,
  }) : super(key: key);

  final double width;
  final Color selectedBoxColor;
  final Color unselectedBoxColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Function(double) onSelected;

  @override
  _FlutterPriceSliderState createState() => _FlutterPriceSliderState();
}

class _FlutterPriceSliderState extends State<FlutterPriceSlider> {
  List<double> proportions = [0.25, 0.5, 0.75, 1];
  double selectedProportion = 0;

  void onSelected(double proportion) {
    setState(() {
      selectedProportion = proportion;
    });
    widget.onSelected(selectedProportion);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: LayoutBuilder(
        builder: (_, constraints) {
          double maxWidth = constraints.maxWidth;
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.deferToChild,
            onPanUpdate: (details) {
              // start point (left top): 1.0
              double dx = details.localPosition.dx;
              if (dx < 0) {
                onSelected(0);
                return;
              }
              // Calculate the ratio relative to the parent component
              // maxWidth = 220, dx = 148.5714285714858
              // relativePosition = 0.6341463414634145
              double relativePosition = dx / maxWidth;
              // Find the nearest [0.25, 0.5, 0.75, 1] of relativePosition
              // relativePosition = 0.6341463414634145
              // closetsProportion = 0.75
              final double closetsProportion = proportions.reduce((a, b) {
                return (a - relativePosition).abs() <
                        (b - relativePosition).abs()
                    ? a
                    : b;
              });
              onSelected(closetsProportion);
            },
            child: Row(
              children: proportions
                  .asMap()
                  .map((index, e) {
                    int selectedIndex = proportions.indexWhere((element) {
                      return element == selectedProportion;
                    });
                    return MapEntry(
                      index,
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: ProportionSliderItem(
                                proportion: e,
                                boxColor: selectedIndex == -1
                                    ? widget.unselectedBoxColor
                                    : selectedIndex >= index
                                        ? widget.selectedBoxColor
                                        : widget.unselectedBoxColor,
                                textColor: selectedProportion == e
                                    ? widget.selectedTextColor
                                    : widget.unselectedTextColor,
                                onSelect: () => onSelected(e),
                              ),
                            ),
                            if (index != proportions.length - 1)
                              SizedBox(width: 5)
                          ],
                        ),
                      ),
                    );
                  })
                  .values
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

class ProportionSliderItem extends StatelessWidget {
  const ProportionSliderItem({
    Key? key,
    required this.proportion,
    required this.boxColor,
    required this.textColor,
    required this.onSelect,
  }) : super(key: key);

  final double proportion;
  final Color boxColor;
  final Color textColor;
  final Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.all(Radius.circular(1)),
            ),
          ),
          SizedBox(height: 5),
          Text(
            '${proportion * 100}%',
            style: TextStyle(color: textColor),
          )
        ],
      ),
    );
  }
}
