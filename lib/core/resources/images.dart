class Images {
  Images._();

  static String icLauncher =
      const String.fromEnvironment('ENV', defaultValue: 'staging') == 'staging'
      ? 'assets/images/ic_launcher_stg.png'
      : 'assets/images/ic_launcher.png';

  static String icLauncherDark =
      const String.fromEnvironment('ENV', defaultValue: 'staging') == 'staging'
      ? 'assets/images/ic_launcher_stg_dark.png'
      : 'assets/images/ic_launcher_dark.png';

  static String icLogo =
      const String.fromEnvironment('ENV', defaultValue: 'staging') == 'staging'
      ? 'assets/images/ic_logo_stg.png'
      : 'assets/images/ic_logo.png';

  static String homeResto = 'assets/icons/home-resto.svg';
  static String discount = 'assets/icons/discount.svg';
  static String dashboard = 'assets/icons/dashboard.svg';
  static String setting = 'assets/icons/setting.svg';
  static String logout = 'assets/icons/logout.svg';
  static String kelolaDiskon = 'assets/icons/kelola-diskon.svg';
  static String kelolaPrinter = 'assets/icons/kelola-printer.svg';
  static String kelolaPajak = 'assets/icons/kelola-pajak.svg';
}
