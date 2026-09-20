import 'package:core/src/models/network/server_interface.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_address.g.dart';

@JsonSerializable()
class ServerAddress {
  final int port;
  final ServerInterface interface;

  const ServerAddress({
    required this.port,
    required this.interface
  });


  String encode() => '$port-${interface.interfaceName}-${interface.ip}';
  factory ServerAddress.decode(String source){
    try{
      final parts = source.split('-');
      return ServerAddress(
        port: int.parse(parts[0]), 
        interface: ServerInterface(interfaceName: parts[1], ip: parts[2])
      );
    }catch(e){
      print("Error decoding ServerAddress $e");
      rethrow;
    }
  }

  factory ServerAddress.fromJson(Map<String, dynamic> json) 
    => _$ServerAddressFromJson(json);
  Map<String, dynamic> toJson() => _$ServerAddressToJson(this);

}