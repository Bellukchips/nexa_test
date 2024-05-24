class ImageAssets {
  static String imgPath = 'assets/img/';
  static String logo = 'logo';
  static String imgProfile = 'img_profile';
  static String imgSampleDr = 'img_sample_dr';

  static String get(String path) => '$imgPath$path.png';
}

class IconAssets {
  static String iconPath = 'assets/icon/';

  static String calendarAtive = 'ic_calendar_active';
  static String calendar = 'ic_calendar';
  static String calendarCard = 'ic_calendar_card';
  static String homeActive = 'ic_home_active';
  static String home = 'ic_home';
  static String key = 'ic_key';
  static String message = 'ic_message';
  static String user = 'ic_user';
  static String userInput = 'ic_user_input';
  static String search = 'ic_search';
  static String hospital = 'ic_hospital';
  static String doctorMenu = 'ic_doctor_menu';
  static String drug = 'ic_drug';

  static String get(String path) => '$iconPath$path.png';
}
