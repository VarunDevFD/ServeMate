import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/utils/constants.dart';
import 'package:serve_mate/core/utils/helper/size_helper_functions.dart';
import 'package:serve_mate/features/home/domain/usecase/camera_usecase_home.dart';
import 'package:serve_mate/features/home/domain/usecase/decoration_usecase_home.dart';
import 'package:serve_mate/features/home/domain/usecase/dress_usecase_home.dart';
import 'package:serve_mate/features/home/domain/usecase/footwear_usecase_home.dart';
import 'package:serve_mate/features/home/domain/usecase/get_user_categorys_list_usecase.dart';
import 'package:serve_mate/features/home/domain/usecase/jewelry_usecase_home.dart';
import 'package:serve_mate/features/home/domain/usecase/sound_usecase_home.dart';
import 'package:serve_mate/features/home/domain/usecase/vehicle_usecase_home.dart';
import 'package:serve_mate/features/home/domain/usecase/venues_usecase_home.dart';

part 'home_session_bloc_event.dart';
part 'home_session_bloc_state.dart';

class SessionCategoryBloc
    extends Bloc<SessionCtegoryEvent, SessionCategoryState> {
  SessionCategoryBloc() : super(SessionBlocInitial()) {
    on<LoadSessionCategoryEvent>(_onLoadSessionCategory);
    // Trigger initial fetch
    add(LoadSessionCategoryEvent());
    // on<UserCategoryListEvent>((event, emit) {
    //   final usecase = serviceLocator<GetUserCategorysListUsecase>();
    //   final userCategoryList = usecase.call();

    // });
    // on<HomeBlocEvent>((event, emit) {});
  }

  _onLoadSessionCategory(LoadSessionCategoryEvent event,
      Emitter<SessionCategoryState> emit) async {
    emit(SessionBlocLoading());
    final pref = serviceLocator<PreferencesRepository>();
    final usecase = serviceLocator<GetUserCategorysListUsecase>();
    final uid = (event.uid == Names.empty) ? await pref.getUserId() : event.uid;

    final userCategoryList = await usecase.call(uid: uid);

    // Track data only for true keys
    final Map<String, dynamic> loadedData = {};
    final List<String> trueList = [];

    for (final entry in userCategoryList.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value) {
        trueList.add(key);

        switch (key) {
          case Names.camera:
            loadedData['cameras'] =
                await serviceLocator<CameraUsecaseHome>().call();
            break;
          case Names.decoration:
            loadedData['decorations'] =
                await serviceLocator<DecorationUsecaseHome>().call();
            break;
          case Names.dress:
            loadedData['dresses'] =
                await serviceLocator<DressUsecaseHome>().call();
            break;
          case Names.footwear:
            loadedData['footwears'] =
                await serviceLocator<FootwearUsecaseHome>().call();
            break;
          case Names.jewelry:
            loadedData['jewelrys'] =
                await serviceLocator<JewelryUsecaseHome>().call();
            break;
          case Names.sound:
            loadedData['sounds'] =
                await serviceLocator<SoundUsecaseHome>().call();
            break;
          case Names.vehicle:
            loadedData['vehicles'] =
                await serviceLocator<VehicleUsecaseHome>().call();
            break;
          case Names.venue:
            loadedData['venues'] =
                await serviceLocator<VenuesUsecaseHome>().call();
            break;
        }
      }
    }

    // Emit based on presence of true cases
    if (loadedData.isEmpty) {
      final categoryName = await pref.getCategoryName();

      emit(SessionBlocInitial(categoryName));
    } else {
      double maxH = Size().availableSize(loadedData.keys.length);
      emit(SessionBlocLoaded(
        data: loadedData,
        minHeight: 250.h,
        maxHeight: maxH,
      ));
    }
  }
}
