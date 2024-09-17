import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/localdata.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/features/oldproj/group/data/repo/grouprepoimp.dart';

import 'package:agman/features/oldproj/group/presentation/viewmodel/groups/groups_cubit.dart';

import 'package:agman/features/splash/splash.dart';
import 'package:agman/firebase_options.dart';
import 'package:agman/home/presentation/view/home2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
            create: (context) => GroupsCubit(
              grouprepoimp: Grouprepoimp(),
            ),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
            builder: (_, child) {
              return MaterialApp(
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
            child: home2()));
  }
}
