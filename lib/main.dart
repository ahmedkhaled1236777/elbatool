import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/localdata.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/accessories/data/repos/accessorierepoimp.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:agman/features/accessories/presentation/views/accessories.dart';
import 'package:agman/features/auth/login/data/repos/authrepoimp.dart';
import 'package:agman/features/auth/login/presentation/view/login.dart';
import 'package:agman/features/auth/login/presentation/viewmodel/cubit/auth_cubit.dart';
import 'package:agman/features/components/presentation/viewmodel/cubit/component_cubit.dart';
import 'package:agman/features/customers/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:agman/features/factorytools/data/repos/factorytoolsrepoimp.dart';
import 'package:agman/features/factorytools/presentation/viewmodel/factorytools/factorytools_cubit.dart';
import 'package:agman/features/home/presentation/view/home2.dart';
import 'package:agman/features/injection/data/repo/injectiomrepoimp.dart';
import 'package:agman/features/injection/presentation/viewmodel/cubit/injection_cubit.dart';
import 'package:agman/features/moldmanufacture/data/repo/moldmanufacturerepoimp.dart';
import 'package:agman/features/moldmanufacture/presentation/view/accessoriescost/data/repos/accessoriecostrepoimp.dart';
import 'package:agman/features/moldmanufacture/presentation/view/accessoriescost/presentation/viewmodel/cubit/accessoriecost_cubit.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/repos/intialcostrepoimp.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/viewmodel/cubit/intialcost_cubit.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/data/repos/industerialcostrepoimp.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/presentation/viewmodel/cubit/industerialcostcuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/data/repos/machinerepoimp.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/presentation/viewmodel/cubit/induxterialcost_cubit.dart';
import 'package:agman/features/moldmanufacture/presentation/view/molmanufacture.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:agman/features/oldproj/view/home.dart';
import 'package:agman/features/wallets/data/repos/walletrepoimp.dart';
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
                IntialcostCubit(intialcostrepoimp: Intialcostrepoimp()),
          ),
          BlocProvider(
            create: (context) => FactorytoolsCubit(Factorytoolsrepoimp()),
          ),
          BlocProvider(
            create: (context) => InjectionCubit(Injectiomrepoimp()),
          ),
          BlocProvider(
            create: (context) => IndusterialcostCubit(
                industerialcostrepoimp: Industerialcostrepoimp()),
          ),
          BlocProvider(
            create: (context) => accessoriecostCubit(
                accessoriecostrepo: Accessoriecostrepoimp()),
          ),
          BlocProvider(
            create: (context) =>
                AddemployeeCubit(addemployeerepo: emplyeerepoimplementaion()),
          ),
          BlocProvider(
            create: (context) => AuthCubit(Authrepoimp()),
          ),
          BlocProvider(
            create: (context) => InduxterialcostCubit(Machinerepoimp()),
          ),
          BlocProvider(
            create: (context) => OrdersCubit(orderrepoimp()),
          ),
          BlocProvider(
            create: (context) => plasticcomponentCubit(),
          ),
          BlocProvider(
            create: (context) =>
                plasticaccessoriesCubit(accessorierepoimp: Accessorierepoimp()),
          ),
          BlocProvider(
            create: (context) => MoldCubit(Moldrepoimp()),
          ),
          BlocProvider(
            create: (context) => Costcuibt(Moldmanufacturerepoimp()),
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
            create: (context) => WalletCubit(Walletrepoimp()),
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
            child:
                cashhelper.getdata(key: "token") == null ? Login() : home2()));
  }
}
