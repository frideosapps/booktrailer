import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
    this.progress,
  }) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60.0),
      alignment: Alignment.center,
      child: AnimationWidget<double>(
        begin: 0.1,
        end: 0.6,
        curve: Curves.easeIn,
        duration: 2550,
        repeat: true,
        builder: (context, anim) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: anim.value,
                child: Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                  ),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                children: [
                  Spacer(),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.black,
                      ),
                      Container(
                        height: 12,
                        width:
                            MediaQuery.of(context).size.width * progress * 0.5,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
