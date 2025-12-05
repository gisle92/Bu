import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bu/models/listing.dart';
import 'package:bu/models/user_profile.dart';
import 'package:bu/state/bu_app_state.dart';
import 'package:bu/widgets/create_listing_sheet.dart';
import 'package:bu/widgets/listing_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;
  late final TextEditingController _searchCtrl;
  int? _selectedBudget;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController();
    _searchCtrl.addListener(_handleSearch);
  }

  @override
  void dispose() {
    _searchCtrl.removeListener(_handleSearch);
    _searchCtrl.dispose();
    super.dispose();
  }

  void _handleSearch() {
    if (!mounted) return;
    context.read<BuAppState>().setSearchTerm(_searchCtrl.text);
  }

  void _openCreateListing() {
    showModalBottomSheet<bool>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => const CreateListingSheet(),
    ).then((published) {
      if (published == true && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Listing published on Bu')),
        );
      }
    });
  }

  void _showContactSheet(Listing listing) {
    final profile = context.read<BuAppState>().profile;
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a note to ${listing.landlordName}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text('Introduce yourself and agree on a viewing time.'),
            const SizedBox(height: 12),
            Text(
              'Draft message',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Hi ${listing.landlordName.split(' ').first},\n'
                'I am ${profile?.fullName ?? 'a Bu user'} interested in the ${listing.title.toLowerCase()}. '
                'When could we schedule a viewing?',
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<BuAppState>();
    final user = appState.profile!;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hei, ${user.fullName.split(' ').first}'),
            Text(
              user.role == UserRole.tenant
                  ? 'Looking for a place'
                  : 'Listing as landlord',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Reset profile',
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<BuAppState>().resetProfile(),
          ),
        ],
      ),
      floatingActionButton: appState.canList
          ? FloatingActionButton.extended(
              onPressed: _openCreateListing,
              icon: const Icon(Icons.add_home_work),
              label: const Text('Add listing'),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              children: [
                TextField(
                  controller: _searchCtrl,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search by city, street, or title',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Budget'),
                    const SizedBox(width: 12),
                    DropdownButton<int?>(
                      value: _selectedBudget,
                      hint: const Text('Any'),
                      items: const [
                        DropdownMenuItem(value: null, child: Text('Any')),
                        DropdownMenuItem(
                          value: 15000,
                          child: Text('<= 15 000'),
                        ),
                        DropdownMenuItem(
                          value: 20000,
                          child: Text('<= 20 000'),
                        ),
                        DropdownMenuItem(
                          value: 30000,
                          child: Text('<= 30 000'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedBudget = value);
                        appState.setMaxBudget(value);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: appState.availableCities.map((city) {
                      final isSelected =
                          _searchCtrl.text.trim().toLowerCase() ==
                          city.toLowerCase();
                      return FilterChip(
                        label: Text(city),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            _searchCtrl.text = city;
                          } else {
                            _searchCtrl.clear();
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(value: 0, label: Text('Browse')),
                      ButtonSegment(value: 1, label: Text('My listings')),
                    ],
                    selected: {_selectedTab},
                    onSelectionChanged: (selection) =>
                        setState(() => _selectedTab = selection.first),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: IndexedStack(
                    index: _selectedTab,
                    children: [
                      _ExploreTab(
                        listings: appState.listings,
                        onContact: _showContactSheet,
                      ),
                      _MyListingsTab(
                        role: user.role,
                        listings: appState.myListings,
                        onCreate: _openCreateListing,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreTab extends StatelessWidget {
  const _ExploreTab({required this.listings, required this.onContact});

  final List<Listing> listings;
  final ValueChanged<Listing> onContact;

  @override
  Widget build(BuildContext context) {
    if (listings.isEmpty) {
      return const Center(child: Text('No homes match your filters yet.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
      itemBuilder: (context, index) {
        final listing = listings[index];
        return ListingCard(
          listing: listing,
          onContact: () => onContact(listing),
        );
      },
      separatorBuilder: (_, index) => const SizedBox(height: 16),
      itemCount: listings.length,
    );
  }
}

class _MyListingsTab extends StatelessWidget {
  const _MyListingsTab({
    required this.role,
    required this.listings,
    required this.onCreate,
  });

  final UserRole role;
  final List<Listing> listings;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    if (role != UserRole.landlord) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'You signed up as a tenant. Switch to landlord to start listing your own apartments.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (listings.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('No listings yet'),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.add_home),
              label: const Text('Publish your first home'),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
      itemCount: listings.length,
      separatorBuilder: (_, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final listing = listings[index];
        return ListingCard(
          listing: listing,
          onContact: () {},
          trailing: IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Public view of ${listing.title}')),
            ),
          ),
        );
      },
    );
  }
}
