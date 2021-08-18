import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:ke_employee/helper/Utils.dart';

import 'ParticleModel.dart';

class Particles extends StatefulWidget {
  @override
  _ParticlesState createState() => _ParticlesState();
}

class _ParticlesState extends State<Particles> {
  final Random random = Random();

  ui.Image image;
  bool isImageLoaded = false;
  bool isFirstTimeDone = false;
  Canvas canvas;

  final List<ParticleModel> particles = [];

  @override
  void initState() {
    init();
    List.generate(100, (index) {
      particles.add(ParticleModel(random));
    });

    super.initState();
  }

  Future<Null> init() async {
    final ByteData data = await rootBundle.load(Utils.getAssetsImg('coin'));
    image = await loadImage(new Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      if (mounted)
        setState(() {
          isImageLoaded = true;
        });
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return new Rendering(
      canvas: canvas,
      builder: (context, time) {
        _simulateParticles(time);
        return CustomPaint(
          painter: ParticlePainter(particles, time, image, canvas),
        );
      },
    );
  }

  _simulateParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}

class ParticlePainter extends CustomPainter {
  List<ParticleModel> particles;
  Duration time;
  ui.Image image;
  Canvas canvas;

  ParticlePainter(this.particles, this.time, this.image, this.canvas);

  @override
  void paint(Canvas canvas, Size size) {
//    Future<ByteData> data = image.toByteData();
    try {
      this.canvas = canvas;
      final paint = Paint();

      particles.forEach((particle) {
        var progress = particle.animationProgress.progress(time);
        final animation = particle.tween.transform(progress);
        final position = Offset(animation["y"] * size.width, animation["x"] * size.height);
        //      canvas.drawCircle(position, size.width * 0.2 * particle.size, paint);
        canvas.drawImage(image, position, paint);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AnimationProgress {
  final Duration duration;
  final Duration startTime;

  /// Creates an [AnimationProgress].
  AnimationProgress({this.duration, this.startTime})
      : assert(duration != null, "Please specify an animation duration."),
        assert(startTime != null, "Please specify a start time of the animation.");

  /// Queries the current progress value based on the specified [startTime] and
  /// [duration] as a value between `0.0` and `1.0`. It will automatically
  /// clamp values this interval to fit in.
  double progress(Duration time) => max(0.0, min((time - startTime).inMilliseconds / duration.inMilliseconds, 1.0));
}

class MultiTrackTween extends Animatable<Map<String, dynamic>> {
  final _tracksToTween = Map<String, _TweenData>();
  var _maxDuration = 0;

  MultiTrackTween(List<Track> tracks)
      : assert(tracks != null && tracks.length > 0, "Add a List<Track> to configure the tween."),
        assert(tracks.where((track) => track.items.length == 0).length == 0, "Each Track needs at least one added Tween by using the add()-method.") {
    _computeMaxDuration(tracks);
    _computeTrackTweens(tracks);
  }

  void _computeMaxDuration(List<Track> tracks) {
    tracks.forEach((track) {
      final trackDuration = track.items.map((item) => item.duration.inMilliseconds).reduce((sum, item) => sum + item);
      _maxDuration = max(_maxDuration, trackDuration);
    });
  }

  void _computeTrackTweens(List<Track> tracks) {
    tracks.forEach((track) {
      final trackDuration = track.items.map((item) => item.duration.inMilliseconds).reduce((sum, item) => sum + item);

      final sequenceItems =
          track.items.map((item) => TweenSequenceItem(tween: item.tween, weight: item.duration.inMilliseconds / _maxDuration)).toList();

      if (trackDuration < _maxDuration) {
        sequenceItems.add(TweenSequenceItem(tween: ConstantTween(null), weight: (_maxDuration - trackDuration) / _maxDuration));
      }

      final sequence = TweenSequence(sequenceItems);

      _tracksToTween[track.name] = _TweenData(tween: sequence, maxTime: trackDuration / _maxDuration);
    });
  }

  /// Returns the highest duration specified by [Track]s.
  /// ---
  /// Use it to pass it into an [ControlledAnimation].
  ///
  /// You can also scale it by multiplying a double value.
  ///
  /// Example:
  /// ```dart
  ///   final tween = MultiTrackTween(listOfTracks);
  ///
  ///   return ControlledAnimation(
  ///     duration: tween.duration * 1.25, // stretch animation by 25%
  ///     tween: tween,
  ///     builder: (context, values) {
  ///        ...
  ///     }
  ///   );
  /// ```
  Duration get duration {
    return Duration(milliseconds: _maxDuration);
  }

  @override
  Map<String, dynamic> transform(double t) {
    final Map<String, dynamic> result = Map();
    _tracksToTween.forEach((name, tweenData) {
      final double tTween = max(0, min(t, tweenData.maxTime - 0.0001));
      result[name] = tweenData.tween.transform(tTween);
    });
    return result;
  }
}

class Track<T> {
  final String name;
  final List<_TrackItem> items = [];

  Track(this.name) : assert(name != null, "Track name must not be null.");

  /// Adds a "piece of animation" to a [Track].
  ///
  /// You need to pass a [duration] and a [tween]. It will return the track, so
  /// you can specify a track in a builder's style.
  ///
  /// Optionally you can set a named parameter [curve] that applies an easing
  /// curve to the tween.
  Track<T> add(Duration duration, Animatable<T> tween, {Curve curve}) {
    items.add(_TrackItem(duration, tween, curve: curve));
    return this;
  }
}

class _TrackItem<T> {
  final Duration duration;
  Animatable<T> tween;

  _TrackItem(this.duration, Animatable<T> _tween, {Curve curve})
      : assert(duration != null, "Please set a duration."),
        assert(_tween != null, "Please set a tween.") {
    if (curve != null) {
      tween = _tween.chain(CurveTween(curve: curve));
    } else {
      tween = _tween;
    }
  }
}

class _TweenData<T> {
  final Animatable<T> tween;
  final double maxTime;

  _TweenData({this.tween, this.maxTime});
}

class Rendering extends StatefulWidget {
  final Widget Function(BuildContext context, Duration timeElapsed) builder;
  final Function(Duration timeElapsed) onTick;
  final Duration startTime;
  final int startTimeSimulationTicks;
  final Canvas canvas;

  Rendering({this.builder, this.onTick, this.startTime = Duration.zero, this.startTimeSimulationTicks = 20, this.canvas})
      : assert(builder != null, "Builder needs to defined.");

  @override
  _RenderingState createState() => _RenderingState();
}

class _RenderingState extends State<Rendering> with SingleTickerProviderStateMixin {
  Ticker _ticker;
  Duration _timeElapsed = Duration(milliseconds: 5);

  @override
  void initState() {
    if (widget.startTime > Duration.zero) {
      _simulateStartTimeTicks();
    }

    _ticker = createTicker((elapsed) {
      _onRender(elapsed /*+ widget.startTime*/);
    });
    _ticker.start();

    super.initState();
  }

  void _onRender(Duration effectiveElapsed) {
    if (widget.onTick != null) {
      widget.onTick(effectiveElapsed);
    }
    if (mounted)
      setState(() {
        _timeElapsed = effectiveElapsed;
      });
  }

  void _simulateStartTimeTicks() {
    if (widget.onTick != null) {
      Iterable<int>.generate(widget.startTimeSimulationTicks + 1).forEach((i) {
        final simulatedTime = Duration(milliseconds: (widget.startTime.inMilliseconds * i / widget.startTimeSimulationTicks).round());
        widget.onTick(simulatedTime);
      });
    }
  }

  @override
  void dispose() {
    _ticker.stop(canceled: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _timeElapsed);
  }
}
