import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel extends Equatable {
  final int id;
  final String nama;
  final String jenis;
  final String tanggal;
  final String jadwal;
  final String? jarak;

  const DoctorModel(
      {required this.id,
      required this.nama,
      required this.jenis,
      required this.tanggal,
      required this.jadwal,
      this.jarak = ""});

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);

  @override
  List<Object?> get props => [id, nama, jenis, tanggal, jadwal, jarak];
}
