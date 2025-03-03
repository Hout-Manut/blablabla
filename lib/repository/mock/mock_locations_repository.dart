import 'package:blablabla/dummy_data/dummy_data.dart';
import 'package:blablabla/model/ride/locations.dart';
import 'package:blablabla/repository/locations_repository.dart';

class MockLocationsRepository extends LocationsRepository {
  final List<Location> _locations = cambodiaLocations;

  @override
  List<Location> getLocations() {
    return _locations;
  }

}
