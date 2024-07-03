enum ECommand {
  COMMAND_A,
  COMMAND_B,
  COMMAND_C,
  COMMAND_D,
  TEST
}

enum ENotifyType {
  ERROR,
  SUCCESS,
  WARNING,
  INFO
}

class WsMessage {
  final ECommand command;
  final dynamic data;
  final ENotifyType notifyType;

  WsMessage({
    required this.command,
    required this.data,
    required this.notifyType,
  });

  factory WsMessage.fromJson(Map<String, dynamic> json) {
    return WsMessage(
      command: _parseCommand(json['command']),
      data: json['data'],
      notifyType: _parseNotifyType(json['notifyType']),
    );
  }

  static ECommand _parseCommand(String command) {
    switch (command) {
      case 'COMMAND_A':
        return ECommand.COMMAND_A;
      case 'COMMAND_B':
        return ECommand.COMMAND_B;
      case 'COMMAND_C':
        return ECommand.COMMAND_C;
      case 'COMMAND_D':
        return ECommand.COMMAND_D;
      case 'TEST':
        return ECommand.TEST;
      default:
        throw ArgumentError('Unknown command: $command');
    }
  }

  static ENotifyType _parseNotifyType(String notifyType) {
    switch (notifyType) {
      case 'ERROR':
        return ENotifyType.ERROR;
      case 'SUCCESS':
        return ENotifyType.SUCCESS;
      case 'WARNING':
        return ENotifyType.WARNING;
      case 'INFO':
        return ENotifyType.INFO;
      default:
        throw ArgumentError('Unknown notifyType: $notifyType');
    }
  }


  Map<String, dynamic> toJson() {
    return {
      'command': command.toString().split('.').last,
      'data': data,
      'notifyType': notifyType.toString().split('.').last,
    };
  }
}
