import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  final TextEditingController controller;
  final bool isNumber;
  final IconData? icon;
  final String label;
  final String? Function(String?)? validator;
  const TextFieldWidget({super.key,required this.controller,this.isNumber = false,this.icon,required this.label,
   this.validator
  });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      style: const TextStyle(decoration: TextDecoration.none),
      controller: controller,
      decoration:  InputDecoration(
        label: Text(label),
        labelStyle: Theme.of(context).textTheme.titleLarge,
        prefixIcon: Icon(icon),
      ),
      validator: validator,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text
    );
  }
}
