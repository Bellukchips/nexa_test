import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meta_data.g.dart';

@JsonSerializable()
class MetaData extends Equatable {
  final int status;
  final String message;

  const MetaData({required this.status, required this.message});
  
  factory MetaData.fromJson(Map<String,dynamic> json) => _$MetaDataFromJson(json);


  Map<String,dynamic> toJson() => _$MetaDataToJson(this); 
  
  @override
  List<Object?> get props => [status, message];
}
