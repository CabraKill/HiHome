import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum HomeState { none, loading, success, error }

class ValueState<T, K> {
  T data;
  K state;
  ValueState(this.data, this.state);

  // call(K state, [T? data]) {
  //   this.state = state;
  //   if (data != null) this.data = data;
  // }
}

class ValueCommomState<T> extends ValueState<T, HomeState> {
  ValueCommomState(T value) : super(value, HomeState.none);

  Widget builder(
      {Widget Function(dynamic)? onError, Widget Function()? onDone}) {
    switch (state) {
      case HomeState.error:
        //TODO: fix OnError
        return onError != null ? onError("aaa") : Text("error has occured");
      case HomeState.success:
        return onDone != null ? onDone() : Text("Success");
      //TODO: add none
      //TODO: add
      default:
        return Text("");
    }
  }
}

class ValueCommomStateGetX<T> extends ValueState<dynamic, Rx<HomeState>> {
  ValueCommomStateGetX(value) : super(value, HomeState.none.obs);

  Widget builder(
      {Widget Function(dynamic)? onError, Widget Function()? onDone}) {
    switch (state.value) {
      case HomeState.error:
        return onError != null ? onError("aaa") : Text("error has occured");
      case HomeState.success:
        return onDone != null ? onDone() : Text("Success");
      default:
        return Text("a");
    }
  }

  call(HomeState state, [data]) {
    this.state.value = state;
    if (data != null) this.data.value = data.value;
  }
}

class ValueCommomStateListGetX<T> extends ValueState<RxList<T>, Rx<HomeState>> {
  ValueCommomStateListGetX(RxList<T> value) : super(value, HomeState.none.obs);

  Widget builder(
      {Widget Function(dynamic)? onError, Widget Function()? onDone}) {
    switch (state.value) {
      case HomeState.error:
        return onError != null ? onError("aaa") : Text("error has occured");
      case HomeState.success:
        return onDone != null ? onDone() : Text("Success");
      default:
        return Text("a");
    }
  }

  call(HomeState state, [RxList<T>? data]) {
    this.state.value = state;
    if (data != null) this.data = data;
  }
}
