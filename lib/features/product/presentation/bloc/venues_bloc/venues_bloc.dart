import 'package:flutter_bloc/flutter_bloc.dart';
import 'venues_event.dart';
import 'venues_state.dart';

class VenueFormBloc extends Bloc<VenueFormEvent, VenueFormState> {
  VenueFormBloc() : super(const VenueFormState()) {
    // Handle toggling of facility selection
    on<ToggleFacility>((event, emit) {
      final updatedFacilities = List<String>.from(state.selectedFacilities);
      if (updatedFacilities.contains(event.facility)) {
        updatedFacilities.remove(event.facility);
      } else {
        updatedFacilities.add(event.facility);
      }
      emit(state.copyWith(selectedFacilities: updatedFacilities));
    });

    // Handle expanding/collapsing the facilities list
    on<ToggleFacilitiesListExpansion>((event, emit) {
      emit(state.copyWith(isFacilitiesExpanded: !state.isFacilitiesExpanded));
    });
  }
}
