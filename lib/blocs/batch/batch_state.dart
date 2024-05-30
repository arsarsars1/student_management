import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:studet_managment/models/batch.dart';

abstract class BatchState extends Equatable {
  const BatchState();

  List<Contact> get contacts => [];
  List<Contact> get selectedContacts => [];

  @override
  List<Object> get props => [];
}

class BatchInitial extends BatchState {}

class BatchLoading extends BatchState {}

class BatchLoaded extends BatchState {
  final List<Batch> batches;

  const BatchLoaded(this.batches);

  @override
  List<Object> get props => [batches];
}

class BatchError extends BatchState {
  final String message;

  const BatchError(this.message);

  @override
  List<Object> get props => [message];
}

class ContactInitial extends BatchState {}

class ContactLoaded extends BatchState {
  final List<Contact> _contacts;
  final List<Contact> _selectedContacts;

  const ContactLoaded({
    required List<Contact> contacts,
    required List<Contact> selectedContacts,
  })  : _contacts = contacts,
        _selectedContacts = selectedContacts;

  @override
  List<Contact> get contacts => _contacts;

  @override
  List<Contact> get selectedContacts => _selectedContacts;

  @override
  List<Object> get props => [_contacts, _selectedContacts];
}
