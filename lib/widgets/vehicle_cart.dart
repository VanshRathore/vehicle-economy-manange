import 'package:flutter/material.dart';
import '../models/vehicle.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;

  VehicleCard({required this.vehicle});

  Color getVehicleColor() {
    if (vehicle.mileage >= 15) {
      return vehicle.age <= 5 ? Colors.green : Colors.amber;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getVehicleColor(),
      child: ListTile(
        title: Text(
          vehicle.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Mileage: ${vehicle.mileage} km/l, Age: ${vehicle.age} years",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
