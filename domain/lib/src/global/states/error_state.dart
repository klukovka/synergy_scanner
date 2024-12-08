import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class ErrorState extends State<ErrorState> {
  final String? title;
  final String? message;
  final bool shouldCloseCurrentPage;

  ErrorState({
    this.title,
    this.message,
    required this.shouldCloseCurrentPage,
  }) : super(ErrorState._updateMessage.reducer);

  ErrorState.initial()
      : this(
          shouldCloseCurrentPage: false,
        );

  factory ErrorState._updateMessage(
    ErrorState state,
    OpenErrorDialogAction action,
  ) =>
      state.copyWith(
        title: action.title,
        message: action.message,
        shouldCloseCurrentPage: action.shouldCloseCurrentPage,
      );

  @override
  ErrorState copyWith({
    String? title,
    String? message,
    bool? shouldCloseCurrentPage,
  }) =>
      ErrorState(
        title: title ?? this.title,
        message: message ?? this.message,
        shouldCloseCurrentPage:
            shouldCloseCurrentPage ?? this.shouldCloseCurrentPage,
      );
}
