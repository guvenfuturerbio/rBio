part of '../../abstract/app_config.dart';

class GuvenPackageEndpoints extends PackageEndpoints {
  @override
  String getAllPackagePath = '/Package/get-all'.xBaseUrl;

  @override
  String getAllSubCategoriesPath(int id) =>
      '/Package/get-all-sub-categories/$id'.xBaseUrl;

  @override
  String getSubCategoryDetailPath(id) =>
      '/Package/get-all-sub-category-pages/$id'.xBaseUrl;

  @override
  String getSubCategoryItemsPath(id) =>
      '/Package/get-all-sub-category-items/$id'.xBaseUrl;

  @override
  String doPackagePaymentPath =
      '/Package/do-mobile-payment-without-firebase'.xBaseUrl;
}
