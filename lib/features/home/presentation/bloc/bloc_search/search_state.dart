// Example: in search_state.dart
import 'package:flutter/material.dart';

class SearchState {
  final String searchText;
  final List<Map<String, dynamic>> filteredSuggestions;

  SearchState({
    this.searchText = '',
    required this.filteredSuggestions,
  });

  factory SearchState.initial() {
    return SearchState(
      searchText: '',
      filteredSuggestions: [
        {'icon': Icons.camera_alt, 'label': 'Cameras'},
        {'icon': Icons.checkroom, 'label': 'Dresses'},
        {'icon': Icons.celebration, 'label': 'Decoration'},
        {'icon': Icons.directions_walk, 'label': 'Footwears'},
        {'icon': Icons.diamond, 'label': 'Jewelry'},
        {'icon': Icons.surround_sound, 'label': 'Sound & DJ'},
        {'icon': Icons.directions_car, 'label': 'Vehicles'},
        {'icon': Icons.apartment, 'label': 'Venues'},
      ],
    );
  }

  SearchState copyWith({
    String? searchText,
    List<Map<String, dynamic>>? filteredSuggestions,
  }) {
    return SearchState(
      searchText: searchText ?? this.searchText,
      filteredSuggestions: filteredSuggestions ?? this.filteredSuggestions,
    );
  }
}
