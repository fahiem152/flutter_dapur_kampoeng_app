import 'package:dapur_kampoeng_app/core/extensions/int_ext.dart';
import 'package:dapur_kampoeng_app/core/extensions/string_text.dart';
import 'package:dapur_kampoeng_app/presentation/home/models/product_quantity.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class PrintDataoutputs {
  PrintDataoutputs._init();

  static final PrintDataoutputs instance = PrintDataoutputs._init();

  Future<List<int>> printOrder(
      List<ProductQuantity> products,
      int totalQuantity,
      int totalPrice,
      String paymentMethod,
      int nominalBayar,
      String namaKasir,
      int discount,
      int discountpPercentage,
      int tax,
      int subTotal,
      int normalPrice,
      int refund) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    final pajak = totalPrice * 0.11;
    final total = totalPrice + pajak;
    // final ByteData data = await rootBundle.load('assets/images/qrcode.png');
    // final Uint8List imgBytes = data.buffer.asUint8List();
    // final img.Image image = img.decodeImage(imgBytes)!;

    // var ratio = image.width / image.height;
    // bytes += generator.imageRaster(img.copyResize(image,
    //     width: (40 * 2), height: (image.height * ratio).toInt()));
    bytes += generator.reset();
    bytes += generator.text('DAPUR KAMPOENG',
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ));

    bytes += generator.text(
        'Jalan Melati No. 12, Mranggen \nDemak, Central Java, 89568',
        styles: const PosStyles(bold: true, align: PosAlign.center));
    bytes += generator.text(
        'Date : ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.feed(1);
    bytes += generator.text('Pesanan:',
        styles: const PosStyles(bold: false, align: PosAlign.center));

    for (final product in products) {
      bytes += generator.text(product.product.name!,
          styles: const PosStyles(align: PosAlign.left));

      bytes += generator.row([
        PosColumn(
          text:
              '${product.product.price!.toIntegerFromText.currencyFormatRp} x ${product.quantity}',
          width: 8,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: '${product.product.price!.toIntegerFromText * product.quantity}'
              .toIntegerFromText
              .currencyFormatRp,
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    bytes += generator.feed(1);

    bytes += generator.row([
      PosColumn(
        text: 'Normal price',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: normalPrice.currencyFormatRp,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Diskon ($discountpPercentage%)',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: "- ${discount.currencyFormatRp}",
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Sub total',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: subTotal.currencyFormatRp,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Pajak (11%)',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: "+ ${tax.ceil().currencyFormatRp}",
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Final total',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: totalPrice.currencyFormatRp,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    // bytes += generator.beep();
    // bytes += generator.cut();
    // bytes += generator.drawer(pin: PosDrawer.pin2);
    // bytes += generator.emptyLines(10);
    // bytes += generator.feed(4);
    // bytes += generator.printCodeTable();
    bytes += generator.text("--------------------------------",
        styles: const PosStyles(bold: false, align: PosAlign.center));

    bytes += generator.row([
      PosColumn(
        text: 'Pembayaran',
        width: 8,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: paymentMethod,
        width: 4,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Bayar',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: nominalBayar.ceil().currencyFormatRp,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Kembalian',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: refund.currencyFormatRp,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.feed(1);
    bytes += generator.text('Terima kasih',
        styles: const PosStyles(bold: false, align: PosAlign.center));
    bytes += generator.feed(3);

    return bytes;
  }
}
