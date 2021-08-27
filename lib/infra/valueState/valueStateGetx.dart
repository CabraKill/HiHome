import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/infra/valueState/valueState.dart';

class CommomValueStateBaseGetX<T, E> extends ValueState<T, Rx<HomeState>, E> {
  CommomValueStateBaseGetX(T value) : super(value, HomeState.empty.obs);

  Widget builder(
      {Widget Function()? onEmpty,
      Widget Function(dynamic)? onError,
      Widget Function()? onLoading,
      Widget Function()? onSuccess}) {
    return stateChild(state.value,
        onEmpty: onEmpty,
        onError: onError,
        onLoading: onLoading,
        onSuccess: onSuccess);
  }

  Widget stateChild(HomeState state,
      {Widget Function()? onEmpty,
      Widget Function(dynamic)? onError,
      Widget Function()? onLoading,
      Widget Function()? onSuccess}) {
    switch (state) {
      case HomeState.empty:
        return onEmpty != null ? onEmpty() : SizedBox.shrink();
      case HomeState.error:
        return onError != null ? onError(error) : Text(error.toString());
      case HomeState.loading:
        return onLoading != null
            ? onLoading()
            : Center(child: CircularProgressIndicator());
      default:
        return onSuccess != null ? onSuccess() : Icon(Icons.check);
    }
  }
}

class ValueCommomStateGetX<T extends Rx, E>
    extends CommomValueStateBaseGetX<T, Rx<E?>> {
  ValueCommomStateGetX(value) : super(value);

  call(HomeState state, [data]) {
    if (state != HomeState.error && error?.value != null) error?.value = null;
    this.state.value = state;
    if (data != null) this.data.value = data.value;
  }
}

class ValueCommomStateListGetX<T, E>
    extends CommomValueStateBaseGetX<RxList<T>, Rx<E?>> {
  ValueCommomStateListGetX(RxList<T> value) : super(value);

  call(HomeState state, [RxList<T>? data]) {
    if (state != HomeState.error && error?.value != null) error?.value = null;
    this.state.value = state;
    if (data != null) this.data = data;
  }
}
