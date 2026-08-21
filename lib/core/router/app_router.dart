import 'package:go_router/go_router.dart';
import '../../features/hub/health_hub_screen.dart';
import '../../features/metric_detail/mentzer_detail_screen.dart';
import '../../features/organ/organ_detail_screen.dart';
import '../../features/community/community_landing_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'hub',
        builder: (context, state) => const HealthHubScreen(),
      ),
      GoRoute(
        path: '/organ/:id',
        name: 'organ',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'heart';
          return OrganDetailScreen(organId: id);
        },
      ),
      GoRoute(
        path: '/metric/mentzer',
        name: 'mentzer',
        builder: (context, state) => const MentzerDetailScreen(),
      ),
      GoRoute(
        path: '/community',
        name: 'community',
        builder: (context, state) => const CommunityLandingScreen(),
      ),
    ],
  );
}
