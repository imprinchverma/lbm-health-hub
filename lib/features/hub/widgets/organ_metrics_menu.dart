import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/dummy/dummy_health_data.dart';

/// Expandable Organ Metrics panel matching the design:
/// - Expanded: organ list + Blood Metrics + Hormone
/// - Collapsed: compact "Organ Metrics" header only
class OrganMetricsMenu extends StatelessWidget {
  const OrganMetricsMenu({
    super.key,
    required this.selectedId,
    required this.expanded,
    required this.onToggleExpanded,
    required this.onSelect,
    this.onBloodMetrics,
    this.onHormone,
  });

  final String selectedId;
  final bool expanded;
  final VoidCallback onToggleExpanded;
  final ValueChanged<String> onSelect;
  final VoidCallback? onBloodMetrics;
  final VoidCallback? onHormone;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: Container(
        width: 186,
        padding: EdgeInsets.fromLTRB(12, 12, 12, expanded ? 14 : 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1B1B1B),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.55),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onToggleExpanded,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Organ Metrics',
                        style: GoogleFonts.michroma(
                          color: Colors.white,
                          fontSize: 11,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2A2A2A),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        expanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (expanded) ...[
              const SizedBox(height: 10),
              ...DummyHealthData.organs.map((organ) {
                final selected = organ.id == selectedId;
                return GestureDetector(
                  onTap: () => onSelect(organ.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF000000)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: selected
                          ? Border.all(
                              color: Color(organ.accent).withValues(alpha: 0.55),
                            )
                          : null,
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: Color(organ.accent).withValues(alpha: 0.25),
                                blurRadius: 10,
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: Image.asset(
                            organ.iconAsset,
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.favorite,
                              size: 22,
                              color: Color(organ.accent),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            organ.name,
                            style: TextStyle(
                              color: Colors.white
                                  .withValues(alpha: selected ? 1 : 0.85),
                              fontWeight:
                                  selected ? FontWeight.w700 : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              _pill('Blood Metrics', onBloodMetrics),
              const SizedBox(height: 8),
              _pill('Hormone', onHormone),
            ],
          ],
        ),
      ),
    );
  }

  Widget _pill(String label, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: GoogleFonts.michroma(
            color: Colors.white,
            fontSize: 11,
            letterSpacing: 0.6,
          ),
        ),
      ),
    );
  }
}
