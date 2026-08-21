import 'package:flutter/material.dart';
import '../models/health_models.dart';
import '../../core/theme/app_theme.dart';

class DummyHealthData {
  static const organs = <OrganInfo>[
    OrganInfo(
      id: 'heart',
      name: 'Heart',
      iconAsset: 'assets/images/icons/heart.png',
      stageAsset: 'assets/images/heart_display.png',
      score: 76,
      accent: 0xFFFF3B3B,
      callouts: [
        CalloutInfo(
          text: 'Better Cardiac Condition than Past.',
          isPositive: true,
          alignment: CalloutAlign.topLeft,
        ),
        CalloutInfo(
          text: 'Recovery phase with mild discomfort noted.',
          isPositive: true,
          detailLink: true,
          alignment: CalloutAlign.topRight,
        ),
        CalloutInfo(
          text: 'Notice a minor blockage in the lower 4th chamber.',
          isPositive: false,
          alignment: CalloutAlign.bottomLeft,
        ),
      ],
      recommendations: [
        'Maintaining a healthy heart is crucial for overall well-being.',
        'Eating a heart-healthy diet rich in fruits, vegetables, and whole grains.',
        'Reducing salt intake to manage blood pressure.',
        'Engaging in regular physical activity.',
        'Managing stress through mindfulness and adequate sleep.',
      ],
      strengths: _chips,
      weaknesses: _chips,
      riskMetrics: _riskMetrics,
    ),
    OrganInfo(
      id: 'lungs',
      name: 'Lungs',
      iconAsset: 'assets/images/icons/lungs.png',
      stageAsset: 'assets/images/lungs_display.png',
      score: 66,
      accent: 0xFFFFC107,
      callouts: [
        CalloutInfo(
          text: 'Better Respiration Condition than Past.',
          isPositive: true,
          alignment: CalloutAlign.topLeft,
        ),
        CalloutInfo(
          text: 'Recovery phase with better oxygen Supply.',
          isPositive: true,
          detailLink: true,
          alignment: CalloutAlign.midRight,
        ),
        CalloutInfo(
          text: 'Notice a minor blockage in the lower.',
          isPositive: false,
          alignment: CalloutAlign.bottomLeft,
        ),
      ],
      recommendations: [
        'Maintaining healthy lungs supports oxygen delivery across the body.',
        'Eating a lung-friendly diet with antioxidants and omega-3s.',
        'Avoiding smoke and polluted environments when possible.',
        'Practicing deep-breathing and light cardio routines.',
        'Staying hydrated to keep airways clear and comfortable.',
      ],
      strengths: _chips,
      weaknesses: _chips,
      riskMetrics: _riskMetrics,
    ),
    OrganInfo(
      id: 'kidneys',
      name: 'kidneys',
      iconAsset: 'assets/images/icons/kidneys.png',
      stageAsset: 'assets/images/kidney-organ-1.png',
      score: 72,
      accent: 0xFFFF6B6B,
      callouts: [
        CalloutInfo(
          text: 'Stable filtration markers this week.',
          isPositive: true,
          alignment: CalloutAlign.topLeft,
        ),
        CalloutInfo(
          text: 'Mild dehydration pattern detected.',
          isPositive: false,
          detailLink: true,
          alignment: CalloutAlign.topRight,
        ),
      ],
      recommendations: [
        'Drink consistent water throughout the day.',
        'Limit excess sodium and processed foods.',
        'Monitor blood pressure regularly.',
      ],
      strengths: _chips,
      weaknesses: _chips,
      riskMetrics: _riskMetrics,
    ),
    OrganInfo(
      id: 'brain',
      name: 'Brain',
      iconAsset: 'assets/images/icons/brain.png',
      stageAsset: 'assets/images/brain-organ-1.png',
      score: 81,
      accent: 0xFFFF5C8A,
      callouts: [
        CalloutInfo(
          text: 'Cognitive recovery trending upward.',
          isPositive: true,
          alignment: CalloutAlign.topLeft,
        ),
        CalloutInfo(
          text: 'Sleep debt may impact focus.',
          isPositive: false,
          detailLink: true,
          alignment: CalloutAlign.topRight,
        ),
      ],
      recommendations: [
        'Prioritize 7–8 hours of quality sleep.',
        'Balance screen time with outdoor light exposure.',
        'Practice short mindfulness sessions daily.',
      ],
      strengths: _chips,
      weaknesses: _chips,
      riskMetrics: _riskMetrics,
    ),
    OrganInfo(
      id: 'bones',
      name: 'Bones',
      iconAsset: 'assets/images/icons/bones.png',
      stageAsset: 'assets/images/spine--1.png',
      score: 68,
      accent: 0xFFB0BEC5,
      callouts: [
        CalloutInfo(
          text: 'Spinal mobility improving.',
          isPositive: true,
          alignment: CalloutAlign.topLeft,
        ),
        CalloutInfo(
          text: 'Knee Problems',
          isPositive: false,
          alignment: CalloutAlign.bottomLeft,
        ),
      ],
      recommendations: [
        'Include weight-bearing activity 3x weekly.',
        'Ensure adequate calcium and vitamin D intake.',
        'Maintain posture during long sitting sessions.',
      ],
      strengths: _chips,
      weaknesses: _chips,
      riskMetrics: _riskMetrics,
    ),
    OrganInfo(
      id: 'stomach',
      name: 'Stomach',
      iconAsset: 'assets/images/icons/stomach.png',
      stageAsset: 'assets/images/stomach-organ-1.png',
      score: 74,
      accent: 0xFFFF8A3D,
      callouts: [
        CalloutInfo(
          text: 'Digestion rhythm is stable.',
          isPositive: true,
          alignment: CalloutAlign.topLeft,
        ),
        CalloutInfo(
          text: 'Late meals may cause mild acidity.',
          isPositive: false,
          detailLink: true,
          alignment: CalloutAlign.topRight,
        ),
      ],
      recommendations: [
        'Prefer earlier dinner timing.',
        'Reduce ultra-processed snacks.',
        'Include fiber-rich meals daily.',
      ],
      strengths: _chips,
      weaknesses: _chips,
      riskMetrics: _riskMetrics,
    ),
    OrganInfo(
      id: 'intestine',
      name: 'Intestine',
      iconAsset: 'assets/images/icons/intestine.png',
      stageAsset: 'assets/images/intestine-organ-1.png',
      score: 70,
      accent: 0xFFE57373,
      callouts: [
        CalloutInfo(
          text: 'Gut microbiome diversity is fair.',
          isPositive: true,
          alignment: CalloutAlign.topLeft,
        ),
        CalloutInfo(
          text: 'Inflammation markers slightly elevated.',
          isPositive: false,
          detailLink: true,
          alignment: CalloutAlign.topRight,
        ),
      ],
      recommendations: [
        'Add fermented foods a few times a week.',
        'Increase plant diversity across meals.',
        'Limit unnecessary antibiotic exposure.',
      ],
      strengths: _chips,
      weaknesses: _chips,
      riskMetrics: _riskMetrics,
    ),
  ];

