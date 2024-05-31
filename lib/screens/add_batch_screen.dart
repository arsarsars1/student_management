// add_batch_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studet_managment/blocs/batch/batch_bloc.dart';
import 'package:studet_managment/blocs/batch/batch_event.dart';
import 'package:studet_managment/blocs/batch/batch_state.dart';
import 'package:studet_managment/models/batch.dart';
import 'package:studet_managment/widgets/contact_widget.dart';
import 'package:studet_managment/widgets/time_picker_widget.dart';

class AddBatchScreen extends StatefulWidget {
  const AddBatchScreen({super.key});

  @override
  State<AddBatchScreen> createState() => _AddBatchScreenState();
}

class _AddBatchScreenState extends State<AddBatchScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController admissionFeeController = TextEditingController();
  final TextEditingController feesController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String course = '';
  String subject = '';
  String status = '';

  @override
  void initState() {
    super.initState();
    context.read<BatchBloc>().add(ClearSelectedContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Batch'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Batch Name *',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Batch Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter batch name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Course *',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Course',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Course 1', 'Course 2']
                          .map((course) => DropdownMenuItem(
                                value: course,
                                child: Text(course),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          course = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select the course';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Subject *',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Subject 1', 'Subject 2']
                          .map((subject) => DropdownMenuItem(
                                value: subject,
                                child: Text(subject),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          subject = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select the subject';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Admission Fee *',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: admissionFeeController,
                      decoration: const InputDecoration(
                        labelText: 'Admission Fee',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: validateNumber,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Fees *',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: feesController,
                      decoration: const InputDecoration(
                        labelText: 'Fees',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: validateNumber,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Batch Status *',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Batch Status',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Active', 'Inactive']
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          status = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select the Batch Status';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Email (optional)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email (optional)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Schedule *',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const TimePickerWidget(),
                    const SizedBox(height: 12),
                    const Text(
                      'Add Students *',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    BlocBuilder<BatchBloc, BatchState>(
                        builder: (context, state) {
                      return Wrap(alignment: WrapAlignment.start, children: [
                        ...state.selectedContacts.map(
                          (contact) {
                            return Stack(children: [
                              ContactWidget(
                                name: contact.displayName ?? '',
                              ),
                              Positioned(
                                right: 4,
                                top: 5,
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<BatchBloc>()
                                        .add(RemoveContact(contact));
                                  },
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(2),
                                    child: const Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              )
                            ]);
                          },
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pushNamed(context, "/contact_page");
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 16,
                              bottom: 8,
                              left: 16,
                              top: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[700]!,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            width: 70,
                            height: 70,
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ]);
                    }),
                    const SizedBox(height: 12),
                    Row(children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            var state = context.read<BatchBloc>().state;

                            var selectedContacts = state.selectedContacts
                                .map((contact) => contact.displayName ?? '')
                                .toList();

                            var schedule = state.selectedTimes;
                            var validationErrors = state.validationErrors;

                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate() &&
                                selectedContacts.isNotEmpty &&
                                validationErrors.isEmpty &&
                                schedule.isNotEmpty &&
                                course.isNotEmpty &&
                                subject.isNotEmpty &&
                                status.isNotEmpty) {
                              final newBatch = Batch(
                                name: nameController.text,
                                course: course,
                                subject: subject,
                                admissionFee:
                                    double.parse(admissionFeeController.text),
                                fees: double.parse(feesController.text),
                                status: status,
                                email: emailController.text,
                                students: selectedContacts,
                                schedule: schedule,
                              );
                              context
                                  .read<BatchBloc>()
                                  .add(AddBatchEvent(newBatch));
                              Navigator.pop(context);
                            } else {
                              if (validationErrors.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Start time must be before end time")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Fill the field to continue")));
                              }
                            }
                          },
                          child: const Text(
                            'Add Batch',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ]),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    final intValue = int.tryParse(value);
    final doubleValue = double.tryParse(value);
    if (intValue == null && doubleValue == null) {
      return 'Please enter a valid number';
    }
    return null;
  }
}
