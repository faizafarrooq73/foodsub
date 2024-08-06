import 'package:food_sub/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:food_sub/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:food_sub/ui/views/home/home_view.dart';
import 'package:food_sub/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:food_sub/services/fire_service.dart';
import 'package:food_sub/services/sharedpref_service.dart';
import 'package:food_sub/ui/views/loginsignup/loginsignup_view.dart';
import 'package:food_sub/ui/views/provider/provider_view.dart';
import 'package:food_sub/ui/views/rider/rider_view.dart';
import 'package:food_sub/ui/views/riderprovider/riderprovider_view.dart';
import 'package:food_sub/ui/views/menuselection/menuselection_view.dart';
import 'package:food_sub/ui/views/booknow/booknow_view.dart';
import 'package:food_sub/ui/views/chat/allchats/allchats_view.dart';
import 'package:food_sub/ui/views/chat/chating/chating_view.dart';
import 'package:food_sub/ui/views/customerspecials/showdeals/showdeals_view.dart';
import 'package:food_sub/ui/views/customerspecials/promotion/showpromotions/showpromotions_view.dart';
import 'package:food_sub/ui/views/customerspecials/promotion/addpromotions/addpromotions_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginsignupView),
    MaterialRoute(page: ProviderView),
    MaterialRoute(page: RiderView),
    MaterialRoute(page: RiderproviderView),
    MaterialRoute(page: MenuselectionView),
    MaterialRoute(page: BooknowView),
    MaterialRoute(page: AllchatsView),
    MaterialRoute(page: ChatingView),
    MaterialRoute(page: ShowdealsView),
    MaterialRoute(page: ShowpromotionsView),
    MaterialRoute(page: AddpromotionsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: FireService),
    LazySingleton(classType: SharedprefService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
