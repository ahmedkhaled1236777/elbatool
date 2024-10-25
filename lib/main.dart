import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/localdata.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/auth/login/data/repos/authrepoimp.dart';
import 'package:agman/features/auth/login/presentation/view/login.dart';
import 'package:agman/features/auth/login/presentation/viewmodel/cubit/auth_cubit.dart';
import 'package:agman/features/customers/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:agman/features/users/data/repos/addemployeerepoimplementation.dart';
import 'package:agman/features/users/presentation/viewmodel/addemployee/addemployee_cubit.dart';
import 'package:agman/features/users/presentation/viewmodel/showemployeecuibt/employeecuibt.dart';
import 'package:agman/features/materiales/data/repos/materialrepoimp.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:agman/features/molds/data/repos/moldrepoimp.dart';
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';

import 'package:agman/features/orders/data/repos/orderrepoimp.dart';
import 'package:agman/features/save/presentation/viewmodel/save/save_cubit.dart';

import 'package:agman/features/suppliers/presentation/viewmodel/suppliers/suppliers_cubit.dart';
import 'package:agman/features/wallets/presentation/viewmodel/wallet/wallet_cubit.dart';
import 'package:agman/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'features/orders/presentation/viewmodel/cubit/orders_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Apiservice.initdio();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: DefaultSelectionStyle.defaultColor));
  await cashhelper.initcashhelper();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(EasyLocalization(
      path: "assets/translations",
      supportedLocales: [
        Locale("en"),
        Locale("ar"),
      ],
      saveLocale: true,
      startLocale: Locale("ar"),
      fallbackLocale: const Locale("ar"),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DateCubit(),
          ),
          BlocProvider(
            create: (context) =>
                showemployeescuibt(employeerepo: emplyeerepoimplementaion()),
          ),
          BlocProvider(
            create: (context) =>
                AddemployeeCubit(addemployeerepo: emplyeerepoimplementaion()),
          ),
          BlocProvider(
            create: (context) => AuthCubit(Authrepoimp()),
          ),
          BlocProvider(
            create: (context) => OrdersCubit(orderrepoimp()),
          ),
          BlocProvider(
            create: (context) => MoldCubit(Moldrepoimp()),
          ),
          BlocProvider(
            create: (context) => plasticMaterialCubit(Materialrepoimp()),
          ),
          BlocProvider(
            create: (context) => CustomersCubit(),
          ),
          BlocProvider(
            create: (context) => SupplierssCubit(),
          ),
          BlocProvider(
            create: (context) => SaveCubit(),
          ),
          BlocProvider(
            create: (context) => WalletCubit(),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
            builder: (_, child) {
              return GetMaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: child,
              );
            },
            child: Login()));
  }
}
