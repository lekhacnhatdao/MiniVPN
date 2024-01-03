final class Config {
  Config._();

  static const appName = 'Mini VPN';
  static const version = '2.5';
  static const company = 'saigonzoolandsstudio';
  static const bundleId = 'com.saigonzoolandsstudio.WordQuizAnimal';

  static const vpnUrl = 'https://api.shieldme.top/servers/';

  static const privacyPolicyUrl = 'https://sites.google.com/$company-privacy';
  static const termOfUseUrl = 'https://sites.google.com/view/$company-terms';

  static const storeAppUrl =
      'https://play.google.com/store/apps/details?id=$bundleId';

  static final subIds = <String>{
    'saigonzoolandsstudio_sub_2.1',
    'saigonzoolandsstudio_sub_2.2',
    'saigonzoolandsstudio_sub_2.3',
  };

  static final consumableIds = <String>{
    'saigonzoolandsstudio_1.1',
  };
}
