import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// EVENTS
abstract class CategorySelectionEvent extends Equatable {
  const CategorySelectionEvent();
  @override
  List<Object?> get props => [];
}

class ToggleCategory extends CategorySelectionEvent {
  final String category;
  final bool isSelected;

  const ToggleCategory(this.category, this.isSelected);

  @override
  List<Object?> get props => [category, isSelected];
}

// STATES
class CategorySelectionState extends Equatable {
  final List<String> selectedCategories;

  const CategorySelectionState({this.selectedCategories = const []});

  CategorySelectionState copyWith({List<String>? selectedCategories}) {
    return CategorySelectionState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  @override
  List<Object?> get props => [selectedCategories];
}

// BLOC
class CategorySelectionBloc
    extends Bloc<CategorySelectionEvent, CategorySelectionState> {
  CategorySelectionBloc() : super(const CategorySelectionState()) {
    on<ToggleCategory>((event, emit) {
      final updated = List<String>.from(state.selectedCategories);
      if (event.isSelected) {
        updated.add(event.category);
      } else {
        updated.remove(event.category);
      }
      emit(state.copyWith(selectedCategories: updated));
    });
  }
}
