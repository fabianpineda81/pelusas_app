import 'package:pelusas/domain/entities/weight.dart';

class WeightModel {
  final String imperial;
  final String metric;

  WeightModel({required this.imperial, required this.metric});

  factory WeightModel.fromJson(Map<String, dynamic> json) => WeightModel(
    imperial: json['imperial'] ?? '',
    metric: json['metric'] ?? '',
  );

  WeightEntity toEntity() {
    return WeightEntity(
      imperial: imperial,
      metric: metric,
    );
  }
}
