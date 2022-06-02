enum LoadingProgress {
  done,
  error,
  loading,
}

enum RbioLoadingProgress {
  initial,
  loadInProgress,
  success,
  failure,
}

extension RbioLoadingProgressExtension on RbioLoadingProgress {
  bool get xIsLoadInProgress => this == RbioLoadingProgress.loadInProgress;
  bool get xIsFailure => this == RbioLoadingProgress.failure;
}
