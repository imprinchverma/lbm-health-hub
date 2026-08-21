import 'package:flutter_test/flutter_test.dart';
import 'package:lbm_health_hub/app/app.dart';

void main() {
  testWidgets('Health Hub loads phenotype screen', (tester) async {
    await tester.pumpWidget(HealthHubApp());
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Phenotype'), findsWidgets);
  });
}
