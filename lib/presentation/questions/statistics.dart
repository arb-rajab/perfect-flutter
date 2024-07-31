import 'package:beta/configs/style.dart';
import 'package:beta/constants/string_constant.dart';
import 'package:beta/domain/question_statistic.dart';
import 'package:beta/presentation/questions/indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Statistics extends StatefulWidget {
  final QuestionStatistic questionStatistic;
  const Statistics(
      {super.key,
      required this.questionStatistic});

  @override
  State<StatefulWidget> createState() => _StatisticState();
}

class _StatisticState extends State<Statistics> {
  int chart1TouchedIndex = -1;
  int chart2TouchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Column(
                children: [
                  SizedBox(
                    width: 10,
                    height: 10,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                chart1TouchedIndex = -1;
                                return;
                              }
                              chart1TouchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                chart2TouchedIndex = -1;
                                return;
                              }
                              chart2TouchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections2(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Theme.of(context).primaryColorDark,
                text: StringConstant.total.tr(),
                isSquare: true,
              ),
              const SizedBox(
                height: halfMargin,
              ),
              Indicator(
                color: Theme.of(context).primaryColor,
                text: StringConstant.answered.tr(),
                isSquare: true,
              ),
              const SizedBox(
                height: halfMargin,
              ),
              Indicator(
                color: Colors.green,
                text: StringConstant.correct.tr(),
                isSquare: true,
              ),
              const SizedBox(
                height: halfMargin,
              ),
              Indicator(
                color: Colors.red,
                text: StringConstant.wrong.tr(),
                isSquare: true,
              ),
              const SizedBox(
                height: doubleMargin,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(1, (i) {
      final isTouched = i == chart1TouchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Theme.of(context).primaryColor,
            value: widget.questionStatistic.answered *
                100 /
                widget.questionStatistic.total,
            title:
                '${widget.questionStatistic.answered * 100 / widget.questionStatistic.total}% (${widget.questionStatistic.answered}/${widget.questionStatistic.total})',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> showingSections2() {
    return List.generate(2, (i) {
      final isTouched = i == chart2TouchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: widget.questionStatistic.correct *
                100 /
                widget.questionStatistic.total,
            title:
                '${widget.questionStatistic.correct * 100 / widget.questionStatistic.total}% (${widget.questionStatistic.correct}/${widget.questionStatistic.total})',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: widget.questionStatistic.wrong *
                100 /
                widget.questionStatistic.total,
            title:
                '${widget.questionStatistic.wrong * 100 / widget.questionStatistic.total}% (${widget.questionStatistic.wrong}/${widget.questionStatistic.total})',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
