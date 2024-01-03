// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoDomainImpl _$$TodoDomainImplFromJson(Map<String, dynamic> json) =>
    _$TodoDomainImpl(
      id: json['id'] as String? ?? '',
      title: json['title'] as String,
      date: const TimestampConverter().fromJson(json['date'] as Timestamp),
    );

Map<String, dynamic> _$$TodoDomainImplToJson(_$TodoDomainImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': const TimestampConverter().toJson(instance.date),
    };
