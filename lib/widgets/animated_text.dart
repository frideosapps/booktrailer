import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:frideos/frideos.dart';

import 'package:booktrailer/models/models.dart';

class AnimatedTextScale extends StatelessWidget {
  AnimatedTextScale({
    Key key,
    @required this.width,
    @required this.texts,
    this.onAnimating,
    this.onCompleted,
    this.isLastScene = false,
    this.reverse = false,
    this.duration = 10000,
  }) : super(key: key);

  final double width;
  final Function onCompleted;
  final Function(double progress) onAnimating;
  final List<String> texts;
  final bool isLastScene;
  final bool reverse;
  final int duration;

  double _scale(width) {
    if (width <= 480.0) return 1.0;

    if (width <= 1024) return 2.0;

    return (width / 480.0) * 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return CompositeAnimationWidget(
      duration: duration,
      repeat: false,
      compositeMap: {
        AnimationType.fadeIn: CompositeTween<double>(
          begin: 0.2,
          end: 1.0,
          curve: const Interval(
            0.0,
            0.2,
            curve: Curves.linear,
          ),
        ),
        AnimationType.scale: CompositeTween<double>(
          begin: reverse ? 0.8 : 1.0,
          end: reverse ? 1.0 : 0.8,
          curve: const Interval(
            0.2,
            0.6,
            curve: Curves.linear,
          ),
        ),
        AnimationType.fadeOut: CompositeTween<double>(
          begin: 1.0,
          end: 0.0,
          curve: Interval(
            isLastScene ? 0.8 : 0.7,
            isLastScene ? 1.0 : 0.8,
            curve: Curves.linear,
          ),
        ),
      },
      onCompleted: onCompleted,
      builder: (context, comp) {
        if (onAnimating != null) onAnimating(comp.progress);

        return Transform.scale(
          scale: comp.value(AnimationType.scale) * _scale(width),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i <= texts.length - 1; i++)
                Opacity(
                  opacity: comp.value(AnimationType.fadeIn),
                  child: Opacity(
                    opacity: comp.value(AnimationType.fadeOut),
                    child: Text(
                      texts[i],
                      style: TextStyle(
                        letterSpacing: width > 480.0 ? 0.5 : 0.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        fontSize: 22.0,
                        height: 1.5,
                        shadows: [
                          Shadow(
                            blurRadius: 1.0,
                            color: Colors.grey[800],
                            offset: Offset(0.1, 0.1),
                          ),
                          Shadow(
                            blurRadius: 1.0,
                            color: Colors.black,
                            offset: Offset(0.2, 0.2),
                          ),
                          Shadow(
                            blurRadius: 1.0,
                            color: Colors.white,
                            offset: Offset(0.5, 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class AnimatedTextSplit extends StatefulWidget {
  AnimatedTextSplit({
    Key key,
    @required this.width,
    @required this.texts,
    this.onAnimating,
    this.onCompleted,
    this.reverse = false,
    this.duration = 10000,
  }) : super(key: key);

  final double width;
  final Function onCompleted;
  final Function(double progress) onAnimating;
  final List<String> texts;
  final bool reverse;
  final int duration;

  @override
  _AnimatedTextSplitState createState() => _AnimatedTextSplitState();
}

class _AnimatedTextSplitState extends State<AnimatedTextSplit> {
  final List<List<String>> words = [];

  double letterSpacing;

  @override
  void initState() {
    super.initState();
    for (var sentence in widget.texts) {
      words.add(sentence.split(' '));
    }

    letterSpacing = widget.width > 480.0 ? 0.5 : 0.0;
  }

  Offset _wordPosition(int i, int j, double animValue) {
    final dirOuter = i.isEven ? -6 : 3;
    final dirInner = j.isEven ? -6 : 3;
    final movX = (i.isEven ? 2 : -6);
    final movY = (j.isEven ? 2 : -9);

    return Offset(
      animValue * dirInner * dirOuter * movX,
      animValue * dirInner * dirOuter * movY,
    );
  }

  double _fontSize(String text) {
    if (widget.width > 480.0) return 22.0;

    if (text.length < 20) return 20.0;

    return 18.0;
  }

  Color _textColor(isEven, int animValue) {
    return isEven
        ? Color.fromRGBO(animValue, animValue, 170, 1.0)
        : Color.fromRGBO(170, 170, 170, 1.0);
  }

  double _scale(width) {
    if (width <= 480.0) return 1.0;

    if (width <= 1024) return 2.0;

    return (width / 480.0) * 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return CompositeAnimationWidget(
      duration: widget.duration,
      repeat: false,
      compositeMap: {
        AnimationType.fadeIn: CompositeTween<double>(
          begin: 0.0,
          end: 1.0,
          curve: const Interval(
            0.0,
            0.4,
            curve: Curves.linear,
          ),
        ),
        AnimationType.mov: CompositeTween<double>(
          begin: 0.5,
          end: 0.0,
          curve: const Interval(
            0.0,
            0.5,
            curve: Curves.linearToEaseOut,
          ),
        ),
        AnimationType.grow: CompositeTween<double>(
          begin: 1.5,
          end: 1.0,
          curve: const Interval(
            0.2,
            0.6,
            curve: Curves.linearToEaseOut,
          ),
        ),
        AnimationType.color: CompositeTween<int>(
          begin: 255,
          end: 170,
          curve: const Interval(
            0.3,
            0.6,
            curve: Curves.linear,
          ),
        ),
        AnimationType.fadeOut: CompositeTween<double>(
          begin: 1.0,
          end: 0.0,
          curve: Interval(
            0.6,
            0.8,
            curve: Curves.linear,
          ),
        ),
      },
      onCompleted: widget.onCompleted,
      builder: (context, comp) {
        if (widget.onAnimating != null) widget.onAnimating(comp.progress);

        return Transform.scale(
          scale: _scale(widget.width),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i <= words.length - 1; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var j = 0; j <= words[i].length - 1; j++)
                      Transform.translate(
                        offset: _wordPosition(
                          i,
                          j,
                          comp.value(AnimationType.mov),
                        ),
                        child: Opacity(
                          opacity: comp.value(AnimationType.fadeIn),
                          child: Opacity(
                            opacity: comp.value(AnimationType.fadeOut),
                            child: Padding(
                              padding: EdgeInsets.all(
                                  widget.width > 480 ? 2.0 : 1.0),
                              child: Transform.scale(
                                scale: (j.isEven
                                    ? comp.value(AnimationType.grow)
                                    : 1.0),
                                child: Text(
                                  words[i][j],
                                  style: TextStyle(
                                    letterSpacing: letterSpacing,
                                    color: _textColor(
                                      j.isEven,
                                      comp.valueInt(AnimationType.color),
                                    ),
                                    fontWeight: FontWeight.w500,
                                    fontSize: _fontSize(words[i][j]),
                                    shadows: [
                                      Shadow(
                                        blurRadius: 1.0,
                                        color: Colors.grey[800],
                                        offset: Offset(0.1, 0.1),
                                      ),
                                      Shadow(
                                        blurRadius: 1.0,
                                        color: Colors.black,
                                        offset: Offset(0.2, 0.2),
                                      ),
                                      Shadow(
                                        blurRadius: 1.0,
                                        color: Colors.white,
                                        offset: Offset(0.5, 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                )
            ],
          ),
        );
      },
    );
  }
}

class AnimatedText extends StatelessWidget {
  AnimatedText({
    Key key,
    @required this.textAnimationType,
    @required this.width,
    @required this.texts,
    this.onAnimating,
    this.onCompleted,
    this.reverse = false,
    this.duration = 10000,
  }) : super(key: key);

  final TextAnimationType textAnimationType;
  final double width;
  final Function onCompleted;
  final Function(double progress) onAnimating;
  final List<String> texts;
  final bool reverse;
  final int duration;

  @override
  Widget build(BuildContext context) {
    switch (textAnimationType) {
      case TextAnimationType.split:
        return AnimatedTextSplit(
          texts: texts,
          width: width,
          onAnimating: onAnimating,
          onCompleted: onCompleted,
          reverse: reverse,
          duration: duration,
        );
        break;
      default:
        return AnimatedTextScale(
          texts: texts,
          width: width,
          onAnimating: onAnimating,
          onCompleted: onCompleted,
          reverse: reverse,
          duration: duration,
        );
    }
  }
}
