import 'package:flutter/material.dart';
import 'package:onedosehealth/core/data/repository/repository.dart';
import 'package:onedosehealth/core/enums/loading_progress.dart';
import 'package:onedosehealth/core/extension/string_extension.dart';
import 'package:onedosehealth/core/locator.dart';
import 'package:onedosehealth/core/manager/user_manager.dart';
import 'package:onedosehealth/core/utils/logger_helper.dart';
import 'package:onedosehealth/core/widgets/loading_dialog.dart';
import 'package:onedosehealth/core/widgets/warning_dialog.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/model.dart';

class SearchScreenVm extends ChangeNotifier {
  BuildContext mContext;

  LoadingProgress? progress;
  LoadingDialog? loadingDialog;

  String searchText = "";
  List<String> filterTitleList = [];
  List<FilterResourcesResponse> filterResources = [];
  List<SocialPostsResponse> allSocialResources = [];
  List<SocialPostsResponse> filteredSocialResources = [];

  List names = [];

  SearchScreenVm(this.mContext) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await fetchAllPosts();
    });
  }

  Future<void> toggleFilter(String filterTitle) async {
    searchText = "";
    allSocialResources.clear();
    notifyListeners();
    if (filterTitleList.contains(filterTitle)) {
      filterTitleList.remove(filterTitle);
    } else {
      filterTitleList.add(filterTitle);
    }
    if (filterTitleList.isNotEmpty) {
      for (var item in filterTitleList) {
        if (item == 'Doctor') {
          fetchResources("   ");
        } else {
          progress = LoadingProgress.loading;
          notifyListeners();
          try {
            var tmpList =
                await getIt<UserManager>().getPostsWithByTagsByPlatform(item);
            allSocialResources.addAll(tmpList);
            progress = LoadingProgress.done;
            notifyListeners();
          } catch (error) {
            LoggerUtils.instance.e(error);
            progress = LoadingProgress.error;
            notifyListeners();
            showGradientDialog(mContext, LocaleProvider.current.warning,
                LocaleProvider.current.sorry_dont_transaction);
          }
        }
      }
    } else {
      await fetchAllPosts();
    }
    notifyListeners();
  }

  Future<void> setSearchText(String text) async {
    try {
      progress = LoadingProgress.loading;
      notifyListeners();
      searchText = text;
      await fetchResources(text);
      await fetchPostsByText(text);
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (error) {
      LoggerUtils.instance.e(error);
      progress = LoadingProgress.error;
      notifyListeners();
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
    }
  }

  Future<void> fetchResources(String text) async {
    if ((text.length) >= 3) {
      text = text.xTurkishCharacterToEnglish;
      await Future.delayed(const Duration(milliseconds: 300));
      try {
        filterResources = await getIt<Repository>().filterResources(
          FilterResourcesRequest(
            tenantId: null,
            departmentId: null,
            search: text,
            appointmentType: null,
          ),
        );
      } catch (e) {
        rethrow;
      }
    } else {
      filterResources.clear();
    }
  }

  Future<void> fetchPostsByText(String text) async {
    if ((text.length) >= 3) {
      text = text.xTurkishCharacterToEnglish;

      try {
        filteredSocialResources =
            await getIt<UserManager>().getSocialPostWithTagsByText(text);
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> fetchAllPosts() async {
    progress = LoadingProgress.loading;
    notifyListeners();

    try {
      allSocialResources = await getIt<UserManager>().getAllSocialResources();
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (error) {
      LoggerUtils.instance.e(error);
      progress = LoadingProgress.error;
      notifyListeners();
      showGradientDialog(
        mContext,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
    }
  }

  Future<void> clickPost(int postId, String url) async {
    getIt<UserManager>().clickPost(postId);
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          loadingDialog = loadingDialog ?? LoadingDialog(),
    );
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null) {
      if (loadingDialog!.isShowing()) {
        Navigator.of(context).pop();
        loadingDialog = null;
      }
    }
  }
}
