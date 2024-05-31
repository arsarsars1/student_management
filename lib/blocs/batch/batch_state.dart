// batch_state.dart
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:studet_managment/models/batch.dart';

abstract class BatchState extends Equatable {
  final List<Contact> contacts;
  final List<Contact> selectedContacts;
  final Map<String, TimeRange> selectedTimes;
  final Map<String, String> validationErrors;

  const BatchState({
    this.contacts = const [],
    this.selectedContacts = const [],
    this.selectedTimes = const {},
    this.validationErrors = const {},
  });

  @override
  List<Object> get props => [
        contacts,
        selectedContacts,
        selectedTimes,
        validationErrors,
      ];
}

class BatchInitial extends BatchState {}

class BatchLoading extends BatchState {}

class BatchLoaded extends BatchState {
  final List<Batch> batches;

  const BatchLoaded({
    required this.batches,
    super.contacts,
    super.selectedContacts,
    super.selectedTimes,
    super.validationErrors,
  });

  @override
  List<Object> get props => [
        batches,
        contacts,
        selectedContacts,
        selectedTimes,
        validationErrors,
      ];
}

class BatchError extends BatchState {
  final String message;

  const BatchError({
    required this.message,
    super.contacts,
    super.selectedContacts,
    super.selectedTimes,
    super.validationErrors,
  });

  @override
  List<Object> get props => [
        message,
        contacts,
        selectedContacts,
        selectedTimes,
        validationErrors,
      ];
}

class ContactInitial extends BatchState {}

class ContactLoaded extends BatchState {
  const ContactLoaded({
    required super.contacts,
    required super.selectedContacts,
    super.selectedTimes,
    super.validationErrors,
  });
}

class ScheduleTime extends BatchState {
  const ScheduleTime({
    required super.selectedTimes,
    required super.validationErrors,
    super.contacts,
    super.selectedContacts,
  });
}