  static const _chips = <MarkerChip>[
    MarkerChip(value: '0.05', label: 'HCV Antibody'),
    MarkerChip(value: '0.05', label: 'HCV Antibody'),
    MarkerChip(value: '0.05', label: 'HCV Antibody'),
    MarkerChip(value: '0.05', label: 'HCV Antibody'),
    MarkerChip(value: '0.05', label: 'HCV Antibody'),
    MarkerChip(value: '0.05', label: 'HCV Antibody'),
  ];

  static const _riskMetrics = <RiskMetric>[
    RiskMetric(
      title: 'Mentzer',
      range: '12.3 - 15.5 secs',
      value: '16.7',
      status: MetricStatus.caution,
    ),
    RiskMetric(
      title: 'HCV AntiBody',
      range: '< 0.389',
      value: '56.6',
      status: MetricStatus.good,
    ),
    RiskMetric(
      title: 'Apolipoprotine A1',
      range: '12.3 - 15.5 secs',
      value: '14.9',
      status: MetricStatus.critical,
    ),
    RiskMetric(
      title: 'Prothrombine Time',
      range: '12.3 - 15.5 secs',
      value: '6.2',
      status: MetricStatus.caution,
    ),
    RiskMetric(
      title: 'HCV AntiBody',
      range: '< 0.389',
      value: '26.0',
      status: MetricStatus.good,
    ),
    RiskMetric(
      title: 'Immunoglobulim E2',
      range: '< 152.9 KU/L',
      value: '69',
      status: MetricStatus.critical,
    ),
  ];

