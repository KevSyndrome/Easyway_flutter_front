import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'core/theme/light_theme.dart';
import 'core/theme/dark_theme.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('Warning: .env file not found, using empty token');
  }
  final token = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
  print('MAPBOX TOKEN: ${token.isNotEmpty ? "CARGADO" : "VACIO"}');
  MapboxOptions.setAccessToken(token);
  runApp(const ProviderScope(child: EasyWayApp()));
}

class EasyWayApp extends ConsumerWidget {
  const EasyWayApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'EasyWay',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: authState.isAuthenticated
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
