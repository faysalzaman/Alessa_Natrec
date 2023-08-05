import 'package:alessa_v2/models/GetPickingListModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'picking_slip_states_events.dart';

class PickingSlipBloc extends Bloc<PickingSlipEvent, PickingSlipState> {
  PickingSlipBloc() : super(PickingSlipInit()) {
    List<GetPickingListModel> pickingList = [];
    on<PickingSlipOnChangedEvent>((event, emit) {
      emit(PickingSlipLoading());
      pickingList = event.pickingList;
      emit(PickingSlipSuccess(pickingList));
    });
  }
}
