import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selous/core/constants/app_constants.dart';
import 'package:selous/core/utils/logger.dart';
import 'package:selous/presentation/bloc/app/app_bloc.dart';
import 'package:selous/presentation/pages/home_page.dart';
import 'package:selous/services/encryption_service.dart';
import 'package:selous/services/network_service.dart';
import 'package:selous/services/storage_service.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      
      // Set preferred orientations
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      
      // Initialize services
      final logger = AppLogger();
      logger.info('🚀 SELous App Initialization Started');
      
      try {
        // Initialize core services
        await StorageService().initialize();
        await EncryptionService().initialize();
        await NetworkService().initialize();
        
        logger.info('✅ All services initialized successfully');
        
        runApp(const SELousApp());
      } catch (e, stackTrace) {
        logger.error('❌ Failed to initialize app', error: e, stackTrace: stackTrace);
        runApp(const ErrorApp());
      }
    },
    (error, stack) {
      developer.log('Unhandled error', error: error, stackTrace: stack);
    },
  );
}

class SELousApp extends StatelessWidget {
  const SELousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppBloc(
            networkService: NetworkService(),
            encryptionService: EncryptionService(),
          )..add(const AppStarted()),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppConstants.primaryColor,
            brightness: Brightness.light,
          ),
          fontFamily: 'Inter',
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppConstants.primaryColor,
            brightness: Brightness.dark,
          ),
          fontFamily: 'Inter',
        ),
        home: const HomePage(),
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Initialization Failed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Please restart the app'),
            ],
          ),
        ),
      ),
    );
  }
}
