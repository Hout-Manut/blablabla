import 'package:blablabla/repository/mock/mock_locations_repository.dart';
import 'package:blablabla/service/locations_service.dart';

void main() {
  LocationsService.initialize(MockLocationsRepository());

  assert(
    LocationsService.instance.repository.getLocations().toString() ==
        '[Phnom Penh, Siem Reap, Battambang, Sihanoukville, Kampot]',
  );
}
