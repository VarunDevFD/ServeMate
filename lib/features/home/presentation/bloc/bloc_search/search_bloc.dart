import 'package:bloc/bloc.dart';
import 'search_event.dart';
import 'search_state.dart';
import 'package:flutter/material.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<Map<String, dynamic>> _allSuggestions = const [
    {'icon': Icons.camera_alt, 'label': 'Cameras'},
    {'icon': Icons.checkroom, 'label': 'Dresses'},
    {'icon': Icons.celebration, 'label': 'Decoration'},
    {'icon': Icons.directions_walk, 'label': 'Footwears'},
    {'icon': Icons.diamond, 'label': 'Jewelry'},
    {'icon': Icons.surround_sound, 'label': 'Sound & DJ'},
    {'icon': Icons.directions_car, 'label': 'Vehicles'},
    {'icon': Icons.apartment, 'label': 'Venues'},
  ];

  SearchBloc() : super(SearchState.initial()) {
    on<SearchTextChanged>(_onTextChanged);
    on<SearchClearPressed>(_onClearPressed);
  }

  void _onTextChanged(SearchTextChanged event, Emitter<SearchState> emit) {
    final query = event.text.toLowerCase();

    final filtered = _allSuggestions.where((item) {
      return item['label'].toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(
      searchText: event.text,
      filteredSuggestions: filtered,
    ));
  }

  void _onClearPressed(SearchClearPressed event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      searchText: '',
      filteredSuggestions: _allSuggestions,
    ));
  }
}
