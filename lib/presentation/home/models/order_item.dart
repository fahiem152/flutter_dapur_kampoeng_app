import 'package:dapur_kampoeng_app/presentation/home/models/product_model.dart';

class OrderItem {
  final ProductModel product;
  int quantity;
  OrderItem({
    required this.product,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItem &&
        other.product == product &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;
}
