import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/infra/valueState/valueState.dart';

class CommomValueStateBaseGetX<T, E>
    extends ValueState<T, Rx<HomeState>, Rx<E>> {
  CommomValueStateBaseGetX(T value) : super(value, HomeState.empty.obs);

  //TODO: Add obx reactivity function type
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

  callFunction(state, {data, error}) {
    assert(
        data == null || error == null, "You can't provide both data and error");
    if (state == HomeState.error && error != null) {
      if (this.error == null)
        this.error = Rx(error);
      else
        this.error!.value = error;
    } else
      this.error = null;
    this.state.value = state;
    if (data != null) this.data = data.value;
  }
}

class ValueCommomStateGetX<T, E> extends CommomValueStateBaseGetX<Rx<T>, E> {
  ValueCommomStateGetX(T value) : super(value.obs);

  call(HomeState state, {T? data, E? error}) =>
      callFunction(state, data: data, error: error);
}

class ValueCommomStateListGetX<T, E>
    extends CommomValueStateBaseGetX<RxList<T>, E?> {
  ValueCommomStateListGetX(List<T> value) : super(value.obs);

  call(HomeState state, {List<T>? data, E? error}) {
    callFunction(state, data: data, error: error);
  }
}
