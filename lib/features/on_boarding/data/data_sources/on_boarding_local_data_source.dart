import 'package:educoy_app/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnBoardingLocalDataSource {
  OnBoardingLocalDataSource();

  // there is no Failure, so we just use a Future
  // instead of Either<Failure,Type>
  Future<void> cacheFirstTimer();

  Future<bool> checkIfFirstTimer();
}

const keySharedPreferences = 'anything_cache';

class OnBoardingLocalDSImpl implements OnBoardingLocalDataSource {
  OnBoardingLocalDSImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _sharedPreferences.setBool(keySharedPreferences, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfFirstTimer() async {
    try {
      // true when the cache is null and cache result if it's not null
      return _sharedPreferences.getBool(keySharedPreferences) ?? true;
    } catch (e) {
      throw const CacheException(message: 'message');
    }
  }
}
