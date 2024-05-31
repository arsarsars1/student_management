// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:studet_managment/blocs/batch/batch_bloc.dart';
// import 'package:studet_managment/blocs/batch/batch_event.dart';
// import 'package:studet_managment/blocs/batch/batch_state.dart';
// import 'package:studet_managment/models/batch.dart';
// import 'package:studet_managment/utils/extension.dart';
//
// class TimePickerWidget extends StatefulWidget {
//   const TimePickerWidget({super.key});
//
//   @override
//   State<TimePickerWidget> createState() => _TimePickerWidgetState();
// }
//
// class _TimePickerWidgetState extends State<TimePickerWidget> {
//   Map<String, TimeRange> _selectedTimes = {};
//   Map<String, String> _validationErrors = {};
//
//   void _pickTime(String day) async {
//     final startTime = await _selectTime(context, "Select Start Time");
//     if (startTime != null) {
//       final endTime = await _selectTime(context, "Select End Time");
//       if (endTime != null) {
//         if (startTime.isBefore(endTime)) {
//           setState(() {
//             _selectedTimes[day] =
//                 TimeRange(startTime: startTime, endTime: endTime);
//             _validationErrors.remove(day);
//           });
//           context
//               .read<BatchBloc>()
//               .add(SelectSchedule(_selectedTimes, _validationErrors));
//         } else {
//           setState(() {
//             _validationErrors[day] = "Start time must be before end time";
//           });
//           context
//               .read<BatchBloc>()
//               .add(SelectSchedule(_selectedTimes, _validationErrors));
//         }
//       }
//     }
//   }
//
//   Future<DateTime?> _selectTime(BuildContext context, String label) async {
//     final TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//       helpText: label,
//     );
//     if (timeOfDay != null) {
//       final now = DateTime.now();
//       return DateTime(
//           now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final days = [
//       "Monday",
//       "Tuesday",
//       "Wednesday",
//       "Thursday",
//       "Friday",
//       "Saturday",
//       "Sunday"
//     ];
//
//     return BlocBuilder<BatchBloc, BatchState>(
//       builder: (context, state) {
//         if (state is ScheduleTime) {
//           _selectedTimes = state.selectedTimes;
//           _validationErrors = state.validationErrors;
//         }
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             for (var day in days)
//               ListTile(
//                 onTap: () => _pickTime(day),
//                 title: Text(day),
//                 subtitle: _validationErrors.containsKey(day)
//                     ? Text(
//                         _validationErrors[day] ?? '',
//                         style: const TextStyle(color: Colors.red),
//                       )
//                     : _selectedTimes.containsKey(day)
//                         ? Text(
//                             "Start: ${_selectedTimes[day]!.startTime.format(context)}, End: ${_selectedTimes[day]!.endTime.format(context)}",
//                           )
//                         : null,
//                 trailing: const Icon(Icons.access_time),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
