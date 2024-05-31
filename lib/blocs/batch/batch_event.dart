import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:studet_managment/models/batch.dart';

abstract class BatchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBatchesEvent extends BatchEvent {}

class AddBatchEvent extends BatchEvent {
  final Batch batch;

  AddBatchEvent(this.batch);

  @override
  List<Object> get props => [batch];
}

class LoadContacts extends BatchEvent {}

class ClearSelectedContacts extends BatchEvent {}

class SelectContact extends BatchEvent {
  final Contact contact;

  SelectContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class RemoveContact extends BatchEvent {
  final Contact contact;

  RemoveContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class SearchContacts extends BatchEvent {
  final String query;

  SearchContacts(this.query);

  @override
  List<Object> get props => [query];
}

class ResetSearchContacts extends BatchEvent {}
