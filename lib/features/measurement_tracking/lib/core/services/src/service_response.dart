part of '../service_shaft.dart';

abstract class ServiceResponse<T> {
  T data;
  ServiceError error;

  ServiceResponse(this.data, this.error);
}
