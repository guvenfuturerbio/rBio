import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';

class SearchScreenVm extends ChangeNotifier {
  List<FilterResourcesResponse> _filterResources;
  LoadingProgress _progress;
  BuildContext mContext;
  String _searchText;

  List<SocialPostsResponse> _allSocialResources;
  List<SocialPostsResponse> _filteredSocialResources;
  LoadingProgress _socialPostProgress;
  LoadingDialog loadingDialog;
  bool fromOnlineAppo;
  String _token = "";
  List _names = new List();

  SearchScreenVm({BuildContext context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAllPosts();
    });
    this.mContext = context;
  }

  List<FilterResourcesResponse> get filterResources =>
      this._filterResources ?? [];

  LoadingProgress get progress => this._progress;

  String get searchText => this._searchText ?? "";

  List<SocialPostsResponse> get allSocialResources =>
      this._allSocialResources ?? [];

  List<SocialPostsResponse> get filteredSocialResources =>
      this._filteredSocialResources ?? [];

  String get token => this._token;

  LoadingProgress get socialPostProgress => this._socialPostProgress;

  List get names => this._names;

  Future<void> setSearchText(String text) async {
    try {
      this._progress = LoadingProgress.LOADING;
      notifyListeners();
      this._searchText = text;
      await fetchResources(text);
      await fetchPostsByText(text);
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      print(e);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
    }
  }

  Future<void> fetchResources(String text) async {
    if ((text?.length ?? 0) >= 3) {
      await Future.delayed(Duration(milliseconds: 300));
      try {
        this._filterResources = await getIt<Repository>().filterResources(
            FilterResourcesRequest(
                tenantId: null, departmentId: null, search: text));
      } catch (e) {
        rethrow;
      }
    } else {
      this._filterResources?.clear();
    }
  }

  Future<void> fetchPostsByText(String text) async {
    if ((text?.length ?? 0) >= 3) {
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
    } catch (e) {
      print(e);
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

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(title, text);
        });
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
