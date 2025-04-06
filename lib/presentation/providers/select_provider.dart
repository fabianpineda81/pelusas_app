import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pelusas/domain/entities/breed_entity.dart';

final selectedBreedProvider = StateProvider<BreedEntity?>((ref) => null);