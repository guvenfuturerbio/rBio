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
  List<FilterResourcesResponse> _filterResources;
  LoadingProgress _progress;
  BuildContext mContext;
  String _searchText;
  List<SocialPostsResponse> _allSocialResources;
  List<SocialPostsResponse> _filteredSocialResources;
  List<String> _filterTitleList = [];
  LoadingProgress _socialPostProgress;
  LoadingDialog loadingDialog;
  bool fromOnlineAppo;
  String _token = "";

  List _names = [];

  SearchScreenVm({BuildContext context}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAllPosts();
    });
  }

  List<FilterResourcesResponse> get filterResources =>
      this._filterResources ?? [];

  LoadingProgress get progress => this._progress;

  String get searchText => this._searchText ?? "";

  List<SocialPostsResponse> get allSocialResources =>
      this._allSocialResources ?? [];

  List<SocialPostsResponse> get filteredSocialResources =>
      this._filteredSocialResources ?? [];

  List<String> get filterTitleList => this._filterTitleList ?? [];

  String get token => this._token;

  LoadingProgress get socialPostProgress => this._socialPostProgress;

  List get names => this._names;

  Future<void> toggleFilter(String filterTitle) async {
    _searchText = "";
    _allSocialResources.clear();
    notifyListeners();
    if (_filterTitleList.contains(filterTitle)) {
      _filterTitleList.remove(filterTitle);
    } else {
      _filterTitleList.add(filterTitle);
    }
    if (_filterTitleList.length != 0) {
      for (var item in _filterTitleList) {
        if (item == 'Doctor') {
          fetchResources("   ");
        } else {
          this._progress = LoadingProgress.LOADING;
          notifyListeners();
          try {
            var tmpList =
                await getIt<UserManager>().getPostsWithByTagsByPlatform(item);
            this._allSocialResources.addAll(tmpList);
            this._progress = LoadingProgress.DONE;
            notifyListeners();
          } catch (error) {
            LoggerUtils.instance.e(error);
            this._progress = LoadingProgress.ERROR;
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
      this._progress = LoadingProgress.LOADING;
      notifyListeners();
      this._searchText = text;
      await fetchResources(text);
      await fetchPostsByText(text);
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (error) {
      LoggerUtils.instance.e(error);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
    }
  }

  Future<void> fetchResources(String text) async {
    if ((text?.length ?? 0) >= 3) {
      text = text.xTurkishCharacterToEnglish;
      await Future.delayed(Duration(milliseconds: 300));
      try {
        this._filterResources = await getIt<Repository>().filterResources(
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
      this._filterResources?.clear();
    }
  }

  Future<void> fetchPostsByText(String text) async {
    if ((text?.length ?? 0) >= 3) {
      text = text.xTurkishCharacterToEnglish;

      try {
        this._filteredSocialResources =
            await getIt<UserManager>().getSocialPostWithTagsByText(text);
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> fetchAllPosts() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();

    try {
      this._allSocialResources =
          await getIt<UserManager>().getAllSocialResources();
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (error) {
      LoggerUtils.instance.e(error);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
    }
  }

  Future<void> clickPost(int postId, String url) async {
    getIt<UserManager>().clickPost(postId);
    await canLaunch(url) ? await launch(url) : throw 'Could not launch ${url}';
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
            loadingDialog = loadingDialog ?? LoadingDialog());
    //builder: (BuildContext context) => WillPopScope(child:loadingDialog = LoadingDialog() , onWillPop:  () async => false,));
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
}
