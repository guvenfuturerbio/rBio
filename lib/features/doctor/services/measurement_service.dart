import 'package:flutter/material.dart';

import '../../../model/model.dart';
import '../resources/resources.dart';

class MeasurementService {
  Color fetchMeasurementColor(
      {@required int measurement,
      @required int criticMin,
      @required int criticMax,
      @required int targetMax,
      @required int targetMin}) {
    Color color;
    if (measurement <= criticMin) {
      color = R.color.veryLow;
    } else if (measurement > criticMin && measurement < targetMin) {
      color = R.color.low;
    } else if (measurement >= targetMin && measurement <= targetMax) {
      color = R.color.target;
    } else if (measurement > targetMax && measurement < criticMax) {
      color = R.color.high;
    } else if (measurement >= criticMax) {
      color = R.color.veryHigh;
    } else {
      color = Colors.white;
    }
    return color;
  }

  final measurements = [
    new BgMeasurement(date: "2020-12-16T09:12:00+03:00", result: "150", tag: 1),
    new BgMeasurement(date: "2020-12-16T10:33:00+03:00", result: "105", tag: 2),
    new BgMeasurement(date: "2020-12-16T12:23:00+03:00", result: "74", tag: 1),
    new BgMeasurement(date: "2020-12-16T13:33:00+03:00", result: "190", tag: 2),
    new BgMeasurement(date: "2020-12-16T19:33:00+03:00", result: "65", tag: 1),
    new BgMeasurement(date: "2020-12-16T20:33:00+03:00", result: "123", tag: 2),
    new BgMeasurement(date: "2020-12-15T06:33:00+03:00", result: "47", tag: 1),
    new BgMeasurement(date: "2020-12-15T08:33:00+03:00", result: "120", tag: 2),
    new BgMeasurement(date: "2020-12-15T12:33:00+03:00", result: "74", tag: 1),
    new BgMeasurement(date: "2020-12-15T16:33:00+03:00", result: "135", tag: 2),
    new BgMeasurement(date: "2020-12-15T22:33:00+03:00", result: "55", tag: 1),
    new BgMeasurement(date: "2020-12-14T07:33:00+03:00", result: "55", tag: 1),
    new BgMeasurement(date: "2020-12-14T10:33:00+03:00", result: "50", tag: 1),
    new BgMeasurement(date: "2020-12-14T12:33:00+03:00", result: "180", tag: 2),
    new BgMeasurement(date: "2020-12-14T16:33:00+03:00", result: "96", tag: 1),
    new BgMeasurement(date: "2020-12-14T02:33:00+03:00", result: "47", tag: 1),
    new BgMeasurement(date: "2020-12-14T07:33:00+03:00", result: "55", tag: 3),
    new BgMeasurement(date: "2020-12-14T09:33:00+03:00", result: "130", tag: 2),
    new BgMeasurement(date: "2020-12-14T12:33:00+03:00", result: "68", tag: 1),
    new BgMeasurement(date: "2020-12-14T16:33:00+03:00", result: "52", tag: 1),
    new BgMeasurement(date: "2020-12-14T02:33:00+03:00", result: "32", tag: 1),
    new BgMeasurement(date: "2020-10-27T08:33:00+03:00", result: "47", tag: 3),
    new BgMeasurement(date: "2020-10-28T12:05:00+03:00", result: "66", tag: 1),
    new BgMeasurement(date: "2020-10-29T12:05:00+03:00", result: "226", tag: 2),
    new BgMeasurement(date: "2020-10-30T12:05:00+03:00", result: "180", tag: 1),
    new BgMeasurement(date: "2020-10-31T12:05:00+03:00", result: "126", tag: 3),
    new BgMeasurement(date: "2020-11-01T08:33:00+03:00", result: "187", tag: 2),
    new BgMeasurement(date: "2020-11-02T12:05:00+03:00", result: "76", tag: 1),
    new BgMeasurement(date: "2020-11-03T08:33:00+03:00", result: "17", tag: 1),
    new BgMeasurement(date: "2020-11-04T12:05:00+03:00", result: "36", tag: 3),
    new BgMeasurement(date: "2020-11-05T08:33:00+03:00", result: "57", tag: 2),
    new BgMeasurement(date: "2020-11-06T12:05:00+03:00", result: "66", tag: 1),
    new BgMeasurement(date: "2020-11-07T08:33:00+03:00", result: "97", tag: 2),
    new BgMeasurement(date: "2020-11-08T12:05:00+03:00", result: "17", tag: 2),
    new BgMeasurement(date: "2020-11-09T08:33:00+03:00", result: "127", tag: 1),
    new BgMeasurement(date: "2020-11-10T12:05:00+03:00", result: "116", tag: 3),
    new BgMeasurement(date: "2020-11-11T08:33:00+03:00", result: "87", tag: 1),
    new BgMeasurement(date: "2020-11-12T12:05:00+03:00", result: "24", tag: 1),
    new BgMeasurement(date: "2020-11-13T08:33:00+03:00", result: "54", tag: 2),
    new BgMeasurement(date: "2020-11-14T12:05:00+03:00", result: "132", tag: 1),
    new BgMeasurement(date: "2020-11-15T08:33:00+03:00", result: "123", tag: 2),
    new BgMeasurement(date: "2020-11-16T12:05:00+03:00", result: "96", tag: 1),
    new BgMeasurement(date: "2020-11-16T19:15:00+03:00", result: "112", tag: 2),
    new BgMeasurement(date: "2020-11-17T09:14:00+03:00", result: "101", tag: 3),
    new BgMeasurement(date: "2020-11-17T13:38:00+03:00", result: "134", tag: 2),
    new BgMeasurement(date: "2020-11-17T20:33:00+03:00", result: "98", tag: 1),
    new BgMeasurement(date: "2020-11-18T06:15:00+03:00", result: "82", tag: 1),
    new BgMeasurement(date: "2020-11-18T11:23:00+03:00", result: "97", tag: 1),
    new BgMeasurement(date: "2020-11-18T17:43:00+03:00", result: "121", tag: 2),
    new BgMeasurement(date: "2020-11-19T08:21:00+03:00", result: "60", tag: 1),
    new BgMeasurement(date: "2020-11-19T12:33:00+03:00", result: "98", tag: 2),
    new BgMeasurement(date: "2020-11-19T18:43:00+03:00", result: "45", tag: 2),
    new BgMeasurement(date: "2020-11-20T08:02:00+03:00", result: "56", tag: 2),
    new BgMeasurement(date: "2020-11-20T10:21:00+03:00", result: "93", tag: 1),
    new BgMeasurement(date: "2020-11-20T16:56:00+03:00", result: "123", tag: 2),
    new BgMeasurement(date: "2020-11-21T08:02:00+03:00", result: "121", tag: 1),
    new BgMeasurement(date: "2020-11-21T11:33:00+03:00", result: "103", tag: 3),
    new BgMeasurement(date: "2020-11-21T15:45:00+03:00", result: "156", tag: 3),
    new BgMeasurement(date: "2020-11-22T08:02:00+03:00", result: "87", tag: 2),
    new BgMeasurement(date: "2020-11-22T10:32:00+03:00", result: "113", tag: 1),
    new BgMeasurement(date: "2020-11-22T14:58:00+03:00", result: "148", tag: 2),
    new BgMeasurement(date: "2020-11-22T21:12:00+03:00", result: "45", tag: 1),
    new BgMeasurement(date: "2020-11-23T08:12:00+03:00", result: "32", tag: 1),
    new BgMeasurement(date: "2020-11-23T11:32:00+03:00", result: "45", tag: 2),
    new BgMeasurement(date: "2020-11-23T16:23:00+03:00", result: "87", tag: 1),
    new BgMeasurement(date: "2020-11-23T23:56:00+03:00", result: "187", tag: 2),
    new BgMeasurement(date: "2020-11-24T11:32:00+03:00", result: "25", tag: 1),
    new BgMeasurement(date: "2020-11-25T16:23:00+03:00", result: "127", tag: 3),
    new BgMeasurement(date: "2020-11-26T23:56:00+03:00", result: "137", tag: 2),
    new BgMeasurement(date: "2020-11-27T09:32:00+03:00", result: "45", tag: 1),
    new BgMeasurement(date: "2020-11-27T13:23:00+03:00", result: "87", tag: 2),
    new BgMeasurement(date: "2020-11-27T23:56:00+03:00", result: "187", tag: 3),
    new BgMeasurement(date: "2020-11-28T09:32:00+03:00", result: "75", tag: 3),
    new BgMeasurement(date: "2020-11-29T13:23:00+03:00", result: "132", tag: 2),
    new BgMeasurement(date: "2020-11-30T23:56:00+03:00", result: "127", tag: 2),
    new BgMeasurement(date: "2020-12-01T09:32:00+03:00", result: "136", tag: 2),
    new BgMeasurement(date: "2020-12-02T13:23:00+03:00", result: "123", tag: 3),
    new BgMeasurement(date: "2020-12-03T13:23:00+03:00", result: "243", tag: 1),
    new BgMeasurement(date: "2020-12-04T23:56:00+03:00", result: "167", tag: 2),
    new BgMeasurement(date: "2020-12-08T13:23:00+03:00", result: "56", tag: 3),
    new BgMeasurement(date: "2020-12-08T13:23:00+03:00", result: "56", tag: 1),
    new BgMeasurement(date: "2020-12-08T13:23:00+03:00", result: "56", tag: 2),
    new BgMeasurement(date: "2020-12-10T09:32:00+03:00", result: "94", tag: 1),
    new BgMeasurement(date: "2020-12-15T09:32:00+03:00", result: "87", tag: 1),
    new BgMeasurement(date: "2020-09-27T09:32:00+03:00", result: "25", tag: 3),
    new BgMeasurement(date: "2020-09-01T13:23:00+03:00", result: "67", tag: 2),
    new BgMeasurement(date: "2020-09-13T23:56:00+03:00", result: "107", tag: 1)
  ];
}
