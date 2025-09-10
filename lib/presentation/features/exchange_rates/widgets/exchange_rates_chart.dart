import 'package:currency_converter/core/extensions/date_formatting.dart';
import 'package:currency_converter/core/extensions/num_formatting.dart';
import 'package:currency_converter/domain/entities/exchange_rate_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExchangeRatesChart extends StatelessWidget {
  final List<ExchangeRateEntity> exchangeRates;

  const ExchangeRatesChart({super.key, required this.exchangeRates});

  @override
  Widget build(BuildContext context) {
    final rates = exchangeRates.map((e) => e.rate ?? 0).toList();
    final dates = exchangeRates.map((e) => e.dateTime).toList();
    return SizedBox(
      height: 350,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: rates.length.toDouble(),
          minY: (rates.reduce((a, b) => a < b ? a : b) - 1),
          maxY: rates.reduce((a, b) => a > b ? a : b) + 1,
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                minIncluded: false,
                maxIncluded: false,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toMaxTwoDecimals(), // or format however you want
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 100,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= dates.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        dates[index]?.formattedDayMonthAbbr ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => Theme.of(context).primaryColor,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    spot.y.toStringAsFixed(2),
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                exchangeRates.length,
                (i) => FlSpot(i.toDouble(), rates[i].toDouble()),
              ),
              isCurved: true,
              barWidth: 2,
              dotData: FlDotData(show: true),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
