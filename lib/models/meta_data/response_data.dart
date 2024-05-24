import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'meta_data.dart';
part 'response_data.g.dart';

@JsonSerializable()
class ApiResponse extends Equatable {
  final MetaData metadata;
  final dynamic response;

  const ApiResponse({
    required this.metadata,
    required this.response,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  @override
  List<Object?> get props => [metadata, response];
}
