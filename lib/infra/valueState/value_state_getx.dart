import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hihome/infra/valueState/value_state.dart';

class CommomValueStateBaseGetX<T, E>
    extends ValueState<T, Rx<CommomState>, Rx<E>> {
  CommomValueStateBaseGetX(T value) : super(value, CommomState.empty.obs);

  CommomState get stateValue => state.value;

  //TODO: Add obx reactivity function type
  Widget builder({
    Widget Function()? onEmpty,
    Widget Function(dynamic)? onError,
    Widget Function()? onLoading,
    Widget Function(T data)? onSuccess,
  }) {
    return stateChild(
      state.value,
      onEmpty: onEmpty,
      onError: onError,
      onLoading: onLoading,
      onSuccess: onSuccess,
    );
  }

  Widget stateChild(
    CommomState state, {
    Widget Function()? onEmpty,
    Widget Function(dynamic)? onError,
    Widget Function()? onLoading,
    Widget Function(T data)? onSuccess,
  }) {
    switch (state) {
      case CommomState.empty:
        return onEmpty != null ? onEmpty() : const SizedBox.shrink();
      case CommomState.error:
        return onError != null ? onError(error) : Text(error.toString());
      case CommomState.loading:
        return onLoading != null
            ? onLoading()
            : const Center(child: CircularProgressIndicator());
      default:
        return onSuccess != null ? onSuccess(data) : const Icon(Icons.check);
    }
  }
}

class ValueCommomStateGetX<T, E> extends CommomValueStateBaseGetX<Rx<T>, E> {
  ValueCommomStateGetX(T value) : super(value.obs);

  T get value => data.value;

  call(CommomState state, {T? data, E? error}) {
    assert(
      data == null || error == null,
      "You can't provide both data and error",
    );
    if (state == CommomState.error && error != null) {
      if (this.error == null) {
        this.error = Rx(error);
      } else {
        this.error!.value = error;
      }
    } else {
      this.error = null;
    }
    this.state.value = state;
    if (data != null) this.data.value = data;
  }
}

class ValueCommomStateListGetX<T, E>
    extends CommomValueStateBaseGetX<RxList<T>, E?> {
  ValueCommomStateListGetX(List<T> value) : super(value.obs);

  List<T> get value => data;

  call(CommomState state, {List<T>? data, E? error}) {
    assert(
      data == null || error == null,
      "You can't provide both data and error",
    );
    if (state == CommomState.error && error != null) {
      if (this.error == null) {
        this.error = Rx(error);
      } else {
        this.error!.value = error;
      }
    } else {
      this.error = null;
    }
    this.state.value = state;
    if (data != null) this.data.value = data;
  }
}
