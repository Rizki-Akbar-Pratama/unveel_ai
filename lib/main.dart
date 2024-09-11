import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/observers/bloc_observer_info.dart';
import 'core/routers/app_route_info.dart';
import 'service_locator.dart' as di;
import 'service_locator.dart';
import 'shared/configs/theme_config.dart';
import 'shared/extensions/locale_parsing.dart';
import 'shared/widgets/loadings/cubit/full_screen_loading/full_screen_loading_cubit.dart';
import 'shared/widgets/loadings/full_screen_loading_widget.dart';

Future<void> main() async {
  // Initialize app
  await init();

  runApp(const MainApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // bloc observer
  Bloc.observer = BlocObserverInfo();

  if (!kIsWeb) {
    // if not web, set orientation
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // Initialize dependency injection
  await di.init();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<FullScreenLoadingCubit>(),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: sl<AppRouteInfo>().route.routeInformationParser,
        routerDelegate: sl<AppRouteInfo>().route.routerDelegate,
        routeInformationProvider:
            sl<AppRouteInfo>().route.routeInformationProvider,
        theme: ThemeConfig.dark,
        themeMode: ThemeMode.dark,
        locale: SupportLocale.en.locale,
        supportedLocales: SupportLocale.values.map((e) {
          return e.locale;
        }).toList(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              BlocBuilder<FullScreenLoadingCubit, FullScreenLoadingState>(
                builder: (context, state) {
                  if (state is ShowFullScreenLoading) {
                    return FullScreenLoadingWidget(
                      message: state.message,
                    );
                  }

                  return const SizedBox.shrink();
                },
              )
            ],
          );
        },
      ),
    );
  }
}
