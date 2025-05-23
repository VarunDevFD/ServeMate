
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterChipState {
  final Map<String, List<String>> selections;
  final bool isExpanded;

  FilterChipState({
    required this.selections,
    this.isExpanded = false,
  });
}

class FilterChipCubit extends Cubit<FilterChipState> {
  FilterChipCubit() : super(FilterChipState(selections: {}));

  void updateSelection(String id, List<String> selection) {
    final newSelections = Map<String, List<String>>.from(state.selections);
    newSelections[id] = selection;
    emit(FilterChipState(
      selections: newSelections,
      isExpanded: state.isExpanded,
    ));
  }

  void reset(String id) {
    final newSelections = Map<String, List<String>>.from(state.selections);
    newSelections[id] = [];
    emit(FilterChipState(
      selections: newSelections,
      isExpanded: state.isExpanded,
    ));
  }

   void resetAll() {
    final newSelections = <String, List<String>>{};
    // Iterate through existing keys and set them to empty lists
    state.selections.forEach((key, value) {
      newSelections[key] = [];
    });
    emit(FilterChipState(
      selections: newSelections,
      isExpanded: false, // Optionally reset isExpanded to false
    ));
  }

  void toggleExpanded(String id) {
    emit(FilterChipState(
      selections: state.selections,
      isExpanded: !state.isExpanded,
    ));
  }

  List<String> getSelection(String id) {
    return state.selections[id] ?? [];
  }
}
