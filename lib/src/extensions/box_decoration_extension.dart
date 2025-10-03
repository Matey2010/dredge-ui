import 'package:flutter/material.dart';

extension BoxDecorationMerge on BoxDecoration {
  BoxDecoration merge(BoxDecoration? other) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      image: other.image,
      border: other.border,
      borderRadius: other.borderRadius,
      boxShadow: other.boxShadow,
      gradient: other.gradient,
      backgroundBlendMode: other.backgroundBlendMode,
      shape: other.shape,
    );
  }
}
