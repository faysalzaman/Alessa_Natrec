part of 'picking_slip_bloc.dart';

// Events
class PickingSlipEvent {}

class PickingSlipOnChangedEvent extends PickingSlipEvent {
  final List<GetPickingListModel> pickingList;
  PickingSlipOnChangedEvent(this.pickingList);
}

// States
class PickingSlipState {}

class PickingSlipInit extends PickingSlipState {}

class PickingSlipLoading extends PickingSlipState {}

class PickingSlipSuccess extends PickingSlipState {
  final List<GetPickingListModel> pickingList;
  PickingSlipSuccess(this.pickingList);
}
