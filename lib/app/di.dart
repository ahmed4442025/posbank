import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posbank/data/database/db_factory.dart';
import 'package:posbank/data/repository/repository_api.dart';
import 'package:posbank/domain/usecase/cases/add_note_usecase.dart';
import 'package:posbank/domain/usecase/cases/add_user_usecase.dart';
import 'package:posbank/domain/usecase/cases/get_all_interests_usecase.dart';
import 'package:posbank/domain/usecase/cases/get_all_notes_usecase.dart';
import 'package:posbank/domain/usecase/cases/get_all_users_usecase.dart';
import 'package:posbank/domain/usecase/cases/update_note_usecase.dart';
import 'package:posbank/presentation/views/add_user/add_user_view_model.dart';
import 'package:posbank/presentation/views/note/note_view_model.dart';
import 'package:sqflite/sqflite.dart';

import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_db.dart';
import '../domain/repository/repository.dart';
import '../presentation/base/shared.dart';
import '../presentation/views/edit_note/edit_not_model.dart';

final instance = GetIt.instance;

// main
Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  Dio dio = await instance<DioFactory>().getDio();

  // Database factory
  instance.registerLazySingleton<DBFactory>(() => DBFactory());
  Database db = await instance<DBFactory>().getDB();
  instance
      .registerLazySingleton<RemoteDataSourceDB>(() => RemoteDataSourceDB(db));
  instance.registerLazySingleton<RepositoryDB>(
      () => RepositoryDB(instance<RemoteDataSourceDB>()));
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceApi(instance<AppServiceClient>()));

  // repository

  instance.registerLazySingleton<RepositoryApi>(
      () => RepositoryApi(instance(), instance()));
}

// add user
initAddUserModule() {
  if (!GetIt.I.isRegistered<AddUserUseCase>()) {
    instance.registerFactory<AddUserUseCase>(() => AddUserUseCase(_getCurrentRepo()));
    initAllInterestsModule();
    instance.registerFactory<ImagePicker>(() => ImagePicker());
    instance.registerFactory<AddUserViewModel>(
        () => AddUserViewModel(instance(), instance()));
  }
}

// add note
initAddNoteModule() {
  if (!GetIt.I.isRegistered<AddNoteUseCase>()) {
    instance.registerFactory<AddNoteUseCase>(() => AddNoteUseCase(_getCurrentRepo()));
  }
}

// update note
initUpdateNoteModule() {
  if (!GetIt.I.isRegistered<UpdateNoteUseCase>()) {
    instance.registerFactory<UpdateNoteUseCase>(
        () => UpdateNoteUseCase(_getCurrentRepo()));
    // GetAllUsersUseCase
    if (!GetIt.I.isRegistered<GetAllUsersUseCase>()) {
      instance.registerFactory<GetAllUsersUseCase>(
          () => GetAllUsersUseCase(_getCurrentRepo()));
    }
    instance.registerFactory<EditNoteViewModel>(
        () => EditNoteViewModel(instance(), instance()));
  }
}

// get all interests
initAllInterestsModule() {
  if (!GetIt.I.isRegistered<GetAllInterestsUseCase>()) {
    instance.registerFactory<GetAllInterestsUseCase>(
        () => GetAllInterestsUseCase(_getCurrentRepo()));
  }
}

// get all notes
initAllNotesModule() async {
  if (!GetIt.I.isRegistered<GetAllNotesUseCase>()) {
    instance.registerFactory<GetAllNotesUseCase>(
        () => GetAllNotesUseCase(_getCurrentRepo()));
    initAddNoteModule();
    instance.registerFactory<NoteHomeViewModel>(
        () => NoteHomeViewModel(instance(), instance()));
  }
}


// get DB or API
Repository _getCurrentRepo(){
  if (isFromLocal){
    return instance<RepositoryDB>();
  }else{
    return instance<RepositoryApi>();
  }
}