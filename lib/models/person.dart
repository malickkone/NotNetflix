// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../services/api.dart';



class Person {
  final String name;
  final String characterName;
  final String? imageUrl;
  Person({
    required this.name,
    required this.characterName,
    this.imageUrl,
  });
  

  Person copyWith({
    String? name,
    String? characterName,
    String? imageUrl,
  }) {
    return Person(
      name: name ?? this.name,
      characterName: characterName ?? this.characterName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

 

  factory Person.fromJson(Map<String, dynamic> map) {
    return Person(
      name: map['name'] ,
      characterName: map['character'],
      imageUrl: map['profile_path'] 
    );
  }

  String personImage(){
    API api = API();
    return api.baseImageURL + imageUrl!;
  }
  
}
