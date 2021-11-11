import 'package:flutter/material.dart';
import 'package:mix/src/attributes/animation/animation.attributes.dart';

class AnimationUtility {
  const AnimationUtility();

  AnimationAttributes animated({
    bool? animated = true,
    Curve? curve,
    Duration? duration,
  }) {
    return AnimationAttributes(
      animated: animated,
      animationCurve: curve,
      animationDuration: duration,
    );
  }
}