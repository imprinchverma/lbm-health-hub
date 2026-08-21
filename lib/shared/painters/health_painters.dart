import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ScoreRingPainter extends CustomPainter {
  ScoreRingPainter({
    required this.progress,
    required this.accent,
    this.strokeWidth = 14,
    this.showTicks = true,
    this.maxLabel = 80,
  });

  final double progress;
  final Color accent;
  final double strokeWidth;
  final bool showTicks;
  final int maxLabel;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth;

    final track = Paint()
      ..color = const Color(0xFF2A2A2A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final glow = Paint()
      ..color = accent.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final progressPaint = Paint()
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: math.pi * 1.5,
        colors: [
          accent.withValues(alpha: 0.2),
          accent,
          accent.withValues(alpha: 0.85),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const start = -math.pi * 0.75;
    const sweep = math.pi * 1.5;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep,
      false,
      track,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep * progress.clamp(0.0, 1.0),
      false,
      glow,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep * progress.clamp(0.0, 1.0),
      false,
      progressPaint,
    );

    // Needle
    final angle = start + sweep * progress.clamp(0.0, 1.0);
    final needleEnd = Offset(
      center.dx + math.cos(angle) * (radius - 6),
      center.dy + math.sin(angle) * (radius - 6),
    );
    final needle = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, needleEnd, needle);
    canvas.drawCircle(center, 4, Paint()..color = Colors.white);

    // Top marker
    final top = Offset(center.dx, center.dy - radius);
    final marker = Path()
      ..moveTo(top.dx, top.dy + 4)
      ..lineTo(top.dx - 6, top.dy - 6)
      ..lineTo(top.dx + 6, top.dy - 6)
      ..close();
    canvas.drawPath(marker, Paint()..color = AppColors.neonGreen);

    if (showTicks) {
      final labels = [0, 20, 40, 60, maxLabel];
      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      for (final label in labels) {
        final t = label / maxLabel;
        final a = start + sweep * t;
        final p = Offset(
          center.dx + math.cos(a) * (radius + 18),
          center.dy + math.sin(a) * (radius + 18),
        );
        textPainter.text = TextSpan(
          text: '$label',
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          p - Offset(textPainter.width / 2, textPainter.height / 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant ScoreRingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.accent != accent;
}

class SemiGaugePainter extends CustomPainter {
  SemiGaugePainter({
    required this.needlePosition,
    required this.segments,
  });

  final double needlePosition;
  final List<Color> segments;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.92);
    final radius = size.width * 0.42;
    const start = math.pi;
    const sweep = math.pi;
    final segSweep = sweep / segments.length;

    for (var i = 0; i < segments.length; i++) {
      final paint = Paint()
        ..color = segments[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start + i * segSweep + 0.01,
        segSweep - 0.02,
        false,
        paint,
      );
    }

    final labels = [
      'VERY LOW',
      'LOW',
      'MODERATE',
      'OPTIAL',
      'HIGH',
      'VERY HIGH',
    ];
    final tp = TextPainter(textDirection: TextDirection.ltr);
    for (var i = 0; i < labels.length; i++) {
      final a = start + segSweep * (i + 0.5);
      final p = Offset(
        center.dx + math.cos(a) * (radius + 22),
        center.dy + math.sin(a) * (radius + 22),
      );
      tp.text = TextSpan(
        text: labels[i],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      );
      tp.layout();
      tp.paint(canvas, p - Offset(tp.width / 2, tp.height / 2));
    }

    final angle = start + sweep * needlePosition.clamp(0.0, 1.0);
    final end = Offset(
      center.dx + math.cos(angle) * (radius - 10),
      center.dy + math.sin(angle) * (radius - 10),
    );
    canvas.drawLine(
      center,
      end,
      Paint()
        ..color = const Color(0xFFCFCFCF)
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(center, 7, Paint()..color = Colors.white);
    canvas.drawCircle(center, 3.5, Paint()..color = const Color(0xFF222222));
  }

  @override
  bool shouldRepaint(covariant SemiGaugePainter oldDelegate) =>
      oldDelegate.needlePosition != needlePosition;
}

class HolographicBasePainter extends CustomPainter {
  HolographicBasePainter({this.pulse = 0});

  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.55);
    final maxR = size.width * 0.42;

    for (var i = 0; i < 5; i++) {
      final r = maxR * (0.35 + i * 0.16) + pulse * 2;
      final paint = Paint()
        ..color = AppColors.cyan.withValues(alpha: 0.18 + i * 0.05)
        ..style = PaintingStyle.stroke
        ..strokeWidth = i == 0 ? 2.2 : 1.2;
      canvas.drawCircle(center, r, paint);
    }

    final dashPaint = Paint()
      ..color = AppColors.electricBlue.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    _drawDashedCircle(canvas, center, maxR * 0.72, dashPaint);

    final glow = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.cyan.withValues(alpha: 0.35),
          AppColors.cyan.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: maxR));
    canvas.drawCircle(center, maxR * 0.55, glow);
  }

  void _drawDashedCircle(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint,
  ) {
    const dash = 8.0;
    const gap = 6.0;
    final circumference = 2 * math.pi * radius;
    final count = (circumference / (dash + gap)).floor();
    for (var i = 0; i < count; i++) {
      final start = (i * (dash + gap)) / radius;
      final end = start + dash / radius;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        end - start,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant HolographicBasePainter oldDelegate) =>
      oldDelegate.pulse != pulse;
}

