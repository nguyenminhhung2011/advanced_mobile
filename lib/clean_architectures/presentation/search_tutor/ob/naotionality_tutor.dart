class NationalityTutor {
  final String code;
  final String name;

  NationalityTutor(this.code, this.name);
}

extension NationalityTutorExtension on NationalityTutor {
  bool get isVietNamese => code == 'vn';
}
