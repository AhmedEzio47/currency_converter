import 'package:currency_converter/core/custom_types/app_exception.dart';
import 'package:currency_converter/presentation/common/base_state.dart';
import 'package:currency_converter/presentation/common/status.dart';
import 'package:currency_converter/presentation/widgets/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A Reusable [BlocBuilder] that automatically handles the [BlocStatus] of the
///  [Bloc] state.

class BaseBlocConsumer<T extends Bloc<dynamic, S>, S extends BaseState>
    extends StatelessWidget {
  const BaseBlocConsumer({
    super.key,
    required this.onSuccess,
    this.onFailure,
    this.onEmpty,
    this.onInitial,
    this.onRetry,
    this.emptyTitle,
    this.emptyNote,
    this.listener,
    this.onLoading,
    this.isConsumerAction = false,
    this.errorPadding = EdgeInsets.zero,
    this.displayConnectionErrorPlaceholder = true,
    this.showBackBtnOnFailure = false,
    this.listenWhen,
  });

  /// The [onSuccess] callback will be called when the [Bloc] state
  /// is [BlocStatus.success].
  ///
  /// The [BuildContext] is the [BuildContext] of the [BlocBuilder].
  /// The [S] is the current [Bloc] state.
  final Widget Function(BuildContext context, S state) onSuccess;

  /// The [onFailure] callback will be called when the [Bloc] state
  /// is [BlocStatus.failure].
  ///
  /// The [BuildContext] is the [BuildContext] of the [BlocBuilder].
  /// The [S] is the current [Bloc] state.
  ///
  /// If [onFailure] is not provided, a default error widget will be
  /// displayed.
  final Widget Function(BuildContext context, S state)? onFailure;

  /// The [onEmpty] callback will be called when the [Bloc] state
  /// is [BlocStatus.empty].
  ///
  /// - The [BuildContext] is the [BuildContext] of the [BlocBuilder].
  /// - The [S] is the current [Bloc] state.
  ///
  /// If [onEmpty] is not provided, a default empty widget will be
  /// displayed.
  final Widget Function(BuildContext context, S state)? onEmpty;

  /// The [onInitial] callback will be called when the [Bloc] state
  /// is [BlocStatus.initial].
  ///
  /// - The [BuildContext] is the [BuildContext] of the [BlocBuilder].
  /// - The [S] is the current [Bloc] state.
  ///
  /// If [onInitial] is not provided, a default empty widget will be
  /// displayed.
  final Widget Function(BuildContext context, S state)? onInitial;

  /// The [onLoading] callback will be called when the [Bloc] state is
  /// [BlocStatus.loading].
  ///
  /// - The [BuildContext] is the [BuildContext] of the [BlocBuilder].
  /// - The [S] is the current [Bloc] state.
  ///
  /// If [onLoading] is not provided, a default loading widget will be
  /// displayed.
  final Widget Function(BuildContext context, S state)? onLoading;

  /// The [onRetry] callback will be called when the [Bloc] state is
  /// [BlocStatus.failure] and the user taps on the retry button.
  /// If [onRetry] is not provided, the retry button will not be displayed.
  final void Function()? onRetry;

  /// The [emptyTitle] will be displayed when the [Bloc] state
  /// is [BlocStatus.empty].
  final String? emptyTitle;

  /// The [emptyNote] will be displayed when the [Bloc] state
  /// is [BlocStatus.empty].
  final String? emptyNote;

  /// The [listener] callback will be called when the [Bloc] state changes.
  ///
  /// The [BuildContext] is the [BuildContext] of the [BlocBuilder].
  /// The [S] is the current [Bloc] state.
  final void Function(BuildContext context, S state)? listener;

  /// If [isConsumerAction] is true, the [listener] will be called when the
  /// [Bloc] state changes to display only failure messages but will only
  /// displays the [onSuccess].
  ///
  /// This is used with action buttons (e.g. button to login the user) to only
  /// display snack-bar for errors and not the whole error page.
  final bool isConsumerAction;

  /// The [errorPadding] will be used to add padding to the error widget.
  final EdgeInsets errorPadding;

  /// The [displayConnectionErrorPlaceholder] will be used to display the
  /// connection error placeholder.
  final bool displayConnectionErrorPlaceholder;

  final bool showBackBtnOnFailure;

  final bool Function(S, S)? listenWhen;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T, S>(
      listenWhen: (previous, current) => _listenWhen(previous, current),
      listener: (context, state) => _onStateChanged(context, state),
      builder: (context, state) {
        if (isConsumerAction) {
          return onSuccess.call(context, state);
        }
        switch (state.status) {
          case Status.initial:
            return onInitial?.call(context, state) ?? const SizedBox();
          case Status.loading:
            return onLoading?.call(context, state) ??
                const CircularProgressIndicator();
          case Status.empty:
            return onEmpty?.call(context, state) ??
                Center(child: Text('Nothing to show'));
          case Status.failure:
            if (state.failure is AppNoInternetException &&
                displayConnectionErrorPlaceholder) {
              return Center(child: Text('No Internet Connection'));
            }
            return onFailure?.call(context, state) ??
                Center(
                  child: Text(
                    state.failure?.getLocalizedMessage(context) ??
                        'Something went wrong',
                  ),
                );

          case Status.success:
            return onSuccess.call(context, state);
        }
      },
    );
  }

  bool _listenWhen(S previous, S current) {
    if (listenWhen != null) {
      return listenWhen!(previous, current);
    }

    return previous.status != current.status;
  }

  void _onStateChanged(BuildContext context, S state) {
    listener?.call(context, state);
    if (state.status == Status.failure && isConsumerAction) {
      if (state.failure is AppNoInternetException) {
        AppSnackBar.show(
          context: context,
          message: 'No Internet Connection',
          snackBarType: SnackBarTypes.error,
        );
      } else {
        AppSnackBar.show(
          context: context,
          message: state.failure?.getLocalizedMessage(context),
          snackBarType: SnackBarTypes.error,
        );
      }
    }
  }
}
