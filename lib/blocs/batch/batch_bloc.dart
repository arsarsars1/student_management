// batch_bloc.dart
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studet_managment/models/batch.dart';
import 'package:studet_managment/repositories/batch_repository.dart';

import 'batch_event.dart';
import 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final BatchRepository batchRepository;

  List<Contact> _originalContacts = [];
  Map<String, TimeRange> _selectedTimes = {};
  Map<String, String> _validationErrors = {};

  BatchBloc(this.batchRepository) : super(BatchInitial()) {
    on<LoadBatchesEvent>(_onLoadBatches);
    on<AddBatchEvent>(_onAddBatch);
    on<LoadContacts>(_onLoadContacts);
    on<SelectSchedule>(_onSelectSchedule);
    on<SelectContact>(_onSelectContact);
    on<RemoveContact>(_onRemoveContact);
    on<SearchContacts>(_onSearchContacts);
    on<ClearSelectedContacts>(_onClearSelectedContacts);
    on<ResetSearchContacts>(_onResetSearchContacts);
  }

  Future<void> _onLoadBatches(
      LoadBatchesEvent event, Emitter<BatchState> emit) async {
    emit(BatchLoading());
    try {
      final batches = batchRepository.getBatches();
      emit(BatchLoaded(
        batches: batches,
        contacts: state.contacts,
        selectedContacts: state.selectedContacts,
        selectedTimes: state.selectedTimes,
        validationErrors: state.validationErrors,
      ));
    } catch (e) {
      emit(BatchError(
        message: e.toString(),
        contacts: state.contacts,
        selectedContacts: state.selectedContacts,
        selectedTimes: state.selectedTimes,
        validationErrors: state.validationErrors,
      ));
    }
  }

  Future<void> _onAddBatch(
      AddBatchEvent event, Emitter<BatchState> emit) async {
    emit(BatchLoading());
    await batchRepository.addBatch(event.batch);
    add(LoadBatchesEvent());
  }

  Future<void> _onLoadContacts(
      LoadContacts event, Emitter<BatchState> emit) async {
    if (await Permission.contacts.request().isGranted) {
      if (_originalContacts.isEmpty) {
        emit(ContactInitial());
        final contacts = await ContactsService.getContacts();
        _originalContacts = contacts.toList();
        emit(ContactLoaded(
            contacts: _originalContacts,
            selectedContacts: const [],
            selectedTimes: state.selectedTimes,
            validationErrors: state.validationErrors));
      }
    } else {
      emit(ContactLoaded(
          contacts: [],
          selectedContacts: [],
          selectedTimes: state.selectedTimes,
          validationErrors: state.validationErrors));
    }
  }

  void _onSelectSchedule(SelectSchedule event, Emitter<BatchState> emit) {
    _selectedTimes = event.schedule;
    _validationErrors = event.validationErrors;
    emit(ScheduleTime(
        selectedTimes: _selectedTimes,
        validationErrors: _validationErrors,
        contacts: state.contacts,
        selectedContacts: state.selectedContacts));
  }

  void _onSelectContact(SelectContact event, Emitter<BatchState> emit) {
    if (state is ContactLoaded) {
      final currentState = state as ContactLoaded;
      final updatedSelectedContacts =
          List<Contact>.from(currentState.selectedContacts)..add(event.contact);
      emit(ContactLoaded(
          contacts: currentState.contacts,
          selectedContacts: updatedSelectedContacts,
          selectedTimes: state.selectedTimes,
          validationErrors: state.validationErrors));
    }
  }

  void _onRemoveContact(RemoveContact event, Emitter<BatchState> emit) {
    if (state is ContactLoaded) {
      final currentState = state as ContactLoaded;
      final updatedSelectedContacts =
          List<Contact>.from(currentState.selectedContacts)
            ..remove(event.contact);
      emit(ContactLoaded(
          contacts: currentState.contacts,
          selectedContacts: updatedSelectedContacts,
          selectedTimes: state.selectedTimes,
          validationErrors: state.validationErrors));
    }
  }

  void _onSearchContacts(SearchContacts event, Emitter<BatchState> emit) {
    if (state is ContactLoaded) {
      final currentState = state as ContactLoaded;
      final filteredContacts = currentState.contacts
          .where((contact) =>
              contact.displayName != null &&
              contact.displayName!
                  .toLowerCase()
                  .contains(event.query.toLowerCase()))
          .toList();
      emit(ContactLoaded(
          contacts: filteredContacts,
          selectedContacts: currentState.selectedContacts,
          selectedTimes: state.selectedTimes,
          validationErrors: state.validationErrors));
    }
  }

  void _onResetSearchContacts(
      ResetSearchContacts event, Emitter<BatchState> emit) {
    if (state is ContactLoaded) {
      emit(ContactLoaded(
          contacts: _originalContacts,
          selectedContacts: (state as ContactLoaded).selectedContacts,
          selectedTimes: state.selectedTimes,
          validationErrors: state.validationErrors));
    }
  }

  void _onClearSelectedContacts(
      ClearSelectedContacts event, Emitter<BatchState> emit) {
    if (_originalContacts.isNotEmpty) {
      emit(ContactLoaded(
          contacts: _originalContacts,
          selectedContacts: const [],
          selectedTimes: state.selectedTimes,
          validationErrors: state.validationErrors));
    }
  }
}