  static OrganInfo byId(String id) =>
      organs.firstWhere((o) => o.id == id, orElse: () => organs.first);

  static const overview = OverviewData(
    bodyIssues: [
      CalloutInfo(
        text: 'Chronic Lungs Problem',
        isPositive: false,
        alignment: CalloutAlign.topLeft,
      ),
      CalloutInfo(
        text: 'Knee Problems',
        isPositive: false,
        alignment: CalloutAlign.bottomLeft,
      ),
      CalloutInfo(
        text: 'Recovery slight pain in the left side neck.',
        isPositive: true,
        detailLink: true,
        alignment: CalloutAlign.midRight,
      ),
    ],
    dopaminePoints: [
      ChartPoint(0, 62),
      ChartPoint(20, 78),
      ChartPoint(40, 70),
      ChartPoint(60, 88),
      ChartPoint(80, 74),
      ChartPoint(100, 92),
      ChartPoint(120, 80),
    ],
    serotoninPoints: [
      ChartPoint(0, 58),
      ChartPoint(20, 66),
      ChartPoint(40, 72),
      ChartPoint(60, 69),
      ChartPoint(80, 81),
      ChartPoint(100, 76),
      ChartPoint(120, 84),
    ],
    immuneScore: 30,
    hyperprolactinemiaScore: 95,
    aboutText:
        'Hyperprolactinemia is a condition marked by elevated prolactin levels in the blood. It can influence hormonal balance, immune response and overall recovery capacity when left unmonitored.',
    strengths: _chips,
    weaknesses: _chips,
    recommendations: [
      'Follow a balanced anti-inflammatory diet.',
      'Prioritize hydration and restorative sleep.',
      'Include regular moderate exercise.',
    ],
  );

  static const mentzer = MetricDetail(
    name: 'Mentzer',
    value: 36.7,
    unit: 'mcg/dl',
    statusLabel: 'optimal',
    needlePosition: 0.42,
    ranges: [
      RangeBand(
        label: 'VERY LOW',
        rangeText: '< 4.46 mcg/dL',
        color: 0xFFE53935,
      ),
      RangeBand(
        label: 'LOW',
        rangeText: '< 8.46 mcg/dL',
        color: 0xFFFF7043,
      ),
      RangeBand(
        label: 'MODERATE',
        rangeText: '4.46 mcg/dL',
        color: 0xFFFFCA28,
      ),
      RangeBand(
        label: 'OPTIMAL',
        rangeText: '< 6.46 mcg/dL',
        color: 0xFFC6FF00,
      ),
      RangeBand(
        label: 'HIGH',
        rangeText: '8.46 - 9.2 mcg/dL',
        color: 0xFF66BB6A,
      ),
      RangeBand(
        label: 'VERY HIGH',
        rangeText: '10.46 - 22.0 mg/dL',
        color: 0xFF2E7D32,
      ),
    ],
    impacts: [
      ImpactParameter(
        title: 'Diet (saturated fat, sugar intake)',
        description:
            'Limit saturated fats and sugars to keep arteries clear and LDL controlled.',
      ),
      ImpactParameter(
        title: 'Physical activity levels',
        description:
            'Consistent movement supports lipid metabolism and cardiovascular resilience.',
      ),
      ImpactParameter(
        title: 'Body weight and waist circumference',
        description:
            'Healthy body composition helps reduce LDL-related cardiovascular risk.',
      ),
    ],
    about:
        'LDL cholesterol plays a key role in transporting lipids through the bloodstream. Elevated levels can contribute to plaque buildup and increased heart-risk over time. Tracking Mentzer and related markers helps personalize nutrition and fitness guidance.',
  );

  static Color statusColor(MetricStatus status) {
    switch (status) {
      case MetricStatus.caution:
        return AppColors.amber;
      case MetricStatus.good:
        return AppColors.neonGreen;
      case MetricStatus.critical:
        return AppColors.red;
    }
  }
}
