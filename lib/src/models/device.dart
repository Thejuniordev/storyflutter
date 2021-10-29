import 'package:flutter/material.dart';
import 'package:storyflutter/src/models/resolution.dart';

/// Category of different device types.
enum DeviceType {
  watch,
  mobile,
  tablet,
  desktop,
  unknown,
}

@immutable
class Device {
  final String name;

  final Resolution resolution;

  final DeviceType type;

  const Device({
    required this.name,
    required this.resolution,
    required this.type,
  });

  factory Device.custom({
    required String name,
    required Resolution resolution,
  }) {
    return Device(
      name: name,
      resolution: resolution,
      type: DeviceType.unknown,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Device &&
        other.name == name &&
        // other.resolution == resolution &&
        other.type == type;
  }

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}

/// Collection of Samsung devices
class Samsung {
  static const Device s21ultra = Device(
    name: 'S21 Ultra',
    type: DeviceType.mobile,
    resolution: Resolution(
      nativeSize: Size(1440, 3200),
      scaleFactor: 3.75,
    ),
  );
}

/// Collection of Apple devices
class Apple {
  static const Device iPhone7 = Device(
    name: 'iPhone 7',
    type: DeviceType.mobile,
    resolution: Resolution(
      nativeSize: Size(375, 667),
      scaleFactor: 2,
    ),
  );
}
