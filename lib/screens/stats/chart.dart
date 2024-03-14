import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarChart(),
    );
  }

  BarChartData mainBarChart(){
    return BarChartData(
      alignment: BarChartAlignment.center,
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false)
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false)
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: getTiles,
          )
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: leftTitles,
          )
        ),
      ),
      borderData: FlBorderData(
        show: false
      ),
      gridData: FlGridData(
        show: false
      ),
      barGroups: showingGroups(),
    );
  }

  Widget getTiles(double value, TitleMeta meta){
    const style=TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14
    );

    Widget text;

    switch(value.toInt()){
      case 0:
        text=const Text("JAN",style: style,);
        break;
      case 1:
        text=const Text("APR",style: style,);
        break;
      case 2:
        text=const Text("JUL",style: style,);
        break;
      case 3:
        text=const Text("OCT",style: style,);
        break;
      case 4:
        text=const Text("DEC",style: style,);
        break;
      default:
        text=const Text(' ',style: style,);
        break;
    }

    return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 18,
        child: text,
    );
  }


  Widget leftTitles(double value,TitleMeta meta){
    const style=TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14
    );

    String text;

    if(value==0){
      text="1k";
    }else if(value==2){
      text="2k";
    }else if(value==3){
      text="3k";
    }else if(value==4){
      text="4k";
    }else if(value==5){
      text="5k";
    }else if(value==8){
      text="5k";
    }else if(value==10){
      text="5k";
    }else if(value==9){
      text="5k";
    }else{
      return Container();
    }

    return SideTitleWidget(
        child: Text(text,style: style,),
        axisSide: meta.axisSide,
        space: 0,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
    switch(i){
      case 0:
        return makeGroupData(0,2);
      case 1:
        return makeGroupData(1,3);
      case 2:
        return makeGroupData(2,2);
      case 3:
        return makeGroupData(3,4.5);
      case 4:
        return makeGroupData(4,3.8);
      case 5:
        return makeGroupData(5,1.5);
      case 6:
        return makeGroupData(6,4);
      case 7:
        return makeGroupData(7,3.8);
      case 8:
        return makeGroupData(8,3.8);
      case 9:
        return makeGroupData(9,3.8);
      case 10:
        return makeGroupData(10,3.8);
      case 11:
        return makeGroupData(11,3.8);
      default:
        return throw Error();
    }
  });

  BarChartGroupData makeGroupData(int x,double y){
    return BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
              toY: y,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary
                ],
                transform: const GradientRotation(pi/40),
              ),
              width: 10,
              backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 5,
                  color: Colors.grey.shade300
              )
          )
        ]
    );
  }
}
