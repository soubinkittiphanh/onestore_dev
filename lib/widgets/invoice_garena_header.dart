import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InvoiceHeaderGarena extends StatelessWidget {
  const InvoiceHeaderGarena({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(
              "https://spng.subpng.com/20190626/jrs/kisspng-garena-computer-icons-logo-portable-network-graphi-19-panther-svg-gambar-huge-freebie-download-for-p-5d1397268c6822.0739589915615649665751.jpg",
              width: 20,
            ),
            const Text(
              "GARENA FREE FIRE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.network(
              "https://spng.subpng.com/20190626/jrs/kisspng-garena-computer-icons-logo-portable-network-graphi-19-panther-svg-gambar-huge-freebie-download-for-p-5d1397268c6822.0739589915615649665751.jpg",
              width: 20,
            ),
          ],
        ),
        Row(
          children: const [
            Text("ລາຄາ          "),
            Text("          ຮັບເພັດ"),
          ],
        ),
        Row(
          children: [
            const Text("10,000 ________ 68 ເພັດ"),
            Image.network(
              "https://s3.amazonaws.com/freestock-prod/450/freestock_567173587.jpg",
              width: 20,
            ),
          ],
        ),
        Row(
          children: [
            const Text("22,000 ________ 172 ເພັດ"),
            Image.network(
              "https://s3.amazonaws.com/freestock-prod/450/freestock_567173587.jpg",
              width: 20,
            ),
          ],
        ),
        Row(
          children: [
            const Text("40,000 ________ 344 ເພັດ"),
            Image.network(
              "https://s3.amazonaws.com/freestock-prod/450/freestock_567173587.jpg",
              width: 20,
            ),
          ],
        ),
        Row(
          children: [
            const Text("60,000 ________ 517 ເພັດ"),
            Image.network(
              "https://s3.amazonaws.com/freestock-prod/450/freestock_567173587.jpg",
              width: 20,
            ),
          ],
        ),
        Row(
          children: [
            const Text("120,000 ________ 1052 ເພັດ"),
            Image.network(
              "https://s3.amazonaws.com/freestock-prod/450/freestock_567173587.jpg",
              width: 20,
            ),
          ],
        ),
        Row(
          children: [
            const Text("200,000 ________ 1800 ເພັດ"),
            Image.network(
              "https://s3.amazonaws.com/freestock-prod/450/freestock_567173587.jpg",
              width: 20,
            ),
          ],
        ),
        Row(
          children: [
            const Text("400,000 ________ 3698 ເພັດ"),
            Image.network(
              "https://s3.amazonaws.com/freestock-prod/450/freestock_567173587.jpg",
              width: 20,
            ),
          ],
        ),
      ],
    );
  }
}
