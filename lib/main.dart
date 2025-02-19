import 'package:flutter/material.dart';
import 'package:gastro_go_app/features/detail/detail_screen.dart';
import 'package:gastro_go_app/features/main_screen.dart';
import 'package:gastro_go_app/model/api/api_service.dart';
import 'package:gastro_go_app/model/data/database_service/local_database_service.dart';
import 'package:gastro_go_app/provider/bottom_nav_provider.dart';
import 'package:gastro_go_app/provider/favorite_restaurant_provider.dart';
import 'package:gastro_go_app/provider/icon_favorite_provider.dart';
import 'package:gastro_go_app/provider/restaurant_detail_provider.dart';
import 'package:gastro_go_app/provider/restaurant_list_provider.dart';
import 'package:gastro_go_app/routes/navigation_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context)=> IconFavoriteProvider(),
      ),
      Provider(
        create: (context) => LocalDatabaseService(),
      ),
      ChangeNotifierProvider(
          create: (context) =>
              FavoriteRestaurantProvider(context.read<LocalDatabaseService>())),
      ChangeNotifierProvider(create: (context) => BottomNavProvider()),
      Provider(create: (context) => ApiService()),
      ChangeNotifierProvider(
        create: (context) => RestaurantListProvider(context.read<ApiService>()),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            RestaurantDetailProvider(context.read<ApiService>()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: NavigationRoutes.mainRoute.name,
      routes: {
        NavigationRoutes.mainRoute.name: (context) => const MainScreen(),
        NavigationRoutes.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
