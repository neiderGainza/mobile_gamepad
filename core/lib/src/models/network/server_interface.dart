import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_interface.g.dart';

@JsonSerializable()
class ServerInterface {
  final String ip;
  final String interfaceName;

  const ServerInterface({
    required this.interfaceName,
    required this.ip
  });

  factory ServerInterface.fromJson(Map<String, dynamic> json) 
    => _$ServerInterfaceFromJson(json);
  Map<String, dynamic> toJson() => _$ServerInterfaceToJson(this);

}