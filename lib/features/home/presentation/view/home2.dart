import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/widgets/cashedimage.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/features/accessories/presentation/views/accessories.dart';
import 'package:agman/features/auth/login/presentation/view/login.dart';
import 'package:agman/features/auth/profile/profile.dart';
import 'package:agman/features/components/presentation/views/components.dart';
import 'package:agman/features/customers/presentation/view/customer.dart';
import 'package:agman/features/factorytools/presentation/views/factorytools.dart';
import 'package:agman/features/moldmanufacture/presentation/view/molmanufacture.dart';
import 'package:agman/features/users/presentation/views/widgets/employees.dart';
import 'package:agman/features/injection/presentation/view/production.dart';
import 'package:agman/features/home/presentation/view/widgets/gridelement.dart';
import 'package:agman/features/materiales/presentation/views/material.dart';
import 'package:agman/features/molds/presentation/views/molds.dart';
import 'package:agman/features/orders/presentation/view/orders.dart';
import 'package:agman/features/save/presentation/view/saves.dart';
import 'package:agman/features/suppliers/presentation/view/suppliers.dart';
import 'package:agman/features/wallets/presentation/view/wallets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class home2 extends StatelessWidget {
  List<dynamic> categories = cashhelper.getdata(key: "permessions");
  List homegrid = [
    {
      "name": "الحقن",
      "name-en": "injections",
      "image": "assets/images/prod-removebg-preview.png",
      "page": production()
    },
    {
      "name": "اوردرات الحقن",
      "name-en": "injections_order",
      "image": "assets/images/manifest.png",
      "page": Orders()
    },
    {
      "name": "تصنيع الاسطمبات",
      "name-en": "stamp_manufacturing",
      "image": "assets/images/tooling.png",
      "page": moldmanufacture()
    },
    {
      "name": "الموظفين",
      "name-en": "employeesش",
      "image": "assets/images/division.png",
      "page": Login()
    },
    {
      "name": "المستخدمين",
      "name-en": "users",
      "image": "assets/images/team.png",
      "page": Employees()
    },
    {
      "name": "العملاء",
      "name-en": "customers",
      "image": "assets/images/public-service.png",
      "page": customers()
    },
    {
      "name": "الموردين",
      "name-en": "suppliers",
      "image": "assets/images/manager.png",
      "page": Suppliers()
    },
    {
      "name": "الخزينه",
      "name-en": "warehouse",
      "image": "assets/images/safe-deposit.png",
      "page": save()
    },
    {
      "name": "المحافظ الالكترونيه",
      "name-en": "warehouse",
      "image": "assets/images/wallet.png",
      "page": wallets()
    },
    {
      "name": "مخزن الخامات",
      "name-en": "material_store",
      "image": "assets/images/material-removebg-preview.png",
      "page": plasticMaterial()
    },
    {
      "name": "مخزن الاكسسوارات",
      "name-en": "accessories_store",
      "image": "assets/images/image_0901.png",
      "page": accessories()
    },
    {
      "name": "مخزن المكونات",
      "name-en": "components_store",
      "image": "assets/images/plastic-houhold.png",
      "page": plasticcomponent()
    },
    {
      "name": "مخزن ادوات المصنع",
      "name-en": "warehouse",
      "image": "assets/images/wa.png",
      "page": Factorytools()
    },
    {
      "name": "الاعدادات",
      "name-en": "settings",
      "image": "assets/images/settings.png",
      "page": profile()
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  cashhelper.getdata(key: "image") == null
                      ? Material(
                          // Replace this child with your own
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: AvatarGlow(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              radius: 30.0,
                              backgroundImage: AssetImage(
                                'assets/images/elbatol.png',
                              ),
                            ),
                          ),
                        )
                      : Material(
                          // Replace this child with your own
                          elevation: 8.0,
                          shape: CircleBorder(),
                          child: AvatarGlow(
                            child: imagefromrequest(
                              url: cashhelper.getdata(key: "image"),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      cashhelper.getdata(key: "name"),
                      style: const TextStyle(
                        fontFamily: "cairo",
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  badges.Badge(
                    onTap: () {},
                    position: badges.BadgePosition.topStart(top: -10),
                    badgeStyle: const badges.BadgeStyle(),
                    badgeContent: const Text(
                      '3',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      size: MediaQuery.sizeOf(context).width > 450 ? 32 : 30.sp,
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.count(
                  childAspectRatio: 1 / 0.8,
                  crossAxisCount: MediaQuery.sizeOf(context).width > 950
                      ? 6
                      : MediaQuery.sizeOf(context).width > 650
                          ? 4
                          : MediaQuery.sizeOf(context).width > 500
                              ? 3
                              : 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: homegrid
                      .map((e) => Gridelement(
                            true_false: !categories.contains(e["name-en"])
                                ? "assets/images/cross.png"
                                : "assets/images/newone.png",
                            text: e["name"],
                            image: e["image"],
                            onTap: () {
                              !categories.contains(e["name-en"])
                                  ? showdialogerror(
                                      error: "ليس لديك صلاحية الدخول للصفحه",
                                      context: context)
                                  : navigateto(
                                      context: context, page: e["page"]);
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/images/ac.jpg",
                ))),
      ),
    );
  }
}
