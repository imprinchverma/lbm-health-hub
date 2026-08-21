import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/dummy/dummy_health_data.dart';
import '../../../data/models/health_models.dart';
import '../../../shared/painters/health_painters.dart';
import '../../../shared/widgets/hub_widgets.dart';
import 'widgets/organ_metrics_menu.dart';

class HealthHubScreen extends StatefulWidget {
  const HealthHubScreen({super.key});

  @override
  State<HealthHubScreen> createState() => _HealthHubScreenState();
}

class _HealthHubScreenState extends State<HealthHubScreen> {
  bool phenotype = true;
  bool menuExpanded = true;
  String selectedOrgan = 'heart';
  bool serotonin = false;

  @override
  Widget build(BuildContext context) {
    final data = DummyHealthData.overview;
    final points = serotonin ? data.serotoninPoints : data.dopaminePoints;
    final chartPoints = points
        .map((p) => Offset(p.x / 120, ((p.y - 50) / 50).clamp(0.0, 1.0)))
        .toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.85),
            radius: 1.1,
            colors: [Color(0xFF102018), Colors.black],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  HubAppBar(
                    title: phenotype ? 'Phenotype' : 'Genotype',
                    hideBackIcon: true,
                  ),
                  GenotypePhenotypeToggle(
                    isPhenotype: phenotype,
                    onChanged: (v) => setState(() => phenotype = v),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GlowSectionTitle(
                                phenotype
                                    ? 'Health Conditions Overview'
                                    : 'Genomic Health Overview',
                              ),
                            ),
                            // Spacer so title doesn't collide with floating menu
                            const SizedBox(width: 170),
                          ],
                        ),
                        _bodyStage(),
                        const SizedBox(height: 8),
                        Center(child: _neuroToggle()),
                        const SizedBox(height: 18),
                        GlowSectionTitle(
                          serotonin
                              ? 'Serotonin Levels During Physical Activity'
                              : 'Dopamine Levels During Physical Activity',
                        ),
                        Container(
                          height: 210,
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: CustomPaint(
                            painter: GlowLineChartPainter(
                              points: chartPoints,
                              accent: AppColors.neonGreen,
                            ),
                          ),
                        ).animate().fadeIn(duration: 500.ms),
                        if (phenotype) ...[
                          const SizedBox(height: 18),
                          _aboutRow(
                            data.hyperprolactinemiaScore,
                            data.aboutText,
                          ),
                          const SizedBox(height: 18),
                          GlowSectionTitle('Immune system strength'),
                          Center(
                            child: AnimatedScoreRing(
                              score: data.immuneScore,
                              accent: AppColors.red,
                              size: 210,
                            ),
                          ),
                          const SizedBox(height: 16),
                          RecommendationCard(
                            title: 'Immune System Recommendation:',
                            bullets: data.recommendations,
                            glow: AppColors.cyan,
                          ),
                          const SizedBox(height: 16),
                          MarkerChipGrid(
                            title: 'Strengths :',
                            items: data.strengths,
                            color: AppColors.neonGreen,
                          ),
                          const SizedBox(height: 16),
                          MarkerChipGrid(
                            title: 'Weakness :',
                            items: data.weaknesses,
                            color: AppColors.red,
                          ),
                        ] else ...[
                          const SizedBox(height: 18),
                          RecommendationCard(
                            title: 'Genomic Insights:',
                            bullets: const [
                              'Your genetic markers suggest strong cardiovascular resilience.',
                              'Monitor lipid-related SNPs alongside lifestyle metrics.',
                              'Personalized nutrition can amplify genetic strengths.',
                            ],
                            glow: AppColors.neonGreen,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 108,
                right: 10,
                child: OrganMetricsMenu(
                  selectedId: selectedOrgan,
                  expanded: menuExpanded,
                  onToggleExpanded: () {
                    setState(() => menuExpanded = !menuExpanded);
                  },
                  onSelect: (id) {
                    setState(() {
                      selectedOrgan = id;
                      menuExpanded = false;
                    });
                    context.push('/organ/$id');
                  },
                  onBloodMetrics: () => context.push('/metric/mentzer'),
                  onHormone: () => context.push('/organ/brain'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyStage() {
    return SizedBox(
      height: 320,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            height: 140,
            child: CustomPaint(painter: HolographicBasePainter()),
          ),
          Positioned(
            bottom: 50,
            child: SizedBox(
              width: 170,
              height: 240,
              child: CustomPaint(
                painter: BodySilhouettePainter(highlightLungs: true),
              ),
            ),
          ),
          ...DummyHealthData.overview.bodyIssues.map((c) {
            return Align(
              alignment: c.alignment == CalloutAlign.midRight
                  ? Alignment.centerRight
                  : c.alignment == CalloutAlign.bottomLeft
                  ? Alignment.bottomLeft
                  : Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: CalloutBubble(
                  info: c,
                  onDetails: () => context.push('/organ/lungs'),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _neuroToggle() {
    return Container(
      height: 36,
      width: 220,
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: _chip('Dopamine', !serotonin, () {
              setState(() => serotonin = false);
            }, activeColor: AppColors.neonGreen),
          ),
          Expanded(
            child: _chip('Serotonin', serotonin, () {
              setState(() => serotonin = true);
            }, activeColor: AppColors.neonGreen),
          ),
        ],
      ),
    );
  }

  Widget _chip(
    String label,
    bool active,
    VoidCallback onTap, {
    required Color activeColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        margin: const EdgeInsets.all(3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _aboutRow(double score, String about) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cyan.withValues(alpha: 0.35)),
          ),
          child: Column(
            children: [
              Text(
                'Hyperprolactinemia Score',
                textAlign: TextAlign.center,
                style: GoogleFonts.michroma(fontSize: 8, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.biotech, color: AppColors.cyan, size: 34),
              const SizedBox(height: 8),
              Text(
                '${score.toStringAsFixed(0)}%',
                style: GoogleFonts.michroma(fontSize: 22, color: Colors.white),
              ),
              const Text(
                'Blood levels',
                style: TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ABOUT Hyperprolactinemia',
                style: GoogleFonts.michroma(fontSize: 11, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                about,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
