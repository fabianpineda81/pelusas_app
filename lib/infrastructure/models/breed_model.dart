import 'package:pelusas/domain/entities/breed_entity.dart';
import 'package:pelusas/infrastructure/models/wight_model.dart';

class BreedModel {
  final String id;
  final String name;
  final String origin;
  final String lifeSpanYears;
  final String description;
  final WeightModel weight;
  final int adaptability;
  final int affectionLevel;
  final int childFriendly;
  final int dogFriendly;
  final int energyLevel;
  final int grooming;
  final int healthIssues;
  final int intelligence;
  final int sheddingLevel;
  final int socialNeeds;
  final int strangerFriendly;
  final int vocalisation;
  final int experimental;
  final int hairless;
  final int natural;
  final int rare;
  final int rex;
  final int suppressedTail;
  final int shortLegs;
  final int hypoallergenic;
  final String? cfaUrl;
  final String? vetstreetUrl;
  final String? vcahospitalsUrl;
  final String? wikipediaUrl;

  List<String> imagesUrls;

  BreedModel({
    required this.id,
    required this.name,
    required this.origin,
    required this.lifeSpanYears,
    required this.description,
    required this.weight,
    required this.adaptability,
    required this.affectionLevel,
    required this.childFriendly,
    required this.dogFriendly,
    required this.energyLevel,
    required this.grooming,
    required this.healthIssues,
    required this.intelligence,
    required this.sheddingLevel,
    required this.socialNeeds,
    required this.strangerFriendly,
    required this.vocalisation,
    required this.experimental,
    required this.hairless,
    required this.natural,
    required this.rare,
    required this.rex,
    required this.suppressedTail,
    required this.shortLegs,
    required this.hypoallergenic,
    this.cfaUrl,
    this.vetstreetUrl,
    this.vcahospitalsUrl,
    this.wikipediaUrl,
    this.imagesUrls = const [],
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      origin: json['origin'] ?? '',
      lifeSpanYears: json['life_span'] ?? '',
      description: json['description'] ?? '',
      weight: WeightModel.fromJson(json['weight']),
      adaptability: json['adaptability'] ?? 0,
      affectionLevel: json['affection_level'] ?? 0,
      childFriendly: json['child_friendly'] ?? 0,
      dogFriendly: json['dog_friendly'] ?? 0,
      energyLevel: json['energy_level'] ?? 0,
      grooming: json['grooming'] ?? 0,
      healthIssues: json['health_issues'] ?? 0,
      intelligence: json['intelligence'] ?? 0,
      sheddingLevel: json['shedding_level'] ?? 0,
      socialNeeds: json['social_needs'] ?? 0,
      strangerFriendly: json['stranger_friendly'] ?? 0,
      vocalisation: json['vocalisation'] ?? 0,
      experimental: json['experimental'] ?? 0,
      hairless: json['hairless'] ?? 0,
      natural: json['natural'] ?? 0,
      rare: json['rare'] ?? 0,
      rex: json['rex'] ?? 0,
      suppressedTail: json['suppressed_tail'] ?? 0,
      shortLegs: json['short_legs'] ?? 0,
      hypoallergenic: json['hypoallergenic'] ?? 0,
      cfaUrl: json['cfa_url'],
      vetstreetUrl: json['vetstreet_url'],
      vcahospitalsUrl: json['vcahospitals_url'],
      wikipediaUrl: json['wikipedia_url'],
    );
  }

  BreedEntity toEntity(List<String> imagesUrls) => BreedEntity(
    id: id,
    name: name,
    weight: weight.toEntity(),
    origin: origin,
    lifeSpanYears: lifeSpanYears,
    description: description,
    imagesUrls: imagesUrls,
    adaptability: adaptability,
    affectionLevel: affectionLevel,
    childFriendly: childFriendly,
    dogFriendly: dogFriendly,
    energyLevel: energyLevel,
    grooming: grooming,
    healthIssues: healthIssues,
    intelligence: intelligence,
    sheddingLevel: sheddingLevel,
    socialNeeds: socialNeeds,
    strangerFriendly: strangerFriendly,
    vocalisation: vocalisation,
    experimental: experimental,
    hairless: hairless,
    natural: natural,
    rare: rare,
    rex: rex,
    suppressedTail: suppressedTail,
    shortLegs: shortLegs,
    hypoallergenic: hypoallergenic,
    cfaUrl: cfaUrl,
    vetstreetUrl: vetstreetUrl,
    vcahospitalsUrl: vcahospitalsUrl,
    wikipediaUrl: wikipediaUrl,
  );
}
