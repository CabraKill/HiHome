import 'package:flutter/material.dart';

enum HomeState { empty, loading, success, error }

class ValueState<T, K, E> {
  T data;
  K state;
  E? error;
  ValueState(this.data, this.state, [this.error]);

  // call(K state, [T? data]) {
  //   this.state = state;
  //   if (data != null) this.data = data;
  // }

}

class CommomValueState<T, E> extends ValueState<T, HomeState, E> {
  CommomValueState(T value) : super(value, HomeState.empty);

  Widget builder(
      {Widget Function()? onEmpty,
      Widget Function(dynamic)? onError,
      Widget Function()? onLoading,
      Widget Function()? onDone}) {
    return stateChild(state);
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
