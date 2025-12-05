import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:bu/data/mock_listings.dart';
import 'package:bu/models/listing.dart';
import 'package:bu/models/user_profile.dart';

class BuAppState extends ChangeNotifier {
  BuAppState() {
    _listings.addAll(seedListings);
  }

  final List<Listing> _listings = [];
  String _searchTerm = '';
  int? _maxBudget;
  UserProfile? _profile;

  UserProfile? get profile => _profile;
  bool get isOnboarded => _profile != null;
  bool get canList => _profile?.role == UserRole.landlord;

  List<Listing> get listings {
    Iterable<Listing> filtered = _listings;
    if (_searchTerm.isNotEmpty) {
      final query = _searchTerm.toLowerCase();
      filtered = filtered.where(
        (listing) =>
            listing.title.toLowerCase().contains(query) ||
            listing.city.toLowerCase().contains(query) ||
            listing.address.toLowerCase().contains(query),
      );
    }
    if (_maxBudget != null) {
      filtered = filtered.where(
        (listing) => listing.monthlyRent <= _maxBudget!,
      );
    }
    return List.unmodifiable(filtered);
  }

  List<Listing> get myListings {
    final current = _profile;
    if (current == null) return const [];
    return List.unmodifiable(
      _listings.where((listing) => listing.landlordId == current.id),
    );
  }

  Set<String> get availableCities => {
    for (final listing in _listings) listing.city,
  };

  void createProfile({
    required String name,
    required String email,
    required UserRole role,
  }) {
    _profile = UserProfile(
      id: 'u_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}',
      fullName: name.trim(),
      email: email.trim(),
      role: role,
      createdAt: DateTime.now(),
    );
    notifyListeners();
  }

  void resetProfile() {
    _profile = null;
    notifyListeners();
  }

  void setSearchTerm(String? term) {
    _searchTerm = term?.trim().toLowerCase() ?? '';
    notifyListeners();
  }

  void setMaxBudget(int? value) {
    _maxBudget = value;
    notifyListeners();
  }

  void addListing({
    required String title,
    required String address,
    required String city,
    required int rent,
    required int bedrooms,
    required double bathrooms,
    required double size,
    required String description,
    String? imageUrl,
  }) {
    final current = _profile;
    if (current == null || current.role != UserRole.landlord) {
      throw StateError('Only landlords can add listings');
    }
    final listing = Listing(
      id: 'l_${DateTime.now().millisecondsSinceEpoch}_${_listings.length}',
      title: title,
      address: address,
      city: city,
      monthlyRent: rent,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      squareMeters: size,
      description: description,
      imageUrl:
          imageUrl ??
          'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&w=800&q=80',
      landlordId: current.id,
      landlordName: current.fullName,
      postedAt: DateTime.now(),
    );
    _listings.insert(0, listing);
    notifyListeners();
  }
}
