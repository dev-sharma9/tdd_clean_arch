import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:tdd_clean_arch/core/network_info.dart';
import 'package:tdd_clean_arch/features/login/data/datasources/login_remote_data_source.dart';
import 'package:tdd_clean_arch/features/login/data/repositories/login_repository_impl.dart';
import 'package:tdd_clean_arch/features/login/domain/repositories/login_repository.dart';
import 'package:tdd_clean_arch/features/login/domain/usecases/login_use_case.dart';
import 'package:tdd_clean_arch/features/login/presentation/notifier/login_notifier.dart';
import 'package:tdd_clean_arch/features/login/presentation/notifier/login_state.dart';

final _loginRemoteDataSourceProvider = Provider<LoginRemoteDataSource>((ref) => LoginRemoteDataSourceImpl(client: Client()));

final _networkInfoProvider = Provider<NetworkInfo>((ref) => NetworkInfoImpl(DataConnectionChecker()));

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final remoteDataSource = ref.watch(_loginRemoteDataSourceProvider);
  final networkInfo = ref.watch(_networkInfoProvider);

  return LoginRepositoryImpl(remoteDataSource: remoteDataSource, networkInfo: networkInfo);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) => LoginUseCase(ref.watch(loginRepositoryProvider)));

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier(ref.watch(loginUseCaseProvider)));