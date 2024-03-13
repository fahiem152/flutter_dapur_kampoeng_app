enum PrinterType {
  wifi('Wifi'),
  bluetooth('Bluetooth');

  final String value;
  const PrinterType(this.value);

  bool get isWifi => this == PrinterType.wifi;
  bool get isBluetooth => this == PrinterType.bluetooth;

  factory PrinterType.fromValue(String value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => PrinterType.wifi,
    );
  }
}

class PrinterModel {
  final String name;
  final String ipAddress;
  final String size;
  final PrinterType type;

  PrinterModel({
    required this.name,
    required this.ipAddress,
    required this.size,
    required this.type,
  });
}
