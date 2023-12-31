import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:king_movie/core/constants/singleton_class.dart';
import 'package:king_movie/core/services/home_service.dart' as service;
import 'package:king_movie/core/services/search_service.dart';
import 'package:king_movie/models/home_model.dart';
import 'package:king_movie/models/search_model.dart';
import 'package:king_movie/models/table_model.dart';
import 'package:king_movie/views/movie_detail/screens/movie_detail_screen.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';

class HomeViewModel extends GetxController with StateMixin {
  HomeModel? homeModel;
  TableModel? tableModel;

  String searchValue = '';

  late final List<Jalali> daysList = getDaysOfCurrentWeek();

  RxInt tableSelectedIndex = 0.obs;

  final GetStorage getStorage = GetStorage();
  String token = '';

  int newTabIndex = 0;
  int newDubTabIndex = 0;

  @override
  void onInit() async {
    super.onInit();
    await GetStorage.init();

    tableSelectedIndex.listen((index) async {
      await updateTable(index);
    });

    await getData();
    await updateTable(0);
  }

  Future<void> getData() async {
    token = getStorage.read('token') ?? '';
    print(token);
    final request = await service.homeService(token);
    if (request.statusCode == 200) {
      homeModel = HomeModel.fromJson(request.body);
      SingletonClass.instance.user = homeModel?.user;
      change(null, status: RxStatus.success());
    }
  }

  List<Jalali> getDaysOfCurrentWeek() {
    final now = DateTime.now();
    final currentWeekday = now.toJalali().weekDay;

    // First day of the week
    final firstDay = now.subtract(Duration(days: currentWeekday - 1));

    // Last day of the week
    final lastDay =
        now.add(Duration(days: DateTime.daysPerWeek - currentWeekday));

    // List of each day as DateTime
    return List.generate(lastDay.difference(firstDay).inDays + 1,
        (index) => firstDay.add(Duration(days: index)).toJalali());
  }

  Future<SearchModel?> search(String text) async {
    final request = await simpleSearch(searchText: text, page: 1);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      return SearchModel.fromJson(request.body);
    }
    return null;
  }

  Future<TableModel?> getTable(String date) async {
    final request = await service.tableService(date: date);
    if (request.statusCode == 200 && request.body['error'] == 'false') {
      return TableModel.fromJson(request.body);
    }
    return null;
  }

  Future<void> updateTable(int index) async {
    tableModel = await getTable(daysList[index].toDateTime().toPersianDate());
    update(['table']);
  }

  Future<void> seenAlert() async {
    Get.back();
    // change(null, status: RxStatus.loading());
    await service.seenAlert(token: token);
    homeModel?.data?.alert = [];
    change(null, status: RxStatus.success());
  }

  void onAlaramTap(int index) => Get.to(() => MovieDetailScreen(
      movieId: homeModel?.data?.alert?[index].link?.split('/').first ?? ''));

  Future<void> seenAlarms() => service.seenAlert(token: token);
}
