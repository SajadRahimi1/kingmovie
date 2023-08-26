import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MessageType {
  info,
  success,
  error,
  warning,
}

Icon icon({
  required MessageType type,
}) {
  switch (type) {
    case MessageType.info:
      return const Icon(Icons.info, size: 28);
    case MessageType.success:
      return const Icon(Icons.check, size: 28);
    case MessageType.error:
      return const Icon(Icons.error, size: 28);
    case MessageType.warning:
      return const Icon(Icons.warning, size: 28);
    default:
      return const Icon(Icons.info, size: 28);
  }
}

Color bgColor({
  required MessageType type,
}) {
  switch (type) {
    case MessageType.info:
      return Colors.blue;
    case MessageType.success:
      return Colors.green.withOpacity(0.4);
    case MessageType.error:
      return Colors.red.withOpacity(0.4);
    case MessageType.warning:
      return Colors.orange.withOpacity(0.4);
    default:
      return Colors.blue.withOpacity(0.4);
  }
}

void showMessage(
    {String title = "",
    String message = "",
    TextStyle? messageStyle,
    TextStyle? titleStyle,
    Color? backgroundColor,
    MessageType? type,
    SnackPosition? snackPosition}) {
  Get.snackbar("", "",
      backgroundColor: type != null ? bgColor(type: type) : backgroundColor,
      messageText: Text(
        message,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: messageStyle,
      ),
      borderRadius: 3,
      icon: type != null ? icon(type: type) : null,
      titleText: Text(
        title,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: titleStyle,
      ),
      snackPosition: snackPosition);
}

void networkErrorMessage() => showMessage(
    title: "خطا در ارتباط با سرور",
    message: "در ارتباط با سرور مشکلی پیش آمد. دوباره تلاش کنید",
    type: MessageType.error);