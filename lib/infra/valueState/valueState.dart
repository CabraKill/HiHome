import 'package:flutter/material.dart';

enum CommomState { empty, loading, success, error }

class ValueState<T, K, E> {
  T data;
  K state;
  E? error;
  ValueState(this.data, this.state, [this.error]);
}

class CommomValueState<T, E> extends ValueState<T, CommomState, E> {
  CommomValueState(T value) : super(value, CommomState.empty);

  Widget builder(
      {Widget Function()? onEmpty,
      Widget Function(dynamic)? onError,
      Widget Function()? onLoading,
      Widget Function()? onDone}) {
    return stateChild(state);
  }

  Widget stateChild(CommomState state,
      {Widget Function()? onEmpty,
      Widget Function(dynamic)? onError,
      Widget Function()? onLoading,
      Widget Function()? onSuccess}) {
    switch (state) {
      case CommomState.empty:
        return onEmpty != null ? onEmpty() : SizedBox.shrink();
      case CommomState.error:
        return onError != null ? onError(error) : Text(error.toString());
      case CommomState.loading:
        return onLoading != null
            ? onLoading()
            : Center(child: CircularProgressIndicator());
      default:
        return onSuccess != null ? onSuccess() : Icon(Icons.check);
    }
  }
}
