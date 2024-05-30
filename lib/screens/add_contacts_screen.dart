import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studet_managment/blocs/batch/batch_bloc.dart';
import 'package:studet_managment/blocs/batch/batch_event.dart';
import 'package:studet_managment/blocs/batch/batch_state.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    context.read<BatchBloc>().add(LoadContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contacts'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: BlocBuilder<BatchBloc, BatchState>(
            builder: (context, state) {
              if (state is ContactLoaded) {
                return Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Search Contacts',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (query) {
                        if (query.isEmpty) {
                          context.read<BatchBloc>().add(ResetSearchContacts());
                        } else {
                          context.read<BatchBloc>().add(SearchContacts(query));
                        }
                      },
                    ),
                  ),
                  if (state.selectedContacts.isNotEmpty)
                    SizedBox(
                      height: 44,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 18, right: 12),
                        children: state.selectedContacts.map((contact) {
                          return InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              context
                                  .read<BatchBloc>()
                                  .add(RemoveContact(contact));
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Card(
                              child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  margin: const EdgeInsets.only(
                                      right: 8, top: 4, bottom: 4),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          contact.displayName ?? '',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        const Icon(
                                          Icons.close,
                                        ),
                                      ])),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.contacts.length,
                      itemBuilder: (context, index) {
                        final contact = state.contacts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 2),
                          child: Card(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              title: Text(
                                contact.displayName ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: Icon(
                                state.selectedContacts.contains(contact)
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                              ),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (state.selectedContacts.contains(contact)) {
                                  context
                                      .read<BatchBloc>()
                                      .add(RemoveContact(contact));
                                } else {
                                  context
                                      .read<BatchBloc>()
                                      .add(SelectContact(contact));
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 18),
                    child: Row(children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ]);
              } else if (state is ContactInitial) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
