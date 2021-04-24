import 'package:equatable/equatable.dart';

class AddUpdateTodoState extends Equatable {
  final String title;
  final String description;
  final bool loading;

  AddUpdateTodoState({
    this.title,
    this.description,
    this.loading,
  });

  AddUpdateTodoState copyWith({
    String title,
    String description,
    bool overlayLoadingIndicatorIsVisible,
  }) {
    return AddUpdateTodoState(
      title: title ?? this.title,
      description: description ?? this.description,
      loading: overlayLoadingIndicatorIsVisible ?? this.loading,
    );
  }

  @override
  List<Object> get props => [
        title,
        description,
        loading,
      ];
}
