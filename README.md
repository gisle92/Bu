# Bu 🏡

Bu is a Flutter application that helps people either **list** or **find** apartments to rent in Norway.  
The current build focuses on fast onboarding and a lightweight marketplace experience so you can pitch, test, or extend the concept quickly.

## What’s inside

- Flutter 3.38 app scaffolded with Material 3 design tokens
- Local profile creation with role selection (`Tenant` or `Landlord`)
- Demo listings backed by in-memory data + mock photos
- Browse tab with search, budget filter, and smart city chips
- Landlord tools: publish listings through a bottom-sheet form and manage them from the “My listings” tab

## Getting started

```bash
cd bu
flutter run        # or flutter run -d chrome / -d linux / -d macos
```

Useful scripts:

- `flutter analyze` – static analysis
- `flutter test` – widget smoke tests

## Project layout

```
lib/
 ├─ models/                // data classes for users & listings
 ├─ state/bu_app_state.dart // ChangeNotifier for global state
 ├─ screens/               // onboarding + dashboard flows
 └─ widgets/               // reusable UI pieces like cards & forms
```

## Next steps

- Hook the onboarding flow to a real auth backend (Firebase Auth, Supabase, or Appwrite)
- Replace the in-memory listings with Firestore/Supabase tables or your own API
- Add real chat/contact integrations (email deep-links, WhatsApp, Twilio, etc.)
- Expand filtering (dates, amenities, pets) and add map search

Happy building! 🎉
