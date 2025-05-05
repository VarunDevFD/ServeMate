import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
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
    on<H2LoadCategories>((event, emit) async {
      String userCategory = await prefs.getCategoryName(); 
      emit(H2CategoryLoading());
      try {
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
          case 'sound':
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
          case 'sound':
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
