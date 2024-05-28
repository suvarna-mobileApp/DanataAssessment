import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

@JsonSerializable()
class ProductEntity {
  final int id;
  final String title, description;
  @JsonKey(name: 'featured_image')
  final String image;
  final double price;
  final String rating;
  int quantity;

  ProductEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
        required this.rating,
      this.quantity = 0});

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
}
