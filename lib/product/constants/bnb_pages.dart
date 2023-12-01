import 'package:bootcamp_project/product/feature/cafe/cafe_view.dart';
import 'package:bootcamp_project/product/feature/cinema/cinema_view.dart';
import 'package:bootcamp_project/product/feature/restaurant/restaurant_view.dart';

class NavigationPages {
  static final pages = [
    RestaurantView(),
    const CinemaView(),
    const CafeView(),
  ];
}
