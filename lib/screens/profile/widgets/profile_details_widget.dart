import 'package:flutter/material.dart';

class ProfileDetailsWidget extends StatelessWidget {
  final String value;

  const ProfileDetailsWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepPurple, width: 1),
      ),
      width: MediaQuery.of(context).size.width * 1,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        value,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