class GlowLineChartPainter extends CustomPainter {
  GlowLineChartPainter({
    required this.points,
    required this.accent,
    this.baseline = 75,
  });

  final List<Offset> points;
  final Color accent;
  final double baseline;

  @override
  void paint(Canvas canvas, Size size) {
    final chart = Rect.fromLTWH(36, 16, size.width - 48, size.height - 40);

    // Grid
    final grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    for (var i = 0; i <= 5; i++) {
      final y = chart.top + chart.height * i / 5;
      canvas.drawLine(Offset(chart.left, y), Offset(chart.right, y), grid);
    }

    // Baseline
    final by = chart.bottom - ((baseline - 50) / 50) * chart.height;
    canvas.drawLine(
      Offset(chart.left, by),
      Offset(chart.right, by),
      Paint()
        ..color = Colors.white54
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke,
    );

    if (points.isEmpty) return;

    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final p = Offset(
        chart.left + points[i].dx * chart.width,
        chart.bottom - points[i].dy * chart.height,
      );
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = accent.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeJoin = StrokeJoin.round,
    );

    for (final point in points) {
      final p = Offset(
        chart.left + point.dx * chart.width,
        chart.bottom - point.dy * chart.height,
      );
      canvas.drawCircle(p, 4, Paint()..color = accent);
      canvas.drawCircle(p, 2, Paint()..color = Colors.black);
    }

    // Axis labels
    final tp = TextPainter(textDirection: TextDirection.ltr);
    for (final y in [50, 60, 70, 80, 90, 100]) {
      final yy = chart.bottom - ((y - 50) / 50) * chart.height;
      tp.text = TextSpan(
        text: '$y',
        style: const TextStyle(color: Colors.white38, fontSize: 9),
      );
      tp.layout();
      tp.paint(canvas, Offset(8, yy - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant GlowLineChartPainter oldDelegate) => true;
}

/// Clean holographic human figure — no UI chrome baked into assets.
class BodySilhouettePainter extends CustomPainter {
  BodySilhouettePainter({this.highlightLungs = true});

  final bool highlightLungs;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    final fill = Paint()
      ..color = AppColors.cyan.withValues(alpha: 0.38)
      ..style = PaintingStyle.fill;
    final glow = Paint()
      ..color = AppColors.cyan.withValues(alpha: 0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    final stroke = Paint()
      ..color = AppColors.cyan.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    void drawFigure(Paint paint) {
      // Head
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx, h * 0.08),
          width: w * 0.22,
          height: h * 0.12,
        ),
        paint,
      );
      // Neck
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(cx, h * 0.155),
            width: w * 0.08,
            height: h * 0.05,
          ),
          const Radius.circular(8),
        ),
        paint,
      );
      // Torso
      final torso = Path()
        ..moveTo(cx - w * 0.22, h * 0.20)
        ..lineTo(cx + w * 0.22, h * 0.20)
        ..lineTo(cx + w * 0.17, h * 0.52)
        ..lineTo(cx - w * 0.17, h * 0.52)
        ..close();
      canvas.drawPath(torso, paint);
      // Arms
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.05, h * 0.22, w * 0.14, h * 0.32),
          const Radius.circular(18),
        ),
        paint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.81, h * 0.22, w * 0.14, h * 0.32),
          const Radius.circular(18),
        ),
        paint,
      );
      // Legs
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cx - w * 0.15, h * 0.50, w * 0.12, h * 0.42),
          const Radius.circular(16),
        ),
        paint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cx + w * 0.03, h * 0.50, w * 0.12, h * 0.42),
          const Radius.circular(16),
        ),
        paint,
      );
    }

    drawFigure(glow);
    drawFigure(fill);
    drawFigure(stroke);

    if (highlightLungs) {
      final lung = Paint()
        ..color = AppColors.orange.withValues(alpha: 0.75)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx - w * 0.07, h * 0.32),
          width: w * 0.12,
          height: h * 0.12,
        ),
        lung,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx + w * 0.07, h * 0.32),
          width: w * 0.12,
          height: h * 0.12,
        ),
        lung,
      );
    }
  }

  @override
  bool shouldRepaint(covariant BodySilhouettePainter oldDelegate) =>
      oldDelegate.highlightLungs != highlightLungs;
}
