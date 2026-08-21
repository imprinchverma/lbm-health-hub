class OrganInfo {
  const OrganInfo({
    required this.id,
    required this.name,
    required this.iconAsset,
    required this.stageAsset,
    required this.score,
    required this.accent,
    required this.callouts,
    required this.recommendations,
    required this.strengths,
    required this.weaknesses,
    required this.riskMetrics,
  });

  final String id;
  final String name;
  final String iconAsset;
  final String stageAsset;
  final double score;
  final int accent;
  final List<CalloutInfo> callouts;
  final List<String> recommendations;
  final List<MarkerChip> strengths;
  final List<MarkerChip> weaknesses;
  final List<RiskMetric> riskMetrics;
}

class CalloutInfo {
  const CalloutInfo({
    required this.text,
    required this.isPositive,
    this.detailLink = false,
    this.alignment = CalloutAlign.topLeft,
  });

  final String text;
  final bool isPositive;
  final bool detailLink;
  final CalloutAlign alignment;
}

enum CalloutAlign { topLeft, topRight, bottomLeft, bottomRight, midRight }

class MarkerChip {
  const MarkerChip({required this.value, required this.label});
  final String value;
  final String label;
}

class RiskMetric {
  const RiskMetric({
    required this.title,
    required this.range,
    required this.value,
    required this.status,
  });

  final String title;
  final String range;
  final String value;
  final MetricStatus status;
}

enum MetricStatus { caution, good, critical }

class RangeBand {
  const RangeBand({
    required this.label,
    required this.rangeText,
    required this.color,
  });

  final String label;
  final String rangeText;
  final int color;
}

class ImpactParameter {
  const ImpactParameter({required this.title, required this.description});
  final String title;
  final String description;
}

class MetricDetail {
  const MetricDetail({
    required this.name,
    required this.value,
    required this.unit,
    required this.statusLabel,
    required this.needlePosition,
    required this.ranges,
    required this.impacts,
    required this.about,
  });

  final String name;
  final double value;
  final String unit;
  final String statusLabel;
  final double needlePosition;
  final List<RangeBand> ranges;
  final List<ImpactParameter> impacts;
  final String about;
}

class ChartPoint {
  const ChartPoint(this.x, this.y);
  final double x;
  final double y;
}

class OverviewData {
  const OverviewData({
    required this.bodyIssues,
    required this.dopaminePoints,
    required this.serotoninPoints,
    required this.immuneScore,
    required this.hyperprolactinemiaScore,
    required this.aboutText,
    required this.strengths,
    required this.weaknesses,
    required this.recommendations,
  });

  final List<CalloutInfo> bodyIssues;
  final List<ChartPoint> dopaminePoints;
  final List<ChartPoint> serotoninPoints;
  final double immuneScore;
  final double hyperprolactinemiaScore;
  final String aboutText;
  final List<MarkerChip> strengths;
  final List<MarkerChip> weaknesses;
  final List<String> recommendations;
}
