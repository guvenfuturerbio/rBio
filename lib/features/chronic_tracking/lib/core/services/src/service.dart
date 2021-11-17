part of '../service_shaft.dart';

abstract class Service {
  Future<ServiceResponse<R>> request<T extends ServiceNetwork, R>(
    String path, {
    @required T parseModel,
    @required RequestType method,
    String urlSuffix,
    Map<String, dynamic> queryParameters,
    dynamic data,
  });
}
