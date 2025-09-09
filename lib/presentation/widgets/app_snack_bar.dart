import 'package:flutter/material.dart';

class AppSnackBar {
  static SnackBar _snackBar({
    required BuildContext context,
    required String message,
    required SnackBarTypes snackBarTypes,
  }) {
    const borderRadius = 10.0;

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      duration: const Duration(seconds: 3),
      elevation: 5.0,
      showCloseIcon: true,
      closeIconColor: Theme.of(context).iconTheme.color,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      content: Row(
        children: [
          Container(
            height: 70,
            width: 40,
            decoration: BoxDecoration(
              color: snackBarTypes.snackBarColor.withValues(alpha: .3),
              borderRadius: const BorderRadiusDirectional.horizontal(
                start: Radius.circular(borderRadius),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Icon(snackBarTypes.icon, color: snackBarTypes.snackBarColor),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  static void show({
    required BuildContext context,
    String? message,
    SnackBarTypes snackBarType = SnackBarTypes.success,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        _snackBar(
          message: message ?? snackBarType.defaultMessage(context),
          snackBarTypes: snackBarType,
          context: context,
        ),
      );
  }
}

enum SnackBarTypes {
  success,
  error,
  info;

  Color get snackBarColor {
    switch (this) {
      case SnackBarTypes.success:
        return Colors.green;
      case SnackBarTypes.info:
        return Colors.grey;
      case SnackBarTypes.error:
        return Colors.red;
    }
  }

  IconData get icon {
    switch (this) {
      case SnackBarTypes.success:
        return Icons.check_circle;
      case SnackBarTypes.info:
        return Icons.info_outline_rounded;
      case SnackBarTypes.error:
        return Icons.error;
    }
  }

  String defaultMessage(BuildContext context) {
    switch (this) {
      case SnackBarTypes.success:
      case SnackBarTypes.info:
        return 'Some news';
      case SnackBarTypes.error:
        return 'Something went wrong';
    }
  }
}
