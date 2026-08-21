# Health Data Hub (Flutter Assignment)

Pixel-close Flutter UI replication of the Dots-In **Health Data Hub** designs.

## What's included

- Health overview (Phenotype / Genotype toggle)
- Human body + organ selection menu
- Organ detail screens (Heart, Lungs, Kidneys, Brain, Bones, Stomach, Intestine)
- CustomPainter score rings, semi gauges, holographic bases, glow charts
- Mentzer / LDL metric detail screen
- Strengths / weaknesses chips + risk assessment cards
- Dummy local JSON + in-memory sample data (no backend)
- Smooth micro-interactions via `flutter_animate`

## Run

```bash
flutter pub get
flutter run
```

## Key routes

- `/` — Health Hub overview
- `/organ/:id` — Organ detail
- `/metric/mentzer` — Metric detail gauge
- `/community` — Community landing

## Structure

```
lib/
  app/
  core/theme|router
  data/models|dummy
  features/hub|organ|metric_detail|community
  shared/widgets|painters
assets/images|data
assignment_refs/   # design PDFs/previews (not shipped in release)
```
