import 'package:blablabla/repository/locations_repository.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static LocationsService? _instance;

  final LocationsRepository repository;

  LocationsService._internal(this.repository);

  static void initialize(LocationsRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    } else {
      throw Exception("LocationsService is already initialized.");
    }
  }

  ///
  /// Singleton accessor
  ///
  static LocationsService get instance {
    if (_instance == null) {
      throw Exception(
        "LocationsService is not initialized. Call initialize() first.",
      );
    }
    return _instance!;
  }
}
