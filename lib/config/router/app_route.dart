import 'package:go_router/go_router.dart';
import 'package:pelusas/presentation/pages/detail_breed/breed_detail_screen.dart';
import 'package:pelusas/presentation/pages/home_breeds/breeds_home_page.dart';

import 'app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutesEnum.breeds.path,
  routes: [
    GoRoute(
      path: AppRoutesEnum.breeds.path,
      builder: (context, state) => const BreedsHomePage(),
    ),
    GoRoute(
        path: AppRoutesEnum.detail.path,
        builder: (context, state) {
          return BreedDetailScreen();
        }
    )
  ],
  redirect: (context, state) {
    return null;
  },
);