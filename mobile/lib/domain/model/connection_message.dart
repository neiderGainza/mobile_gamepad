class ConnectionMessage{
  final ConnectionMessageType type;
  final DateTime time;
  final String content;
  final String? connectionAddress;
  final String? connectionPort;

  ConnectionMessage({
    required this.type,
    required this.content,
    this.connectionAddress,
    this.connectionPort,
  }) : time = DateTime.now();

  ConnectionMessage.message(String content) 
    : this(type: .message, content : content);

  ConnectionMessage.error(String content) 
    : this(type: .error, content : content);
  
  ConnectionMessage.warning(String content) 
    : this(type: .warning, content : content);  

  ConnectionMessage.connectionFailure(String address, int port)
    : this(
        type: .error,
        content: '',
        connectionAddress: address,
        connectionPort: '$port',
      );
}


enum ConnectionMessageType{
  message,
  error,
  warning;
}