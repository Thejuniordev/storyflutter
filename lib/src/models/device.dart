import 'package:flutter/material.dart';
// import 'package:widgetbook/src/models/resolution.dart';

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
  const Device({
    required this.name,
    // required this.resolution,
    required this.type,
  });

  factory Device.custom({
    required String name,
    // required Resolution resolution,
  }) {
    return Device(
      name: name,
      // resolution: resolution,
      type: DeviceType.unknown,
    );
  }

  /// For example 'iPhone 12' or 'Samsung S10'.
  final String name;

  // final Resolution resolution;

  final DeviceType type;

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
  );
}

// For apple phone sizes and layout see:
// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/

/// Collection of Apple devices
class Apple {
  static const Device iPadPro12inch = Device(
    name: '12.9" iPad Pro',
    type: DeviceType.tablet,
  );
}
