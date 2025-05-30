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

/*
class H2CategoryBloc extends Bloc<H2CategoryEvent, H2CategoryState> {
  final getCamerasUseCase = serviceLocator<GetCamerasUseCase>();
  final getDecorationUsecase = serviceLocator<GetDecorationUsecase>();
  final getDressUsecase = serviceLocator<GetDressUsecase>();
  final getFootwearsUsecase = serviceLocator<GetFootwearsUsecase>();
  final getJewelrysUsecase = serviceLocator<GetJewelrysUsecase>();
  final getSoundUsecase = serviceLocator<GetSoundUsecase>();
  final getVehiclesUsecase = serviceLocator<GetVehiclesUsecase>();
  final getVenuesUseCase = serviceLocator<GetVenuesUseCase>();
  final delete = serviceLocator<DeleteCategoryItems>();
  final pref = serviceLocator<PreferencesRepository>();

  final prefs = serviceLocator<PreferencesRepository>();

  H2CategoryBloc() : super(H2CategoryInitial()) {
    log(state.toString());
    on<UpdateModelFinderEvent>((event, emit) async {
      String userCategory = await prefs.getCategoryName();
      log(userCategory);

      emit(UpdateScreen(name: userCategory, item: event.item));
    });

    on<H2LoadCategories>((event, emit) async {
      String userCategory = await prefs.getCategoryName();
      emit(H2CategoryLoading());
      try {
        switch (userCategory) {
          case Names.camera:
            final cameras = await getCamerasUseCase.call();
            emit(CameraCategoryLoaded(cameras));
            break;
          case Names.decoration:
            final decorations = await getDecorationUsecase.call();
            emit(DecorationCategoryLoaded(decorations));
            break;
          case Names.dress:
            final dresses = await getDressUsecase.call();
            emit(DressCategoryLoaded(dresses));
            break;
          case Names.footwear:
            final footwears = await getFootwearsUsecase.call();
            emit(FootwearCategoryLoaded(footwears));
            break;
          case Names.jewelry:
            final jewelrys = await getJewelrysUsecase.call();
            emit(JewelryCategoryLoaded(jewelrys));
            break;
          case Names.sound:
            final sounds = await getSoundUsecase.call();
            emit(SoundCategoryLoaded(sounds));
            break;
          case Names.vehicle:
            final vehicles = await getVehiclesUsecase.call();
            emit(VehiclesCategoryLoaded(vehicles));
            break;
          case Names.venue:
            final venues = await getVenuesUseCase.call();
            emit(VenuesCategoryLoaded(venues));
            break;
          default:
            emit(H2CategoryError('Invalid category name'));
        }
      } catch (e) {
        emit(H2CategoryError(e.toString()));
      }
    });

    on<SelectCategoryItemEvent>((event, emit) {
      // Emit the current state with the selected item
      if (state is CameraCategoryLoaded) {
        emit(CameraCategoryLoaded(
          (state as CameraCategoryLoaded).categories,
          selectedItem: event.item,
        ));
      } else if (state is DecorationCategoryLoaded) {
        emit(DecorationCategoryLoaded(
          (state as DecorationCategoryLoaded).categories,
          selectedItem: event.item,
        ));
      } else if (state is DressCategoryLoaded) {
        emit(DressCategoryLoaded(
          (state as DressCategoryLoaded).categories,
          selectedItem: event.item,
        ));
      } else if (state is FootwearCategoryLoaded) {
        emit(FootwearCategoryLoaded(
          (state as FootwearCategoryLoaded).categories,
          selectedItem: event.item,
        ));
      } else if (state is JewelryCategoryLoaded) {
        emit(JewelryCategoryLoaded(
          (state as JewelryCategoryLoaded).categories,
          selectedItem: event.item,
        ));
      } else if (state is SoundCategoryLoaded) {
        emit(SoundCategoryLoaded(
          (state as SoundCategoryLoaded).categories,
          selectedItem: event.item,
        ));
      } else if (state is VehiclesCategoryLoaded) {
        emit(VehiclesCategoryLoaded(
          (state as VehiclesCategoryLoaded).categories,
          selectedItem: event.item,
        ));
      } else if (state is VenuesCategoryLoaded) {
        emit(VenuesCategoryLoaded(
          (state as VenuesCategoryLoaded).categories,
          selectedItem: event.item,
        ));
      }
    });

    on<CategoryDetailState>((event, emit) {
      log('CategoryDetailState: ${event.itemName} - ${event.itemValue}');
      switch (event.itemName) {
        case 'cameras':
          if (state is CameraCategoryLoaded) {
            emit(CameraCategoryLoaded(
              [...event.itemValue],
              selectedItem: event.itemValue,
            ));
          } else {
            emit(H2CategoryError(
                'Invalid state: expected CameraCategoryLoaded'));
          }
          break;

        case Names.decoration:
          emit(DecorationCategoryLoaded(event.itemValue));
          break;
        case Names.dress:
          emit(DressCategoryLoaded(event.itemValue));
          break;
        case Names.footwear:
          emit(FootwearCategoryLoaded(event.itemValue));
          break;
        case Names.jewelry:
          emit(JewelryCategoryLoaded(event.itemValue));
          break;
        case Names.sound:
          emit(SoundCategoryLoaded(event.itemValue));
          break;
        case Names.vehicle:
          emit(VehiclesCategoryLoaded(event.itemValue));
          break;
        case Names.venue:
          emit(VenuesCategoryLoaded(event.itemValue));
          break;
        default:
          emit(H2CategoryError('Invalid category name'));
      }
    });

    // Update
    on<UpdateCategoryItemEvent>((event, emit) async {
      emit(H2CategoryLoading());
      try {
        String userCategory = await prefs.getCategoryName();
        switch (userCategory) {
          case Names.camera:
            await getCamerasUseCase.update(event.uid, event.item);
            emit(H2CategoryUpdated());
            await Future.delayed(const Duration(seconds: 3), () async {
              emit(H2CategoryLoading());
              final cameras = await getCamerasUseCase.call();
              emit(CameraCategoryLoaded(cameras));
            });

            break;
          case Names.decoration:
            await getDecorationUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated());
            await Future.delayed(const Duration(seconds: 3), () async {
              emit(H2CategoryLoading());
              final decorations = await getDecorationUsecase.call();
              emit(DecorationCategoryLoaded(decorations));
            });

            break;
          case Names.dress:
            await getDressUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated());
            await Future.delayed(const Duration(seconds: 3), () async {
              emit(H2CategoryLoading());

              final dresses = await getDressUsecase.call();
              emit(DressCategoryLoaded(dresses));
            });

            break;
          case Names.footwear:
            await getFootwearsUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated());
            await Future.delayed(const Duration(seconds: 3), () async {
              emit(H2CategoryLoading());
              final footwears = await getFootwearsUsecase.call();
              emit(FootwearCategoryLoaded(footwears));
            });
            break;
          case Names.jewelry:
            await getJewelrysUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated());
            await Future.delayed(const Duration(seconds: 3), () async {
              emit(H2CategoryLoading());
              final jewelrys = await getJewelrysUsecase.call();
              emit(JewelryCategoryLoaded(jewelrys));
            });
            break;
          case Names.sound:
            await getSoundUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated());
            await Future.delayed(const Duration(seconds: 3), () async {
              emit(H2CategoryLoading());
              final sounds = await getSoundUsecase.call();
              emit(SoundCategoryLoaded(sounds));
            });

            break;
          case Names.vehicle:
            await getVehiclesUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated());
            await Future.delayed(const Duration(seconds: 3), () async {
              emit(H2CategoryLoading());
              final vehicles = await getVehiclesUsecase.call();
              emit(VehiclesCategoryLoaded(vehicles));
            });
            break;
          case Names.venue:
            await getVenuesUseCase.update(event.uid, event.item);
            emit(H2CategoryUpdated());
            await Future.delayed(const Duration(seconds: 3), () async {
              emit(H2CategoryLoading());
              final venues = await getVenuesUseCase.call();
              emit(VenuesCategoryLoaded(venues));
            });
            break;
          default:
            emit(H2CategoryError('Invalid category name'));
        }
      } catch (e) {
        emit(H2CategoryError('Failed to update item: $e'));
      }
    });
    // Delete
    on<DeleteCategoryEvent>((event, emit) async {
      try {
        String userCategory = await prefs.getCategoryName();
        emit(H2CategoryLoading());
        await delete.call(userCategory, event.id);

        // Reload data from Firestore to ensure consistency
        switch (userCategory.toLowerCase()) {
          case 'camera':
            final cameras = await getCamerasUseCase.call();
            emit(CameraCategoryLoaded(cameras));
            break;
          case 'decoration':
            final decorations = await getDecorationUsecase.call();
            emit(DecorationCategoryLoaded(decorations));
            break;
          case 'dress':
            final dresses = await getDressUsecase.call();
            emit(DressCategoryLoaded(dresses));
            break;
          case 'footwear':
            final footwears = await getFootwearsUsecase.call();
            emit(FootwearCategoryLoaded(footwears));
            break;
          case 'jewelry':
            final jewelrys = await getJewelrysUsecase.call();
            emit(JewelryCategoryLoaded(jewelrys));
            break;
          case 'sound & DJ Systems':
            final sounds = await getSoundUsecase.call();
            emit(SoundCategoryLoaded(sounds));
            break;
          case 'vehicles':
            final vehicles = await getVehiclesUsecase.call();
            emit(VehiclesCategoryLoaded(vehicles));
            break;
          case 'venue':
            final venues = await getVenuesUseCase.call();
            emit(VenuesCategoryLoaded(venues));
            break;
          default:
            emit(H2CategoryError('Invalid category name'));
        }
      } catch (e) {
        emit(H2CategoryError('Failed to delete item: $e'));
      }
    });
  }
}
*/

