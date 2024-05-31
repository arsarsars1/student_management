import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:studet_managment/models/batch.dart';

abstract class BatchState extends Equatable {
  final List<Contact> contacts;
  final List<Contact> selectedContacts;

  const BatchState({
    this.contacts = const [],
    this.selectedContacts = const [],
  });

  @override
  List<Object> get props => [
        contacts,
        selectedContacts,
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
  });

  @override
  List<Object> get props => [
        batches,
        contacts,
        selectedContacts,
      ];
}

class BatchError extends BatchState {
  final String message;

  const BatchError({
    required this.message,
    super.contacts,
    super.selectedContacts,
  });

  @override
  List<Object> get props => [
        message,
        contacts,
        selectedContacts,
      ];
}

class ContactInitial extends BatchState {}

class ContactLoaded extends BatchState {
  const ContactLoaded({
    required super.contacts,
    required super.selectedContacts,
  });
}
