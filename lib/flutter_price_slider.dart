library flutter_price_slider;

import 'package:flutter/material.dart';

class FlutterPriceSlider extends StatefulWidget {
  const FlutterPriceSlider({
    Key? key,
    required this.selectedBoxColor,
    required this.unselectedBoxColor,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    required this.onSelectedProportion,
  }) : super(key: key);

  final Color selectedBoxColor;
  final Color unselectedBoxColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Function(double) onSelectedProportion;

  @override
  _FlutterPriceSliderState createState() => _FlutterPriceSliderState();
}

class _FlutterPriceSliderState extends State<FlutterPriceSlider> {
  List<double> proportions = [0.25, 0.5, 0.75, 1];
  double selectedProportion = 0;

  void onSelect(double proportion) {
    selectedProportion = proportion;
    setState(() {});
    widget.onSelectedProportion(selectedProportion);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: LayoutBuilder(
        builder: (_, constraints) {
          print("maxWidth: ${constraints.maxWidth}");

          double maxWidth = constraints.maxWidth;

          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.deferToChild,
            onPanUpdate: (details) {
              // start point (left top): 1.0
              double dx = details.localPosition.dx;
              if (dx < 0) {
                onSelect(0);
                return;
              }

              // 計翻相對於父組件既比例
              // maxWidth = 220, dx = 148.5714285714858
              // relativePosition = 0.6341463414634145
              double relativePosition = dx / maxWidth;

              // 尋找relativePosition最接近的"比例"
              // relativePosition = 0.6341463414634145
              // closetsProportion = 0.75
              final double closetsProportion = proportions.reduce((a, b) {
                return (a - relativePosition).abs() <
                        (b - relativePosition).abs()
                    ? a
                    : b;
              });
              onSelect(closetsProportion);
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
                                onSelect: () => onSelect(e),
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
            // style: CompetitionTheme.textStyle10.copyWith(color: textColor),
          )
        ],
      ),
    );
  }
}
