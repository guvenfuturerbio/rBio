part of '../omron.dart';

class OmronConstants {
  OmronConstants._();
  static OmronConstants? _instance;

  static OmronConstants get instance {
    _instance ??= OmronConstants._();
    return _instance!;
  }

  final _$ChannelConst channel = _$ChannelConst();
  final _$ConnState connState = _$ConnState();
  final _$KeyConst keyConst = _$KeyConst();
}
