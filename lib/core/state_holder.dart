class StateHolder<T> {

  Status status;
  T data;
  Object error;

  StateHolder.empty(): status = Status.Empty, data = null;
  StateHolder.loading(): status = Status.Loading;
  StateHolder.completed(T data): status = Status.Completed, data = data;
}

enum Status {
  Completed,
  Loading,
  Empty,
}