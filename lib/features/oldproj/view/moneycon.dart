import 'package:agman/core/common/texts.dart';
import 'package:flutter/material.dart';

class Moneycon extends StatelessWidget {
  final Color color;
  final String image;
  final String status;

  const Moneycon(
      {super.key,
      required this.color,
      required this.image,
      required this.status});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: color,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 14,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              height: 48,
              width: 48,
              child: Image.asset(image),
            ),
            const SizedBox(
              width: 7,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                        fontFamily: apptexts.appfonfamily,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  Text(
                    maxLines: 2,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    "1255   \$",
                    style: TextStyle(
                        fontFamily: apptexts.appfonfamily,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
