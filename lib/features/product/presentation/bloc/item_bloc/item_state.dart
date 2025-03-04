import 'package:serve_mate/features/product/data/models/camera_model.dart';

class FormSubState {
  final CameraModel cameraData;
  final bool isAvailable;
  final bool isAvailableCheckbox;
  final String gender;
  final List<String> selectedFilters;
  final Map<String, bool> isFilterChipExpanded;

  FormSubState({
    required this.cameraData,
    this.isAvailable = false,
    this.isAvailableCheckbox = false,
    this.gender = 'Male',
    this.selectedFilters = const [],
    this.isFilterChipExpanded = const {},
  });

  FormSubState copyWith({
    CameraModel? cameraData,
    bool? isAvailable,
    bool? isAvailableCheckbox,
    String? gender,
    List<String>? selectedFilters,
    Map<String, bool>? isFilterChipExpanded,
  }) {
    return FormSubState(
      cameraData: cameraData ?? this.cameraData,
      isAvailable: isAvailable ?? this.isAvailable,
      gender: gender ?? this.gender,
      isAvailableCheckbox: isAvailableCheckbox ?? this.isAvailableCheckbox,
      selectedFilters: selectedFilters ?? this.selectedFilters,
      isFilterChipExpanded: isFilterChipExpanded ?? this.isFilterChipExpanded,
    );
  }
}
