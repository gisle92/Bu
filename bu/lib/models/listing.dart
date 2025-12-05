import 'package:equatable/equatable.dart';

class Listing extends Equatable {
  const Listing({
    required this.id,
    required this.title,
    required this.address,
    required this.city,
    required this.monthlyRent,
    required this.bedrooms,
    required this.bathrooms,
    required this.squareMeters,
    required this.description,
    required this.imageUrl,
    required this.landlordId,
    required this.landlordName,
    required this.postedAt,
  });

  final String id;
  final String title;
  final String address;
  final String city;
  final int monthlyRent;
  final int bedrooms;
  final double bathrooms;
  final double squareMeters;
  final String description;
  final String imageUrl;
  final String landlordId;
  final String landlordName;
  final DateTime postedAt;

  Listing copyWith({
    String? id,
    String? title,
    String? address,
    String? city,
    int? monthlyRent,
    int? bedrooms,
    double? bathrooms,
    double? squareMeters,
    String? description,
    String? imageUrl,
    String? landlordId,
    String? landlordName,
    DateTime? postedAt,
  }) {
    return Listing(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      city: city ?? this.city,
      monthlyRent: monthlyRent ?? this.monthlyRent,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      squareMeters: squareMeters ?? this.squareMeters,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      landlordId: landlordId ?? this.landlordId,
      landlordName: landlordName ?? this.landlordName,
      postedAt: postedAt ?? this.postedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    address,
    city,
    monthlyRent,
    bedrooms,
    bathrooms,
    squareMeters,
    description,
    imageUrl,
    landlordId,
    landlordName,
    postedAt,
  ];
}
