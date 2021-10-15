import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

class SearchText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BuildBoxDecoration(),
      child: TextField(
        decoration: CustomInputs.searchInputDecoration(
          hint: 'Buscar', 
          icon: Icons.search_outlined
        ),
      ),
    );
  }

  BoxDecoration BuildBoxDecoration() => BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.withOpacity(0.1)
  );
}