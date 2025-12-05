import 'package:bu/models/listing.dart';

final List<Listing> seedListings = [
  Listing(
    id: 'l1',
    title: 'Light-filled 2BR in Grünerløkka',
    address: 'Sannergata 24',
    city: 'Oslo',
    monthlyRent: 22000,
    bedrooms: 2,
    bathrooms: 1.5,
    squareMeters: 78,
    description:
        'Corner unit with balcony, bike storage, and tram stop right outside. Pets allowed on request.',
    imageUrl:
        'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=800&q=80',
    landlordId: 'pro_landlord',
    landlordName: 'Nordic Living',
    postedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Listing(
    id: 'l2',
    title: 'Compact studio near Nydalen T-bane',
    address: 'Gullhaug Torg 5',
    city: 'Oslo',
    monthlyRent: 13500,
    bedrooms: 1,
    bathrooms: 1,
    squareMeters: 32,
    description:
        'Fully furnished studio with floor-to-ceiling windows and shared rooftop.',
    imageUrl:
        'https://images.unsplash.com/photo-1527030280862-64139fba04ca?auto=format&fit=crop&w=800&q=80',
    landlordId: 'landlord_anna',
    landlordName: 'Anna Ruud',
    postedAt: DateTime.now().subtract(const Duration(days: 7)),
  ),
  Listing(
    id: 'l3',
    title: 'Modern townhouse with fjord view',
    address: 'Fjordsvn 11',
    city: 'Bergen',
    monthlyRent: 28000,
    bedrooms: 3,
    bathrooms: 2,
    squareMeters: 120,
    description:
        'Private garage, smart-home ready, and large terrace perfect for gatherings.',
    imageUrl:
        'https://images.unsplash.com/photo-1429032021766-c6a53949594f?auto=format&fit=crop&w=800&q=80',
    landlordId: 'landlord_lars',
    landlordName: 'Lars Halvorsen',
    postedAt: DateTime.now().subtract(const Duration(days: 12)),
  ),
  Listing(
    id: 'l4',
    title: 'Cozy loft close to NTNU',
    address: 'Elgeseter gate 1',
    city: 'Trondheim',
    monthlyRent: 16000,
    bedrooms: 1,
    bathrooms: 1,
    squareMeters: 50,
    description:
        'Renovated loft with exposed beams, study nook, and fast fiber internet included.',
    imageUrl:
        'https://images.unsplash.com/photo-1432303499155-d78b28db3791?auto=format&fit=crop&w=800&q=80',
    landlordId: 'landlord_marte',
    landlordName: 'Marte Håland',
    postedAt: DateTime.now().subtract(const Duration(days: 20)),
  ),
];
