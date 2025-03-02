import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle.dart';

class FirestoreService {
  final CollectionReference vehiclesCollection =
      FirebaseFirestore.instance.collection('vehicles');

  Stream<List<Vehicle>> getVehicles() {
    return vehiclesCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Vehicle.fromFirestore(doc)).toList());
  }

  Future<void> addVehicle(Vehicle vehicle) {
    return vehiclesCollection.add(vehicle.toFirestore());
  }

  Future<void> updateVehicle(Vehicle vehicle) {
    return vehiclesCollection.doc(vehicle.id).update(vehicle.toFirestore());
  }

  Future<void> deleteVehicle(String id) {
    return vehiclesCollection.doc(id).delete();
  }
}
