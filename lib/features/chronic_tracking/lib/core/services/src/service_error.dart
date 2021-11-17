part of '../service_shaft.dart';

abstract class ServiceError<T> {
  int statusCode;
  String description;
  ServiceNetwork model;
}
