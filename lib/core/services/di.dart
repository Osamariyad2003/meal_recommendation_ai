import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_recommendation_ai/features/SeeAllScreen/presentation/controller/Bloc/SeeAll%20BLoc.dart';
import 'package:meal_recommendation_ai/features/auth/register/domain/base_repo/user_repo.dart';
import '../../features/SeeAllScreen/data/data_source/SeeallDataSourceImpl.dart';
import '../../features/SeeAllScreen/data/repository/SeeAllRepositoryImpl.dart';
import '../../features/SeeAllScreen/domain/repositories/BaseSeeAllRepository.dart';
import '../../features/auth/Login_Screen/data/data_source/LoginDataSourceImpl.dart';
import '../../features/auth/Login_Screen/data/repository/LoginRepositoryImpl.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginDataSource.dart';
import '../../features/auth/Login_Screen/domain/repositories/BaseLoginRepository.dart';
import '../../features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login BLoc.dart';
import '../../features/auth/register/data/data_source/data_source.dart';
import '../../features/auth/register/data/repo/repo.dart';
import '../../features/home/data/meal_repo_impl.dart';

import '../../features/auth/register/persentation/controller/sign_up_bloc.dart';
import '../../features/favourite/data/repository/fetch_save_meal_repo_impl.dart';
import '../../features/favourite/domain/repositories/fetch_save_fav_repository.dart';
import '../../features/favourite/domain/use_cases/fetch_save_fav_use_case.dart';
import '../../features/favourite/presentation/controller/fav_meal_bloc.dart';
import '../../features/home/data/add_meal_repository_impl.dart';
import '../../features/home/data/data_source.dart';
import '../../features/home/data/local_data.dart';
import '../../features/home/domain/add_meal_repository.dart';
import '../../features/home/domain/repo/meal_repo.dart';
import '../../features/home/domain/usecase/add_meal_to_fav.dart';
import '../../features/home/domain/usecase/fetch_meals.dart';
import '../../features/home/domain/usecase/firestore_usecase.dart';
import '../../features/home/domain/usecase/remove_meal.dart';
import '../../features/home/domain/usecase/remove_meal_from_fireStore.dart';
import '../../features/home/domain/usecases/meal_usecase.dart';
import '../../features/layout/presentation/blocs/layout_bloc.dart';
import '../../features/profile/data/profile_repository_impl.dart';
import '../../features/profile/data/remote/profile_data_source_impl.dart';
import '../../features/profile/domain/profile_repository.dart';
import '../../features/profile/domain/usecases/change_password_use_case.dart';
import '../../features/profile/domain/usecases/get_profile_use_case.dart';
import '../../features/profile/domain/usecases/logout_use_case.dart';
import '../../features/profile/presentation/controller/profile_bloc_bloc.dart';
import '../../features/sidebar/data/data_source/remote_data_source.dart';
import '../../features/sidebar/data/repoImp/repo_imp.dart';
import '../../features/sidebar/domain/repo/sidebar_repo.dart';
import '../../features/sidebar/presentation/controller/bloc/side_bloc.dart';

final GetIt di = GetIt.instance;

void setupServiceLocator() {

  //data source
  di.registerLazySingleton<RemoteDataSourceFirebase>(
      () => RemoteDataSourceFirebase());

          ()=> RemoteDataSourceFirebase();
  di.registerLazySingleton<RemoteSideBarDataSource>(
          ()=> RemoteSideBarDataSource());

  di.registerLazySingleton<BaseLoginDataSource>(() => LoginDataSourceImpl());
  di.registerLazySingleton<SeeAllDataSource>(() => SeeAllDataSource());


  //  repositories
  di.registerLazySingleton<UserRepository>(
          ()=> UserRepositoryImpl(di())
  );


  di.registerLazySingleton<BaseLoginRepository>(
        () => LoginRepositoryImpl(loginDataSource: di()),
  );
  di.registerLazySingleton<SeeAllRepositoryImpl>(
        () => SeeAllRepositoryImpl(seeAllDataSource: di()),
  );
  di.registerLazySingleton<SidebarRepo>(
        () => SidebarRepoImp(di()),
  );
  di.registerLazySingleton<MealRepository>(
          () => MealRepositoryImpl(di<FirebaseService>(),di<LocalData>()));

  // Register Repository
  di.registerLazySingleton<FetchAndSaveFavMealsRepository>(
        () => MealRepositoryImpl_Fetch(di<FirebaseFirestore>()),
  );




  // Register Use Case
  di.registerLazySingleton<FetchAndSaveFavMealsUseCase>(
        () => FetchAndSaveFavMealsUseCase(di<FetchAndSaveFavMealsRepository>()),
  );



  //  use cases
 // Register MealRepository
  di.registerLazySingleton<AddMealRepository>(() => AddMealRepositoryImpl(di()));

  // Register MealUseCase, which depends on MealRepository
  di.registerLazySingleton<MealUseCase>(() => MealUseCase(di<AddMealRepository>()));

// Register FirebaseAuth
di.registerLazySingleton<FirebaseAuth>(
  () => FirebaseAuth.instance,
);
// Register ChangePasswordUseCase
di.registerLazySingleton<ChangePasswordUseCase>(
  () => ChangePasswordUseCase(di<FirebaseAuth>()),
);
// Register ProfileDataSourceImpl
di.registerLazySingleton<ProfileDataSource>(
  () => ProfileDataSource(FirebaseFirestore.instance, di<ChangePasswordUseCase>()),
);
// Register ProfileRepositoryImpl
di.registerLazySingleton<ProfileRepository>(
  () => ProfileRepositoryImpl(di<ProfileDataSource>()),
);
// Register GetUserProfileUseCase
di.registerLazySingleton<GetUserProfileUseCase>(
  () => GetUserProfileUseCase(di<ProfileRepository>()),
);
// Register ProfileBloc
di.registerLazySingleton<ProfileBloc>(
  () => ProfileBloc(di<GetUserProfileUseCase>(), di<ChangePasswordUseCase>(),
   di<LogoutUseCase>(),
   ),
);
di.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase());


  //  blocs or cubits
  di.registerLazySingleton<UserBloc>(() => UserBloc(di()));


  di.registerLazySingleton<LoginBloc>(
      () => (LoginBloc(di.get<BaseLoginRepository>())));
  // note :: here meal bloc of favourite screen
  di.registerFactory<FavMealBloc>(() => FavMealBloc(di<FetchAndSaveFavMealsUseCase>()));
  di.registerLazySingleton<LayoutBloc>(() => LayoutBloc());
  di.registerLazySingleton<SeeAllBloc>(() => SeeAllBloc(di<SeeAllRepositoryImpl>()));



  di.registerLazySingleton<SideBarBloc>(() =>
  (SideBarBloc(di())));

  di.registerLazySingleton(() => FetchMeals(di<MealRepository>()));
  di.registerLazySingleton(() => AddMealToFav(di<MealRepository>()));
  di.registerLazySingleton(() => RemoveMeal(di<MealRepository>()));
  di.registerLazySingleton(() => UpdateIsFavInFirestore(di<MealRepository>()));
  di.registerLazySingleton(() => RemoveMealFromFirestore(di<MealRepository>()));



  //External Libraries like dio
  di.registerLazySingleton<FirebaseService>(() => FirebaseService());


  di.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  di.registerLazySingleton<LocalData>(() => LocalData());


}






