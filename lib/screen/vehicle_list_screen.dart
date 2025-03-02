import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/firestore_service.dart';
import '../models/vehicle.dart';
import '../widgets/vehicle_cart.dart';

class VehicleListScreen extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicle List')),
      body: StreamBuilder<List<Vehicle>>(
        stream: firestoreService.getVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No vehicles available.'));
          }
          final vehicles = snapshot.data!;
          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              return VehicleCard(vehicle: vehicles[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddVehicleDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Function to show the dialog box
  void _showAddVehicleDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController mileageController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Vehicle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Vehicle Name"),
              ),
              TextField(
                controller: mileageController,
                decoration: InputDecoration(labelText: "Mileage (km/l)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: "Age (years)"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                double mileage = double.tryParse(mileageController.text) ?? 0;
                int age = int.tryParse(ageController.text) ?? 0;

                if (name.isNotEmpty && mileage > 0 && age >= 0) {
                  firestoreService.addVehicle(Vehicle(
                    id: '',
                    name: name,
                    mileage: mileage,
                    age: age,
                  ));
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
