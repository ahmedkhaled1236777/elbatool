import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Costgridelement extends StatelessWidget {
  final String cost;
  final String desc;
  var color;

  void Function()? onTap;
  Costgridelement({
    super.key,
    required this.cost,
    required this.desc,
    required this.color,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                  child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
                child: Text(
                  desc,
                  style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).width > 850
                        ? 5.sp
                        : MediaQuery.sizeOf(context).width > 600
                            ? 9.sp
                            : 15.sp,
                    fontFamily: "cairo",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7))),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                      child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        cost,
                        style: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).width > 850
                              ? 5.sp
                              : MediaQuery.sizeOf(context).width > 600
                                  ? 9.sp
                                  : 15.sp,
                          fontFamily: "cairo",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))),
              SizedBox(
                height: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
