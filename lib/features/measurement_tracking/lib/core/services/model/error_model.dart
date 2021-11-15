part of '../service_shaft.dart';

class ErrorModel<T> implements ServiceError {
  @override
  int statusCode;

  @override
  String description;

  ErrorModel({this.statusCode, this.description});

  @override
  ServiceNetwork model;
}
