import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:propertify/models/agent_model.dart';

class PropertyModel {
  String? id;
  AgentModel? agent;
  String propertyName;
  String? propertyRooms;
  String? propertyBathrooms;
  String? propertySqft;
  String propertyPrice;
  String propertyCategory;
  String propertyCity;
  String? propertyState;
  String? propertyZip;
  File? propertyCoverPicture; // Keep it as File
  List<XFile>? propertyGalleryPictures; // Keep it as File
  String? propertyDescription;
  String? longitude;
  String? latitude;
  List<String>? amenities;
  bool? isApproved;
  bool? isSold;
  List<String>? tags; // Added tags field

  // Add this field for newly added gallery pictures
  List<XFile>? newlyAddedGalleryPictures;

  PropertyModel({
    this.id,
    this.agent,
    required this.propertyName,
     this.propertyRooms,
    this.propertyBathrooms,
    this.propertySqft,
    required this.propertyPrice,
    required this.propertyCategory,
    required this.propertyCity,
    this.propertyState,
    this.propertyZip,
    this.propertyCoverPicture,
    this.propertyGalleryPictures,
    this.propertyDescription,
    this.longitude,
    this.latitude,
    this.amenities,
    this.isApproved,
    this.isSold,
    this.tags,
    this.newlyAddedGalleryPictures,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['_id'],
      agent: AgentModel.fromJson(json['agent']),
      propertyName: json['propertyName'],
      propertyRooms: json['propertyRooms'],
      propertyBathrooms: json['propertyBathrooms'],
      propertySqft: json['propertySqft'],
      propertyPrice: json['propertyPrice'],
      propertyCategory: json['propertyCategory'],
      propertyCity: json['propertyCity'],
      propertyState: json['propertyState'],
      propertyZip: json['propertyZip'],
      propertyCoverPicture: File(json['propertyCoverPicture']), // Convert path to File
      propertyGalleryPictures: (json['propertyGalleryPictures'] as List<dynamic>)
          .map((path) => XFile(path))
          .toList(), // Convert paths to File objects
      propertyDescription: json['propertyDescription'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      amenities: List<String>.from(json['amenities']),
      isApproved: json['isApproved'],
      isSold: json['isSold'],
      tags: List<String>.from(json['tags']), // Added tags field
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'agent': agent,
      'propertyName': propertyName,
      'propertyRooms': propertyRooms,
      'propertyBathrooms': propertyBathrooms,
      'propertySqft': propertySqft,
      'propertyPrice': propertyPrice,
      'propertyCategory': propertyCategory,
      'propertyCity': propertyCity,
      'propertyState': propertyState,
      'propertyZip': propertyZip,
      'propertyDescription': propertyDescription,
      'longitude': longitude,
      'latitude': latitude,
      'amenities': amenities,
      'isApproved': isApproved,
      'isSold' : isSold,
      'tags': tags, // Added tags field
    };

    if (id != null) {
      data['_id'] = id;
    }

    if (propertyCoverPicture != null) {
      // Store the path or relevant data about the File as needed
      data['propertyCoverPicture'] = propertyCoverPicture!.path;
    }

    if (propertyGalleryPictures != null) {
      data['propertyGalleryPictures'] =
          propertyGalleryPictures!.map((file) => file.path).toList();
    }

    // You can update the propertyCoverPicture and propertyGalleryPictures fields as needed based on your server response.

    return data;
  }
}
