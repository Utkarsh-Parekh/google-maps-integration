# Google Maps Integration

A Flutter application that integrates **Google Maps** using the **BLoC architecture**. It supports **dynamic theme switching** (light/dark), **real-time location tracking**, and **address management**, including adding new addresses and viewing them on a separate screen.

---

## 🚀 Features

- 🌍 Google Maps integration using Flutter's `google_maps_flutter`
- 🧭 Drag map to update user's current location dynamically
- ➕ Add new addresses with real-time coordinates
- 🎨 Dynamic theme switching (light & dark)
- 📂 Address list screen to view all saved addresses
- 🧱 Clean architecture with **BLoC** for state management
- 📱 Responsive and theme-adaptive UI

---

## 🧑‍💻 Architecture

- **BLoC Pattern** for state management (`flutter_bloc`)
- **Theme Provider** to handle theme changes
- **Location BLoC** to manage current location and dragging updates
- **Address BLoC** to add and fetch addresses

---

## 🗂️ Project Structure
          
- lib/
  - screens/
    - maps/
      - bloc/
        - address-bloc/
          - address_bloc.dart
          - address_event.dart
          - address_state.dart
        - location-bloc/
          - location_bloc.dart
          - location_event.dart
          - location_state.dart
      - constants/
        - maps_constants.dart
      - model/
        - address_model.dart
      - screens/
        - address_details.dart
        - maps_screen.dart
      - widgets/
        - address_widget.dart
        - current_location_widget.dart
        - googlemaps_widget.dart
        - receiver_details.dart
        - searchbar_widget.dart

---

## Google Maps Integration App-Demo
https://github.com/user-attachments/assets/1823c574-4fef-4959-8ad1-6ece57e5b199

