part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  final List<MessageModel> messages;

  const ChatState(this.messages);

  @override
  List<Object> get props => [messages];

  ChatState copyWith({List<MessageModel>? messages});
}

final class MessageInitial extends ChatState {
  const MessageInitial(super.messages);

  @override
  MessageInitial copyWith({List<MessageModel>? messages}) {
    return MessageInitial(messages ?? this.messages);
  }
}

final class MessageLoading extends ChatState {
  const MessageLoading(super.messages) ;

  @override
  MessageLoading copyWith({List<MessageModel>? messages}) {
    return  MessageLoading(messages ?? this.messages);
  }
}

final class MessageAdded extends ChatState {
  const MessageAdded(super.messages);

  @override
  MessageAdded copyWith({List<MessageModel>? messages}) {
    return MessageAdded(messages ?? this.messages);
  }
}

final class MessageError extends ChatState {
  final String error;

  const MessageError(this.error, List<MessageModel> messages) : super(messages);

  @override
  MessageError copyWith({List<MessageModel>? messages}) {
    return MessageError(error, messages ?? this.messages);
  }

  @override
  List<Object> get props => [error, messages];
}
