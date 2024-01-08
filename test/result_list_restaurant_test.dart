import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';

import 'result_list_restaurant_test.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  test('returns a list of restaurants with correct data', () async {
    final client = MockClient();
    when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
        .thenAnswer((_) async => http.Response(
            '{"error": false, "message": "success", "count":20, "restaurants":[]}', 200));

    expect(await ApiService().resultListRestaurant(client),
        isA<RestaurantList>());
  });
}
