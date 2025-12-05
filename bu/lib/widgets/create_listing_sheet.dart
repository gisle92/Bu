import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bu/state/bu_app_state.dart';

class CreateListingSheet extends StatefulWidget {
  const CreateListingSheet({super.key});

  @override
  State<CreateListingSheet> createState() => _CreateListingSheetState();
}

class _CreateListingSheetState extends State<CreateListingSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _rentCtrl = TextEditingController();
  final _bedsCtrl = TextEditingController();
  final _bathsCtrl = TextEditingController();
  final _sizeCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _rentCtrl.dispose();
    _bedsCtrl.dispose();
    _bathsCtrl.dispose();
    _sizeCtrl.dispose();
    _descCtrl.dispose();
    _imageCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final rent = int.tryParse(_rentCtrl.text) ?? 0;
    final beds = int.tryParse(_bedsCtrl.text) ?? 1;
    final baths = double.tryParse(_bathsCtrl.text) ?? 1;
    final size = double.tryParse(_sizeCtrl.text) ?? 40;

    try {
      context.read<BuAppState>().addListing(
        title: _titleCtrl.text.trim(),
        address: _addressCtrl.text.trim(),
        city: _cityCtrl.text.trim(),
        rent: rent,
        bedrooms: beds,
        bathrooms: baths,
        size: size,
        description: _descCtrl.text.trim(),
        imageUrl: _imageCtrl.text.trim().isEmpty
            ? null
            : _imageCtrl.text.trim(),
      );
      Navigator.of(context).pop(true);
    } on StateError catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'New listing',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Headline'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Add a headline'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressCtrl,
                decoration: const InputDecoration(labelText: 'Street address'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Address is required'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cityCtrl,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'City is required'
                    : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _rentCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Monthly rent (NOK)',
                      ),
                      validator: (value) =>
                          value == null || int.tryParse(value) == null
                          ? 'Enter a valid rent'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _sizeCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Size (m²)'),
                      validator: (value) =>
                          value == null || double.tryParse(value) == null
                          ? 'Enter m²'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _bedsCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Bedrooms'),
                      validator: (value) =>
                          value == null || int.tryParse(value) == null
                          ? 'Enter bedrooms'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _bathsCtrl,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(labelText: 'Bathrooms'),
                      validator: (value) =>
                          value == null || double.tryParse(value) == null
                          ? 'Enter bathrooms'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descCtrl,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.trim().length < 20
                    ? 'Describe the home in at least 20 characters'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imageCtrl,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                  hintText: 'https://...',
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _handleSubmit,
                  icon: const Icon(Icons.cloud_upload_outlined),
                  label: const Text('Publish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
