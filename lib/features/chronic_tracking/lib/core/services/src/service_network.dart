part of '../service_shaft.dart';

abstract class ServiceNetwork<T> {
  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
}
