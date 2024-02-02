import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pets_app/cubit/pets_cubit.dart';

import '../screens/details_page.dart';
import '../screens/home_page.dart';
import '../src/adopted/darkmode_controller.dart';
import '../screens/history_page.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.themeController,
  });

  final DarkModeController themeController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (BuildContext context, Widget? child) {
        return BlocProvider(
          create: (context) => PetsCubit(),
          child: MaterialApp(
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
            ],
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: themeController.themeMode,
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case History.routeName:
                      return const History();
                    case DetailsPage.routeName:
                      final id = routeSettings.arguments as int;
                      return DetailsPage(id: id);
                    case HomePage.routeName:
                    default:
                      return HomePage(controller: themeController);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
