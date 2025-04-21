import 'package:demaze_practical/screens/maps/constants/maps_constants.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 16,
      right: 16,
      child:
      Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child:  const TextField(
          decoration: InputDecoration(
            hintText: MapsConstants.searchLocation,
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }
}
