enum AppRoutesEnum {
  breeds,
  detail,
}

extension AppRoutesEnumExtension on AppRoutesEnum {
  String get path {
    switch(this) {
      case AppRoutesEnum.breeds: return '/breeds';
      case AppRoutesEnum.detail: return '/detail';
    }
  }
}