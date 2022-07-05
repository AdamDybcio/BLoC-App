import 'dart:async';

import 'package:bloc_app/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription? streamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetInitial()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    streamSubscription =
        connectivity.onConnectivityChanged.listen((connection) {
      if (connection == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connection == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (connection == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    streamSubscription!.cancel();
    return super.close();
  }
}
