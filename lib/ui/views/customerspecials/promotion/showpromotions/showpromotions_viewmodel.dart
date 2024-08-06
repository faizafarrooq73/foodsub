import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:food_sub/ui/common/uihelper/snakbar_helper.dart';
import 'package:stacked/stacked.dart';

class ShowpromotionsViewModel extends BaseViewModel {
  Future<void> copy(BuildContext context, String code) async {
    ClipboardData data = ClipboardData(text: code);
    await Clipboard.setData(data);
    show_snackbar(context, "Code Copied to Clipboard");
  }
}
