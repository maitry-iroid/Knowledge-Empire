import 'package:flutter/material.dart';
import 'dart:math';

import 'Particles.dart';

class ParticleModel {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;
  Random random;

  ParticleModel(this.random) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(0.05, random.nextDouble());
    final endPosition = Offset(9 * 0.5, 0.1);
    final duration = Duration(milliseconds: 6500 + random.nextInt(4000));

    tween = MultiTrackTween([
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.2 + random.nextDouble() * 0.4;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
//      restart(time: time);
    }
  }
}