class H2CategoryBloc extends Bloc<H2CategoryEvent, H2CategoryState> {
  final GetCamerasUseCase getCamerasUseCase =
      serviceLocator<GetCamerasUseCase>();
  final GetDecorationUsecase getDecorationUsecase =
      serviceLocator<GetDecorationUsecase>();
  final GetDressUsecase getDressUsecase = serviceLocator<GetDressUsecase>();
  final GetFootwearsUsecase getFootwearsUsecase =
      serviceLocator<GetFootwearsUsecase>();
  final GetJewelrysUsecase getJewelrysUsecase =
      serviceLocator<GetJewelrysUsecase>();
  final GetSoundUsecase getSoundUsecase = serviceLocator<GetSoundUsecase>();
  final GetVehiclesUsecase getVehiclesUsecase =
      serviceLocator<GetVehiclesUsecase>();
  final GetVenuesUseCase getVenuesUseCase = serviceLocator<GetVenuesUseCase>();

  H2CategoryBloc() : super(H2CategoryInitial()) {
    log(state.toString());
    on<DetailsEvent>((event, emit) {
      emit(DetailsState(event.itemName, event.itemValue,
          fromMain: event.fromMain));
    });

    on<InitialStageEvent>((event, emit) async {
      emit(LoadingState());
      final pref = serviceLocator<PreferencesRepository>();
      final userItemName = await pref.getCategoryName();

      final Map<String, Future<dynamic>> data = {
        Names.camera: getCamerasUseCase.call(),
        Names.decoration: getDecorationUsecase.call(),
        Names.dress: getDressUsecase.call(),
        Names.footwear: getFootwearsUsecase.call(),
        Names.jewelry: getJewelrysUsecase.call(),
        Names.sound: getSoundUsecase.call(),
        Names.vehicle: getVehiclesUsecase.call(),
        Names.venue: getVenuesUseCase.call(),
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
      log(event.name);
      await delete.call(event.name, event.id);

      final Map<String, Future<dynamic>> data = {
        Names.camera: getCamerasUseCase.call(),
        Names.decoration: getDecorationUsecase.call(),
        Names.dress: getDressUsecase.call(),
        Names.footwear: getFootwearsUsecase.call(),
        Names.jewelry: getJewelrysUsecase.call(),
        Names.sound: getSoundUsecase.call(),
        Names.vehicle: getVehiclesUsecase.call(),
        Names.venue: getVenuesUseCase.call(),
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
        // final category = await pref.getCategoryName();

        final categoryMap = {
          Names.camera: () async {
            final updated =
                await getCamerasUseCase.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));

            emit(H2CategoryLoading());
            final list = await getCamerasUseCase.call();
            emit(CameraCategoryLoaded(list));
          },
          Names.decoration: () async {
            final updated =
                await getDecorationUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));

            emit(H2CategoryLoading());
            final list = await getDecorationUsecase.call();
            emit(DecorationCategoryLoaded(list));
          },
          Names.dress: () async {
            final updated = await getDressUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));

            emit(H2CategoryLoading());
            final list = await getDressUsecase.call();
            emit(DressCategoryLoaded(list));
          },
          Names.footwear: () async {
            final updated =
                await getFootwearsUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));

            emit(H2CategoryLoading());
            final list = await getFootwearsUsecase.call();
            emit(FootwearCategoryLoaded(list));
          },
          Names.jewelry: () async {
            final updated =
                await getJewelrysUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));

            emit(H2CategoryLoading());
            final list = await getJewelrysUsecase.call();
            emit(JewelryCategoryLoaded(list));
          },
          Names.sound: () async {
            final updated = await getSoundUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));

            emit(H2CategoryLoading());
            final list = await getSoundUsecase.call();
            emit(SoundCategoryLoaded(list));
          },
          Names.vehicle: () async {
            final updated =
                await getVehiclesUsecase.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));

            emit(H2CategoryLoading());
            final list = await getVehiclesUsecase.call();
            emit(VehiclesCategoryLoaded(list));
          },
          Names.venue: () async {
            log("kerinu");
            final updated =
                await getVenuesUseCase.update(event.uid, event.item);
            emit(H2CategoryUpdated(updated));
            log("updated done");
            emit(H2CategoryLoading());
            final list = await getVenuesUseCase.call();
            log("again loading done");

            emit(LoadedState(list));
            log("loaded category");
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
