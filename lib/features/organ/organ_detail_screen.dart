import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/dummy/dummy_health_data.dart';
import '../../../shared/widgets/hub_widgets.dart';
import '../hub/widgets/organ_metrics_menu.dart';

class OrganDetailScreen extends StatefulWidget {
  const OrganDetailScreen({super.key, required this.organId});

  final String organId;

  @override
  State<OrganDetailScreen> createState() => _OrganDetailScreenState();
}

class _OrganDetailScreenState extends State<OrganDetailScreen> {
  late String organId;
  bool menuExpanded = false;

  @override
  void initState() {
    super.initState();
    organId = widget.organId;
  }

  @override
  void didUpdateWidget(covariant OrganDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.organId != widget.organId) {
      organId = widget.organId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final organ = DummyHealthData.byId(organId);
    final accent = Color(organ.accent);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.8),
            radius: 1.15,
            colors: [
              accent.withValues(alpha: 0.22),
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  HubAppBar(
                    title: 'Phenotype',
                    trailing: IconButton(
                      onPressed: () =>
                          setState(() => menuExpanded = !menuExpanded),
                      icon: Icon(
                        menuExpanded
                            ? Icons.close_rounded
                            : Icons.menu_rounded,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
                      children: [
                        GlowSectionTitle('${organ.name} Conditions Overview'),
                        HolographicOrganStage(
                          asset: organ.stageAsset,
                          callouts: organ.callouts,
                          onDetails: () => context.push('/metric/mentzer'),
                        ),
                        const SizedBox(height: 8),
                        GlowSectionTitle('${organ.name} Condition'),
                        Center(
                          child: AnimatedScoreRing(
                            score: organ.score,
                            accent: accent,
                          ),
                        ),
                        const SizedBox(height: 16),
                        RecommendationCard(
                          title: '${organ.name} Health Recommendation :',
                          bullets: organ.recommendations,
                          glow: AppColors.cyan,
                        ),
                        const SizedBox(height: 16),
                        MarkerChipGrid(
                          title: 'Strengths :',
                          items: organ.strengths,
                          color: AppColors.neonGreen,
                        ),
                        const SizedBox(height: 14),
                        MarkerChipGrid(
                          title: 'Weakness :',
                          items: organ.weaknesses,
                          color: AppColors.red,
                        ),
                        const SizedBox(height: 18),
                        GlowSectionTitle(
                          'Chronic ${organ.name} Disease Risk Assessment',
                        ),
                        ...organ.riskMetrics.map(
                          (m) => RiskMetricTile(
                            metric: m,
                            onTap: () => context.push('/metric/mentzer'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 64,
                right: 10,
                child: OrganMetricsMenu(
                  selectedId: organId,
                  expanded: menuExpanded,
                  onToggleExpanded: () {
                    setState(() => menuExpanded = !menuExpanded);
                  },
                  onSelect: (id) {
                    setState(() {
                      organId = id;
                      menuExpanded = false;
                    });
                  },
                  onBloodMetrics: () => context.push('/metric/mentzer'),
                  onHormone: () {
                    setState(() {
                      organId = 'brain';
                      menuExpanded = false;
                    });
                  },
                ).animate().fadeIn(duration: 200.ms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
