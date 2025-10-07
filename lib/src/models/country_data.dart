class CountryPhoneData {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  const CountryPhoneData({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });
}

const Map<String, CountryPhoneData> countryPhoneDataDictionary = {
  'US': CountryPhoneData(
    name: 'United States',
    code: 'US',
    dialCode: '+1',
    flag: '🇺🇸',
  ),
  'CA': CountryPhoneData(
    name: 'Canada',
    code: 'CA',
    dialCode: '+1',
    flag: '🇨🇦',
  ),
  'RU': CountryPhoneData(
    name: 'Russia',
    code: 'RU',
    dialCode: '+7',
    flag: '🇷🇺',
  ),
  'EG': CountryPhoneData(
    name: 'Egypt',
    code: 'EG',
    dialCode: '+20',
    flag: '🇪🇬',
  ),
  'ZA': CountryPhoneData(
    name: 'South Africa',
    code: 'ZA',
    dialCode: '+27',
    flag: '🇿🇦',
  ),
  'GR': CountryPhoneData(
    name: 'Greece',
    code: 'GR',
    dialCode: '+30',
    flag: '🇬🇷',
  ),
  'NL': CountryPhoneData(
    name: 'Netherlands',
    code: 'NL',
    dialCode: '+31',
    flag: '🇳🇱',
  ),
  'BE': CountryPhoneData(
    name: 'Belgium',
    code: 'BE',
    dialCode: '+32',
    flag: '🇧🇪',
  ),
  'FR': CountryPhoneData(
    name: 'France',
    code: 'FR',
    dialCode: '+33',
    flag: '🇫🇷',
  ),
  'ES': CountryPhoneData(
    name: 'Spain',
    code: 'ES',
    dialCode: '+34',
    flag: '🇪🇸',
  ),
  'IT': CountryPhoneData(
    name: 'Italy',
    code: 'IT',
    dialCode: '+39',
    flag: '🇮🇹',
  ),
  'CH': CountryPhoneData(
    name: 'Switzerland',
    code: 'CH',
    dialCode: '+41',
    flag: '🇨🇭',
  ),
  'AT': CountryPhoneData(
    name: 'Austria',
    code: 'AT',
    dialCode: '+43',
    flag: '🇦🇹',
  ),
  'GB': CountryPhoneData(
    name: 'United Kingdom',
    code: 'GB',
    dialCode: '+44',
    flag: '🇬🇧',
  ),
  'DK': CountryPhoneData(
    name: 'Denmark',
    code: 'DK',
    dialCode: '+45',
    flag: '🇩🇰',
  ),
  'SE': CountryPhoneData(
    name: 'Sweden',
    code: 'SE',
    dialCode: '+46',
    flag: '🇸🇪',
  ),
  'NO': CountryPhoneData(
    name: 'Norway',
    code: 'NO',
    dialCode: '+47',
    flag: '🇳🇴',
  ),
  'PL': CountryPhoneData(
    name: 'Poland',
    code: 'PL',
    dialCode: '+48',
    flag: '🇵🇱',
  ),
  'DE': CountryPhoneData(
    name: 'Germany',
    code: 'DE',
    dialCode: '+49',
    flag: '🇩🇪',
  ),
  'MX': CountryPhoneData(
    name: 'Mexico',
    code: 'MX',
    dialCode: '+52',
    flag: '🇲🇽',
  ),
  'AR': CountryPhoneData(
    name: 'Argentina',
    code: 'AR',
    dialCode: '+54',
    flag: '🇦🇷',
  ),
  'BR': CountryPhoneData(
    name: 'Brazil',
    code: 'BR',
    dialCode: '+55',
    flag: '🇧🇷',
  ),
  'CL': CountryPhoneData(
    name: 'Chile',
    code: 'CL',
    dialCode: '+56',
    flag: '🇨🇱',
  ),
  'CO': CountryPhoneData(
    name: 'Colombia',
    code: 'CO',
    dialCode: '+57',
    flag: '🇨🇴',
  ),
  'MY': CountryPhoneData(
    name: 'Malaysia',
    code: 'MY',
    dialCode: '+60',
    flag: '🇲🇾',
  ),
  'AU': CountryPhoneData(
    name: 'Australia',
    code: 'AU',
    dialCode: '+61',
    flag: '🇦🇺',
  ),
  'ID': CountryPhoneData(
    name: 'Indonesia',
    code: 'ID',
    dialCode: '+62',
    flag: '🇮🇩',
  ),
  'PH': CountryPhoneData(
    name: 'Philippines',
    code: 'PH',
    dialCode: '+63',
    flag: '🇵🇭',
  ),
  'NZ': CountryPhoneData(
    name: 'New Zealand',
    code: 'NZ',
    dialCode: '+64',
    flag: '🇳🇿',
  ),
  'SG': CountryPhoneData(
    name: 'Singapore',
    code: 'SG',
    dialCode: '+65',
    flag: '🇸🇬',
  ),
  'TH': CountryPhoneData(
    name: 'Thailand',
    code: 'TH',
    dialCode: '+66',
    flag: '🇹🇭',
  ),
  'JP': CountryPhoneData(
    name: 'Japan',
    code: 'JP',
    dialCode: '+81',
    flag: '🇯🇵',
  ),
  'KR': CountryPhoneData(
    name: 'South Korea',
    code: 'KR',
    dialCode: '+82',
    flag: '🇰🇷',
  ),
  'VN': CountryPhoneData(
    name: 'Vietnam',
    code: 'VN',
    dialCode: '+84',
    flag: '🇻🇳',
  ),
  'CN': CountryPhoneData(
    name: 'China',
    code: 'CN',
    dialCode: '+86',
    flag: '🇨🇳',
  ),
  'TR': CountryPhoneData(
    name: 'Turkey',
    code: 'TR',
    dialCode: '+90',
    flag: '🇹🇷',
  ),
  'IN': CountryPhoneData(
    name: 'India',
    code: 'IN',
    dialCode: '+91',
    flag: '🇮🇳',
  ),
  'PT': CountryPhoneData(
    name: 'Portugal',
    code: 'PT',
    dialCode: '+351',
    flag: '🇵🇹',
  ),
  'IE': CountryPhoneData(
    name: 'Ireland',
    code: 'IE',
    dialCode: '+353',
    flag: '🇮🇪',
  ),
  'FI': CountryPhoneData(
    name: 'Finland',
    code: 'FI',
    dialCode: '+358',
    flag: '🇫🇮',
  ),
  'UA': CountryPhoneData(
    name: 'Ukraine',
    code: 'UA',
    dialCode: '+380',
    flag: '🇺🇦',
  ),
  'CZ': CountryPhoneData(
    name: 'Czech Republic',
    code: 'CZ',
    dialCode: '+420',
    flag: '🇨🇿',
  ),
  'EC': CountryPhoneData(
    name: 'Ecuador',
    code: 'EC',
    dialCode: '+593',
    flag: '🇪🇨',
  ),
  'PY': CountryPhoneData(
    name: 'Paraguay',
    code: 'PY',
    dialCode: '+595',
    flag: '🇵🇾',
  ),
  'SA': CountryPhoneData(
    name: 'Saudi Arabia',
    code: 'SA',
    dialCode: '+966',
    flag: '🇸🇦',
  ),
  'AE': CountryPhoneData(
    name: 'United Arab Emirates',
    code: 'AE',
    dialCode: '+971',
    flag: '🇦🇪',
  ),
  'IL': CountryPhoneData(
    name: 'Israel',
    code: 'IL',
    dialCode: '+972',
    flag: '🇮🇱',
  ),
};

final List<CountryPhoneData> countries =
    countryPhoneDataDictionary.values.toList()
      ..sort((a, b) => a.dialCode.compareTo(b.dialCode));
