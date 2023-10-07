import 'dart:developer' as devtools show log;

extension Log on Object? {
  void log() => devtools.log(toString());
  bool get isNotNull => this != null;
  bool get isNull => this == null;
}
