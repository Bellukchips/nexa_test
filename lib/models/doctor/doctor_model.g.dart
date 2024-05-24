// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
      id: (json['id'] as num).toInt(),
      nama: json['nama'] as String,
      jenis: json['jenis'] as String,
      tanggal: json['tanggal'] as String,
      jadwal: json['jadwal'] as String,
      jarak: json['jarak'] as String? ?? "",
    );

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'jenis': instance.jenis,
      'tanggal': instance.tanggal,
      'jadwal': instance.jadwal,
      'jarak': instance.jarak,
    };
