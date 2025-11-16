import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/features/category_list/domain/usecase/delete_category_items.dart';
import 'package:serve_mate/features/category_list/domain/usecase/get_cameras_usecase.dart';
import 'package:serve_mate/features/category_list/domain/usecase/get_decoration_usecase.dart';
import 'package:serve_mate/features/category_list/domain/usecase/get_dress_usecase.dart';
import 'package:serve_mate/features/category_list/domain/usecase/get_footwears_usecase.dart';
import 'package:serve_mate/features/category_list/domain/usecase/get_jewelrys_usecase.dart';
import 'package:serve_mate/features/category_list/domain/usecase/get_sound_usecase.dart';
import 'package:serve_mate/features/category_list/domain/usecase/get_vehicles_usecase.dart';
import 'package:serve_mate/features/category_list/domain/usecase/get_venues_usecase.dart';
import 'h2_category_event.dart';
import 'h2_category_state.dart';

class H2CategoryBloc extends Bloc<H2CategoryEvent, H2CategoryState> {
  final GetCamerasUseCase getCameras = serviceLocator<GetCamerasUseCase>();
  final GetDecorationUsecase getDecoration =
      serviceLocator<GetDecorationUsecase>();
  final GetDressUsecase getDress = serviceLocator<GetDressUsecase>();
  final GetFootwearsUsecase getFootwears =
      serviceLocator<GetFootwearsUsecase>();
  final GetJewelrysUsecase getJewelrys = serviceLocator<GetJewelrysUsecase>();
  final GetSoundUsecase getSound = serviceLocator<GetSoundUsecase>();
  final GetVehiclesUsecase getVehicles = serviceLocator<GetVehiclesUsecase>();
  final GetVenuesUseCase getVenues = serviceLocator<GetVenuesUseCase>();

  H2CategoryBloc() : super(H2CategoryInitial()) {
    on<DetailsEvent>((event, emit) {
      emit(DetailsState(event.itemName, event.itemValue,
          fromMain: event.fromMain));
    });

    on<InitialStageEvent>((event, emit) async {
      emit(LoadingState());
      final pref = serviceLocator<PreferencesRepository>();
      final userItemName = await pref.getCategoryName();

      final Map<String, Future<dynamic>> data = {
        Names.camera: getCameras.call(),
        Names.decoration: getDecoration.call(),
        Names.dress: getDress.call(),
        Names.footwear: getFootwears.call(),
        Names.jewelry: getJewelrys.call(),
        Names.sound: getSound.call(),
        Names.vehicle: getVehicles.call(),
        Names.venue: getVenues.call(),
      };

      if (!data.containsKey(userItemName)) {
        emit(ErrorState("No category found or unsupported category."));
        return;
      }

      try {
        final getData = await data[userItemName];
        emit(LoadedState(getData));
      } catch (e) {
        emit(ErrorState(
            "Failed to load data for category: $userItemName\nError: $e"));
      }
    });

    on<DeleteCategoryEvent>((event, emit) async {
      final delete = serviceLocator<DeleteCategoryItems>();
      emit(H2CategoryLoading());
      await delete.call(event.name, event.id);

      final Map<String, Future<dynamic>> data = {
        Names.camera: getCameras.call(),
        Names.decoration: getDecoration.call(),
        Names.dress: getDress.call(),
        Names.footwear: getFootwears.call(),
        Names.jewelry: getJewelrys.call(),
        Names.sound: getSound.call(),
        Names.vehicle: getVehicles.call(),
        Names.venue: getVenues.call(),
      };

      if (!data.containsKey(event.name)) {
        emit(ErrorState("No category found or unsupported category."));
        return;
      }

      try {
        final getData = await data[event.name];
        emit(LoadedState(getData));
      } catch (e) {
        emit(ErrorState(
            "Failed to load data for category: ${event.name}\nError: $e"));
      }
    });

    // Update
    on<UpdateStage>((event, emit) async {
      emit(UpdateState(event.name, event.item));
    });
    on<UpdateCategoryItemEvent>((event, emit) async {
      emit(H2CategoryLoading());
      try {
        final pref = serviceLocator<PreferencesRepository>();
        final category = event.name ?? await pref.getCategoryName();
        final categoryMap = {
          Names.camera: () async {
            log("-------------");
            log(event.item.images.toString());
            log("-------------");
            final updated = await getCameras.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));
            emit(H2CategoryLoading());
            final list = await getCameras.call();
            emit(LoadedState(list));
          },
          Names.decoration: () async {
            final updated = await getDecoration.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));
            emit(H2CategoryLoading());
            final list = await getDecoration.call();
            emit(LoadedState(list));
          },
          Names.dress: () async {
            final updated = await getDress.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));
            emit(H2CategoryLoading());
            final list = await getDress.call();
            emit(LoadedState(list));
          },
          Names.footwear: () async {
            final updated = await getFootwears.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));
            emit(H2CategoryLoading());
            final list = await getFootwears.call();
            emit(LoadedState(list));
          },
          Names.jewelry: () async {
            final updated = await getJewelrys.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));
            emit(H2CategoryLoading());
            final list = await getJewelrys.call();
            emit(LoadedState(list));
          },
          Names.sound: () async {
            final updated = await getSound.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));
            emit(H2CategoryLoading());
            final list = await getSound.call();
            emit(LoadedState(list));
          },
          Names.vehicle: () async {
            final updated = await getVehicles.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));
            emit(H2CategoryLoading());
            final list = await getVehicles.call();
            emit(LoadedState(list));
          },
          Names.venue: () async {
            final updated = await getVenues.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));
            emit(H2CategoryLoading());
            final list = await getVenues.call();
            emit(LoadedState(list));
          },
        };

        if (categoryMap.containsKey(category)) {
          await categoryMap[category]!();
        } else {
          emit(H2CategoryError('Invalid category name'));
        }
      } catch (e) {
        emit(H2CategoryError('Failed to update item: $e'));
      }
    });
  }
}
// 503 -> 178
