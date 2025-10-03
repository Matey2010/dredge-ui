R? let<T, R>(T? value, R Function(T) fn) => value != null ? fn(value) : null;
