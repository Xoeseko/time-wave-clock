import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'cutout.dart';

class TimeWave extends StatelessWidget {
  final initDurations = [35000, 19440, 6000];
  final initGradients = [
                          [Colors.white, Colors.white],
                          [Colors.white, Colors.grey[700]],
                          [Colors.pink[700], Color(0xFFB52D44)]
                        ];
  final  height;
  final maxTime;

  final timePassed;

  final initStrokeWidth;

  final displayedTime;

  TimeWave({
    @required this.displayedTime,
    @required this.height,
    @required this.timePassed,
    @required this.maxTime,
    @required this.initStrokeWidth
  });


  @override 
  Widget build(context){
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: WaveWidget( 
            config: CustomConfig(
              durations: initDurations,
              gradients: initGradients,
              heightPercentages: computeRelativeHeights(timePassed, initGradients.length),
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),
            waveAmplitude: 0,
            backgroundColor: Colors.black,
            size: Size(double.infinity, height)
          ),
        ),
        Container( 
          child: CustomPaint( 
            painter: CutoutPainter(text: displayedTime, style: DefaultTextStyle.of(context).style)
          )
        ),
        Center( 
          child: Text(displayedTime,
          style: TextStyle(
            foreground: Paint()
              ..color = Colors.white
              ..style = PaintingStyle.stroke
              ..strokeWidth = initStrokeWidth 
          ))
        ),
      ],
    );

  }

  List<double> computeRelativeHeights(timePassed, nbWaves) {
    double relativeTime = timePassed / maxTime;
    double baseHeight = 1 - relativeTime;

    return [baseHeight-0.1, baseHeight-0.05, baseHeight];
  }

}