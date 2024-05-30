import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  final String name;
  const ContactWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: 4,
            bottom: 8,
            left: 16,
            top: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          width: 70,
          height: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: const Icon(
              Icons.person,
              size: 34,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          width: 70,
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
