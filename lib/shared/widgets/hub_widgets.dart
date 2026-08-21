import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/health_models.dart';
import '../painters/health_painters.dart';

class HubAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HubAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
    this.titleColor,
    this.hideBackIcon = false,
  });

  final String title;
  final bool hideBackIcon;
  final VoidCallback? onBack;
  final Widget? trailing;
  final Color? titleColor;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            if (hideBackIcon)
              SizedBox(width: 50,)
            else
              IconButton(
                onPressed: onBack ?? () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.michroma(
                  color: titleColor ?? AppColors.textPrimary,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ),
            trailing ??
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.smart_toy_outlined, size: 22),
                ),
          ],
        ),
      ),
    );
  }
}

class GenotypePhenotypeToggle extends StatelessWidget {
  const GenotypePhenotypeToggle({
    super.key,
    required this.isPhenotype,
    required this.onChanged,
  });

  final bool isPhenotype;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 48),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          _seg('Genotype', !isPhenotype, () => onChanged(false)),
          _seg('Phenotype', isPhenotype, () => onChanged(true)),
        ],
      ),
    );
  }

  Widget _seg(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: 220.ms,
          margin: const EdgeInsets.all(3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: active
                ? LinearGradient(
                    colors: [
                      AppColors.neonGreen.withValues(alpha: 0.25),
                      AppColors.surface,
                    ],
                  )
                : null,
            border: active
                ? Border.all(color: AppColors.neonGreen.withValues(alpha: 0.5))
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.michroma(
              fontSize: 11,
              color: active ? AppColors.neonGreen : AppColors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}

class CalloutBubble extends StatelessWidget {
  const CalloutBubble({super.key, required this.info, this.onDetails});

  final CalloutInfo info;
  final VoidCallback? onDetails;

  @override
  Widget build(BuildContext context) {
    final color = info.isPositive ? AppColors.neonGreen : AppColors.orange;
    return Container(
      constraints: const BoxConstraints(maxWidth: 150),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.85)),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            info.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              height: 1.25,
            ),
          ),
          if (info.detailLink) ...[
            const SizedBox(height: 4),
            GestureDetector(
              onTap: onDetails,
              child: Text(
                'View in Details ->',
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class HolographicOrganStage extends StatelessWidget {
  const HolographicOrganStage({
    super.key,
    required this.asset,
    required this.callouts,
    this.height = 280,
    this.onDetails,
  });

  final String asset;
  final List<CalloutInfo> callouts;
  final double height;
  final VoidCallback? onDetails;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 10,
            left: 24,
            right: 24,
            height: 120,
            child: CustomPaint(painter: HolographicBasePainter()),
          ),
          Positioned(
            bottom: 48,
            child:
                Image.asset(
                      asset,
                      height: height * 0.55,
                      width: height * 0.55,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.favorite,
                        size: 120,
                        color: AppColors.red.withValues(alpha: 0.8),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .scale(
                      begin: const Offset(0.92, 0.92),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                    ),
          ),
          ..._positionedCallouts(),
        ],
      ),
    );
  }

  List<Widget> _positionedCallouts() {
    return callouts.map((c) {
      Alignment alignment;
      EdgeInsets padding;
      switch (c.alignment) {
        case CalloutAlign.topLeft:
          alignment = Alignment.topLeft;
          padding = const EdgeInsets.only(left: 8, top: 24);
        case CalloutAlign.topRight:
          alignment = Alignment.topRight;
          padding = const EdgeInsets.only(right: 8, top: 20);
        case CalloutAlign.bottomLeft:
          alignment = Alignment.bottomLeft;
          padding = const EdgeInsets.only(left: 8, bottom: 70);
        case CalloutAlign.bottomRight:
          alignment = Alignment.bottomRight;
          padding = const EdgeInsets.only(right: 8, bottom: 70);
        case CalloutAlign.midRight:
          alignment = Alignment.centerRight;
          padding = const EdgeInsets.only(right: 4);
      }
      return Align(
        alignment: alignment,
        child: Padding(
          padding: padding,
          child: CalloutBubble(info: c, onDetails: onDetails),
        ),
      );
    }).toList();
  }
}

class AnimatedScoreRing extends StatelessWidget {
  const AnimatedScoreRing({
    super.key,
    required this.score,
    required this.accent,
    this.size = 220,
  });

  final double score;
  final Color accent;
  final double size;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: score / 100),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: ScoreRingPainter(progress: value, accent: accent),
              ),
              Text(
                '${(value * 100).round()}%',
                style: GoogleFonts.michroma(
                  fontSize: size * 0.16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.title,
    required this.bullets,
    this.glow = AppColors.cyan,
  });

  final String title;
  final List<String> bullets;
  final Color glow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [glow.withValues(alpha: 0.18), AppColors.card],
        ),
        border: Border.all(color: glow.withValues(alpha: 0.45)),
        boxShadow: [
          BoxShadow(color: glow.withValues(alpha: 0.18), blurRadius: 18),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.michroma(
              fontSize: 13,
              color: Colors.white,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    decoration: BoxDecoration(
                      color: glow,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MarkerChipGrid extends StatelessWidget {
  const MarkerChipGrid({
    super.key,
    required this.title,
    required this.items,
    required this.color,
  });

  final String title;
  final List<MarkerChip> items;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.michroma(fontSize: 12, color: Colors.white),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.55,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color.withValues(alpha: 0.8)),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.15),
                    blurRadius: 8,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.value,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 9),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class RiskMetricTile extends StatelessWidget {
  const RiskMetricTile({super.key, required this.metric, this.onTap});

  final RiskMetric metric;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = switch (metric.status) {
      MetricStatus.caution => AppColors.amber,
      MetricStatus.good => AppColors.neonGreen,
      MetricStatus.critical => AppColors.red,
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.12), blurRadius: 12),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color),
              ),
              child: Icon(Icons.verified_rounded, color: color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    metric.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    metric.range,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              metric.value,
              style: GoogleFonts.michroma(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlowSectionTitle extends StatelessWidget {
  const GlowSectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        text,
        style: GoogleFonts.michroma(
          color: Colors.white,
          fontSize: 14,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
