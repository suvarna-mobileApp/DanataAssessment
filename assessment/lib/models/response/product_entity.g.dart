// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) =>
    ProductEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['featured_image'] as String,
      price: (json['price'] as num).toDouble(),
          rating: json['rating'] as String,
    );

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'featured_image': instance.image,
      'price': instance.price,
          'rating': instance.rating,
    };
