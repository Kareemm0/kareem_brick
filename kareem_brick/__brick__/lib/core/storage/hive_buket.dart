import 'dart:convert' show jsonEncode, jsonDecode;

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:tot_bricks/core/core.dart';

import '../core.dart';

abstract class NoSqlStorage {
  Future<MapBucket> openMapBucket(String name);
  Future<ListBucket<T>> openListBucket<T>(String name);
  Future<QueueBucket<T>> openQueueBucket<T>(String name);
}

abstract class Bucket extends Equatable {
  final String name;
  const Bucket({required this.name});
  FutureEitherFailureOr<int> clear();
  @override
  List<Object?> get props => [name];
}

abstract class MapBucket extends Bucket {
  const MapBucket({required super.name});

  FutureEitherFailureOr<void> put(String key, Map<String, dynamic> value);
  FutureEitherFailureOrMap get(String key);

  FutureEitherFailureOrMap remove(String key);

  FutureEitherFailureOrMap toMap();
}

abstract class ListBucket<T> extends Bucket {
  const ListBucket({required super.name});

  FutureEitherFailureOr<int> add(T value);

  FutureEitherFailureOr<List<T>> get values;
}

abstract class QueueBucket<T> extends Bucket {
  const QueueBucket({required super.name});

  FutureEitherFailureOr<void> add(T value);

  FutureEitherFailureOr<List<T>> get values;
}

class NoSqlStorageHiveImpl implements NoSqlStorage {
  final HiveInterface hive;

  NoSqlStorageHiveImpl({required this.hive});
  @override
  Future<ListBucket<T>> openListBucket<T>(String name) async {
    final box = await hive.openBox<T>(name);
    return HiveListBucket<T>(name: name, box: box);
  }

  @override
  Future<MapBucket> openMapBucket(String name) async {
    final box = await hive.openBox(name);
    return HiveMapBucket(name: name, box: box);
  }

  @override
  Future<QueueBucket<T>> openQueueBucket<T>(String name) async {
    final box = await hive.openBox<T>(name);
    return HiveQueueBucket(name: name, box: box);
  }
}

class HiveMapBucket extends MapBucket {
  final Box _box;

  const HiveMapBucket({required super.name, required Box<dynamic> box})
    : _box = box;
  @override
  FutureEitherFailureOr<int> clear() async {
    try {
      final result = await _box.clear();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }

  @override
  FutureEitherFailureOr<void> put(
    String key,
    Map<String, dynamic> value,
  ) async {
    try {
      final json = jsonEncode(value);
      final result = await _box.put(key, json);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }

  @override
  FutureEitherFailureOrMap toMap() async {
    try {
      final map = _box.toMap();

      final decodedMap = map.map(
        (k, v) => MapEntry(k as String, jsonDecode(v)),
      );
      return Right(decodedMap);
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }

  @override
  FutureEitherFailureOrMap get(String key) async {
    try {
      final result = _box.get(key);
      return Right(jsonDecode(result));
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }

  @override
  FutureEitherFailureOrMap remove(String key) async {
    try {
      final result = _box.get(key);
      await _box.delete(key);
      return Right(jsonDecode(result));
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }
}

class HiveListBucket<T> extends ListBucket<T> {
  final Box<T> _box;

  const HiveListBucket({required super.name, required Box<T> box}) : _box = box;

  @override
  FutureEitherFailureOr<int> add(T value) async {
    // final json = jsonEncode(value);

    try {
      final result = await _box.add(value);

      return Right(result);
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }

  @override
  FutureEitherFailureOr<int> clear() async {
    try {
      final result = await _box.clear();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }

  @override
  FutureEitherFailureOr<List<T>> get values async {
    try {
      // final values = _box.values.map((e) {
      //   final json = jsonDecode(e);
      //   return (json as Map<String, dynamic>);
      // }).toList();
      final result = _box.values.toList();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }
}

class HiveQueueBucket<T> extends QueueBucket<T> {
  final Box<T> _box;
  final int maxSize;

  const HiveQueueBucket({
    required super.name,
    required Box<T> box,
    this.maxSize = 5,
  }) : _box = box;

  @override
  FutureEitherFailureOr<int> add(T value) async {
    /// check if value already exists
    try {
      final result = await values;

      return result.fold(
        (failre) {
          return Left(ServerFailure(msg: failre.msg));
        },
        (list) async {
          if (list.contains(value)) return const Right(0);

          if (_box.length >= maxSize) {
            await _box.deleteAt(0);
          }

          final result = await _box.add(value);
          return Right(result);
        },
      );
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }

  @override
  FutureEitherFailureOr<int> clear() async {
    try {
      final result = await _box.clear();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }

  @override
  FutureEitherFailureOr<List<T>> get values async {
    try {
      final result = _box.values.toSet().toList();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }
}
