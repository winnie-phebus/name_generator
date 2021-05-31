import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:name_generator/resources/source.dart';

// NAME + APP DATA
const String app_name = 'Nameleon';

// DOCUMENT FIELDS
const String kFAVENAME = 'name';
const String kFAVEUSAGE = 'usages';
const String kFAVEGENDER = 'gender';
const String kFAVEUSER = 'user';

// THEMES + COLOR SWATCHES
const Color kDarkPurple = Color(0xFF242038);
const Color kSlateBlue = Color(0xFF725AC1);
const Color kMiddleBluePurple = Color(0xFF8D86C9);
const Color kLavenderGray = Color(0xFFCAC4CE);
const Color kLinen = Color(0xFFF7ECE1);
const Color kHoneydew = Color(0xFFE5F4E3);
const Color kWhite = Color(0xFFFFFFFF);
const Color kMintCream = Color(0xFFEDF7F6);
const Color kSandyBrown = Color(0xFFF19953);
const Color kCopper = Color(0xFFC47335);

InputDecoration kTextFieldDecoration = InputDecoration(
  hintText: '',
  hintStyle: TextStyle(
      color: kCopper), //TODO: [THEME] sort out the great theme mystery

  prefixStyle: TextStyle(color: kMiddleBluePurple),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkPurple, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkPurple, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kCopper, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const ColorScheme kdefaultScheme = ColorScheme(
    surface: kLavenderGray,
    onSecondary: kLinen,
    onError: kCopper,
    brightness: Brightness.light,
    onSurface: kDarkPurple,
    onPrimary: kDarkPurple,
    background: kLinen,
    secondaryVariant: kCopper,
    primaryVariant: kSlateBlue,
    onBackground: kDarkPurple,
    error: kSandyBrown,
    secondary: kSandyBrown,
    primary: kMiddleBluePurple);

// USAGE SOURCES
// --------------------- ANCIENT
const Origin defaultSource = const Origin('Default', '', 'btn');
const Origin ancient = const Origin('Ancient', 'anci', 'btn');
const Origin ancientCeltic = const Origin('Ancient Celtic', 'cela', 'btn');
const Origin ancientGreek = const Origin('Ancient Greek', 'gmca', 'btn');
const Origin ancientRoman = const Origin('Ancient Roman', 'roma', 'btn');
const Origin ancientScandi =
    const Origin('Ancient Scandinavian', 'scaa', 'btn');

const List<Origin> tag_ancient = [
  ancient,
  ancientCeltic,
  ancientGreek,
  ancientRoman,
  ancientScandi
];

/////// CONTINENTS
// --------------------- AFRICA
const Origin afrikaans = const Origin('Afrikaans', 'afk', 'btn');
const Origin african = const Origin('African', 'afr', 'btn');
const Origin akan = const Origin('Akan', 'aka', 'btn');
const Origin amharic = const Origin('Amharic', 'amh', 'btn');

const Origin berber = const Origin('Berber', 'ber', 'btn');
const Origin chewa = const Origin('Chewa', 'cew', 'btn');
const Origin coptic = const Origin('Coptic', 'cop', 'btn');

const Origin ethiopian = const Origin('Ethiopian', 'eth', 'btn');
const Origin ewe = const Origin('Ewe', 'ewe', 'btn');
const Origin fula = const Origin('Fula', 'ful', 'btn');

const Origin ganda = const Origin('Ganda', 'gan', 'btn');
const Origin hausa = const Origin('Hausa', 'hau', 'btn');
const Origin ibibio = const Origin('Ibibio', 'ibi', 'btn');
const Origin igbo = const Origin('Igbo', 'igb', 'btn');

const Origin kiga = const Origin('Kiga', 'kig', 'btn');
const Origin kikuyu = const Origin('Kikuyu', 'kik', 'btn');
const Origin luhya = const Origin('Luhya', 'luh', 'btn');
const Origin luo = const Origin('Luo', 'luo', 'btn');

const Origin mbundu = const Origin('Mbundu', 'mbu', 'btn');
const Origin mwera = const Origin('Mwera', 'mwe', 'btn');
const Origin ndebele = const Origin('Ndebele', 'nde', 'btn');
const Origin oromo = const Origin('Oromo', 'oro', 'btn');

const Origin shona = const Origin('Shona', 'sho', 'btn');
const Origin somali = const Origin('Somali', 'som', 'btn');
const Origin sotho = const Origin('Sotho', 'sot', 'btn');
const Origin swazi = const Origin('Swazi', 'swz', 'btn');

const Origin tooro = const Origin('Tooro', 'too', 'btn');
const Origin tswana = const Origin('Tswana', 'tsw', 'btn');
const Origin tumbuku = const Origin('Tumbuku', 'tum', 'btn');
const Origin urhobo = const Origin('Urhobo', 'urh', 'btn');

const Origin xhosa = const Origin('Xhosa', 'xho', 'btn');
const Origin yao = const Origin('Yao', 'yao', 'btn');
const Origin yoruba = const Origin('Yoruba', 'yor', 'btn');
const Origin zulu = const Origin('Zulu', 'zul', 'btn');

const List<Origin> tag_africa = [
  afrikaans,
  african,
  akan,
  amharic,
  berber,
  chewa,
  coptic,
  ethiopian,
  ewe,
  fula,
  ganda,
  hausa,
  ibibio,
  kiga,
  kikuyu,
  luhya,
  luo,
  mbundu,
  mwera,
  ndebele,
  oromo,
  shona,
  somali,
  sotho,
  swazi,
  tooro,
  tswana,
  tumbuku,
  urhobo,
  xhosa,
  yao,
  yoruba,
  zulu
];

// --------------------- ASIA
const Origin armenian = const Origin('Armenian', 'arm', 'btn');
const Origin assam = const Origin('Assam', 'asm', 'btn');
const Origin balinese = const Origin('Balinese', 'bal', 'btn');
const Origin bengali = const Origin('Bengali', 'ben', 'btn');
const Origin bhutanese = const Origin('Bhutanese', 'bhu', 'btn');
const Origin burmese = const Origin('Burmese', 'bur', 'btn');

const Origin chinese = const Origin('Chinese', 'chi', 'btn');
const Origin dhivehi = const Origin('Dhivehi', 'dhi', 'btn');
const Origin filipino = const Origin('Filipino', 'fil', 'btn');
const Origin gujarati = const Origin('Gujarati', 'guj', 'btn');
const Origin hmong = const Origin('Hmong', 'hmo', 'btn');
const Origin indian = const Origin('Indian', 'ind', 'btn');

const Origin indonesian = const Origin('Indonesian', 'ins', 'btn');
const Origin japanese = const Origin('Japanese', 'jap', 'btn');
const Origin javanese = const Origin('Javanese', 'jav', 'btn');
const Origin kannada = const Origin('Kannada', 'kan', 'btn');
const Origin khmer = const Origin('Khmer', 'khm', 'btn');
const Origin korean = const Origin('Korean', 'kor', 'btn');

const Origin lao = const Origin('Lao', 'lao', 'btn');
const Origin malayalam = const Origin('Malayalam', 'mlm', 'btn');
const Origin malay = const Origin('Malay', 'mly', 'btn');
const Origin mongolian = const Origin('Mongolian', 'mon', 'btn');
const Origin marathi = const Origin('Marathi', 'mrt', 'btn');
const Origin nepali = const Origin('Nepali', 'nep', 'btn');

const Origin odia = const Origin('Odia', 'odi', 'btn');
const Origin persian = const Origin('Persian', 'per', 'btn');
const Origin punjabi = const Origin('Punjabi', 'pun', 'btn');
const Origin tagalog = const Origin('Tagalog', 'tag', 'btn');
const Origin tajik = const Origin('Tajik', 'taj', 'btn');
const Origin tamil = const Origin('Tamil', 'tam', 'btn');

const Origin telugu = const Origin('Telugu', 'tel', 'btn');
const Origin thai = const Origin('Thai', 'tha', 'btn');
const Origin tibetan = const Origin('Tibetan', 'tib', 'btn');
const Origin turkmen = const Origin('Turkmen', 'tkm', 'btn');
const Origin urdu = const Origin('Urdu', 'urd', 'btn');
const Origin uyghur = const Origin('Uyghur', 'uyg', 'btn');

const Origin uzbek = const Origin('Uzbek', 'uzb', 'btn');
const Origin vietnamese = const Origin('Vietnamese', 'vie', 'btn');

const List<Origin> tag_asia = [
  armenian,
  assam,
  balinese,
  bengali,
  bhutanese,
  burmese,
  chinese,
  dhivehi,
  filipino,
  gujarati,
  hmong,
  indian,
  indonesian,
  japanese,
  javanese,
  kannada,
  khmer,
  korean,
  lao,
  malayalam,
  malay,
  mongolian,
  marathi,
  nepali,
  odia,
  persian,
  punjabi,
  tagalog,
  tajik,
  tamil,
  telugu,
  thai,
  tibetan,
  turkmen,
  urdu,
  uyghur,
  uzbek,
  vietnamese
];

// --------------------- AUSTRALIA + OCEANIA
const Origin indigenous_australian =
    const Origin('Indigenous Australian', 'aus', 'btn');
const Origin chamorro = const Origin('Chamorro', 'cha', 'btn');
const Origin maori = const Origin('Maori', 'mao', 'btn');
const Origin pintupi = const Origin('Pintupi', 'pin', 'btn');
const Origin tahitian = const Origin('Tahitian ', 'tah', 'btn');
const Origin wiradjuri = const Origin('Wiradjuri', 'wir', 'btn');
const Origin yolngu = const Origin('Yolngu', 'yol', 'btn');

const List<Origin> tag_australia_oceania = [
  indigenous_australian,
  chamorro,
  maori,
  pintupi,
  tahitian,
  wiradjuri,
  yolngu
];

// --------------------- EURASIA
const Origin kazakh = const Origin('Kazakh', 'kaz', 'btn');
const Origin kyrgyz = const Origin('Kyrgyz', 'kyr', 'btn');
const Origin turkish = const Origin('Turkish', 'tur', 'btn');

const List<Origin> tag_eurasia = [kazakh, kyrgyz, turkish];

// --------------------- EUROPE
const Origin albanian = const Origin('Albanian', 'alb', 'btn');
const Origin asturian = const Origin('Asturian', 'ast', 'btn');
const Origin avar = const Origin('Avar', 'ava', 'btn');
const Origin aymara = const Origin('Aymara', 'aym', 'btn');
const Origin azerbaijani = const Origin('Azerbaijani', 'aze', 'btn');
const Origin bashkir = const Origin('Bashkir', 'bsh', 'btn');

const Origin basque = const Origin('Basque', 'bas', 'btn');
const Origin belarusian = const Origin('Belarusian', 'bel', 'btn');
const Origin bosnian = const Origin('Bosnian', 'bos', 'btn');
const Origin breton = const Origin('Breton', 'bre', 'btn');
const Origin bulgarian = const Origin('Bulgarian', 'bul', 'btn');
const Origin chechen = const Origin('Chechen', 'che', 'btn');

const Origin circassian = const Origin('Circassian', 'cir', 'btn');
const Origin cornish = const Origin('Cornish', 'cor', 'btn');
const Origin croatia = const Origin('Croatia', 'cro', 'btn');
const Origin corsican = const Origin('Corsican', 'crs', 'btn');
const Origin czech = const Origin('Czech', 'cze', 'btn');
const Origin danish = const Origin('Danish', 'dan', 'btn');

const Origin dutch = const Origin('Dutch', 'dut', 'btn');
const Origin estonian = const Origin('Estonian', 'est', 'btn');
const Origin faroese = const Origin('Faroese', 'fae', 'btn');
const Origin finnish = const Origin('Finnish', 'fin', 'btn');
const Origin flemish = const Origin('Flemish', 'fle', 'btn');
const Origin frisian = const Origin('Frisian', 'fri', 'btn');

const Origin galician = const Origin('Galician', 'gal', 'btn');
const Origin georgia = const Origin('Georgia', 'geo', 'btn');
const Origin hungarian = const Origin('Hungarian', 'hun', 'btn');
const Origin icelandic = const Origin('Icelandic', 'ice', 'btn');
const Origin ingush = const Origin('Ingush', 'ing', 'btn');
const Origin irish = const Origin('Irish', 'iri', 'btn');

const Origin jerrais = const Origin('Jerrais', 'jer', 'btn');
const Origin latvian = const Origin('Latvian', 'lat', 'btn');
const Origin limburgish = const Origin('Limburgish', 'lim', 'btn');
const Origin lithuania = const Origin('Lithuania', 'lth', 'btn');
const Origin macedonia = const Origin('Macedonia', 'mac', 'btn');
const Origin maltese = const Origin('Maltese', 'mal', 'btn');

const Origin manx = const Origin('Manx', 'man', 'btn');
const Origin norwegian = const Origin('Norwegian', 'nor', 'btn');
const Origin norman = const Origin('Norman', 'nrm', 'btn');
const Origin ossetian = const Origin('Ossetian', 'oss', 'btn');
const Origin polish = const Origin('Polish', 'pol', 'btn');
const Origin romanian = const Origin('Romanian', 'rmn', 'btn');

const Origin russian = const Origin('Russian', 'rus', 'btn');
const Origin sami = const Origin('Sami', 'sam', 'btn');
const Origin sardinian = const Origin('Sardinian', 'sar', 'btn');
const Origin scottish = const Origin('Scottish', 'sco', 'btn');
const Origin serbian = const Origin('Serbian', 'ser', 'btn');
const Origin slavic = const Origin('Slavic', 'sla', 'btn');

const Origin slovak = const Origin('Slovak', 'slk', 'btn');
const Origin slovene = const Origin('Slovene', 'sln', 'btn');
const Origin swedish = const Origin('Swedish', 'swe', 'btn');
const Origin tatar = const Origin('Tatar', 'tat', 'btn');
const Origin ukraine = const Origin('Ukraine', 'ukr', 'btn');
const Origin welsh = const Origin('Welsh', 'wel', 'btn');

const List<Origin> tag_europe = [
  albanian,
  asturian,
  avar,
  aymara,
  azerbaijani,
  basque,
  bashkir,
  belarusian,
  bosnian,
  breton,
  bulgarian,
  chechen,
  circassian,
  cornish,
  croatia,
  corsican,
  czech,
  danish,
  dutch,
  estonian,
  faroese,
  finnish,
  flemish,
  frisian,
  galician,
  georgia,
  hungarian,
  icelandic,
  ingush,
  irish,
  jerrais,
  latvian,
  limburgish,
  lithuania,
  macedonia,
  maltese,
  manx,
  norwegian,
  norman,
  ossetian,
  polish,
  romanian,
  russian,
  sami,
  sardinian,
  scottish,
  serbian,
  slavic,
  slovak,
  slovene,
  swedish,
  tatar,
  ukraine,
  welsh
];

// --------------------- MIDDLE EAST
const Origin arabic = const Origin('Arabic', 'ara', 'btn');
const Origin jewish = const Origin('Jewish', 'jew', 'btn');
const Origin kurdish = const Origin('Kurdish', 'kur', 'btn');
const Origin pashto = const Origin('Pashto', 'kaz', 'btn');

const List<Origin> tag_middle_east = [arabic, jewish, kurdish, pashto];

// --------------------- NORTH AMERICA
const Origin algonquin = const Origin('Algonquin', 'alg', 'btn');
const Origin indigenuous_american =
    const Origin('Indigenuous American', 'ame', 'btn');
const Origin american = const Origin('American', 'usa', 'btn');
const Origin apache = const Origin('Apache', 'apa', 'btn');
const Origin cherokee = const Origin('Cherokee', 'chk', 'btn');
const Origin choctaw = const Origin('Choctaw', 'cht', 'btn');

const Origin comanche = const Origin('Comanche', 'com', 'btn');
const Origin cree = const Origin('Cree', 'cre', 'btn');
const Origin greenlandic = const Origin('Greenlandic', 'grn', 'btn');
const Origin hawaiian = const Origin('Hawaiian', 'haw', 'btn');
const Origin inuit = const Origin('Inuit', 'inu', 'btn');
const Origin iroquois = const Origin('Iroquois', 'iro', 'btn');

const Origin mayan = const Origin('Mayan', 'may', 'btn');
const Origin mohawk = const Origin('Mohawk', 'moh', 'btn');
const Origin nahuatl = const Origin('Nahuatl', 'nah', 'btn');
const Origin navajo = const Origin('Navajo', 'nav', 'btn');
const Origin ojibwe = const Origin('Ojibwe', 'oji', 'btn');
const Origin oneida = const Origin('Oneida', 'one', 'btn');

const Origin nuu_chah_nulth = const Origin('Nuu-chah-nulth', 'nuu', 'btn');
const Origin powhatan = const Origin('Powhatan', 'pow', 'btn');
const Origin shawnee = const Origin('Shawnee', 'sha', 'btn');
const Origin sioux = const Origin('Sioux', 'sio', 'btn');
const Origin zapotec = const Origin('Zapotec', 'zap', 'btn');

const List<Origin> tag_north_america = [
  algonquin,
  indigenuous_american,
  american,
  apache,
  cherokee,
  choctaw,
  comanche,
  cree,
  greenlandic,
  hawaiian,
  inuit,
  iroquois,
  mayan,
  mohawk,
  nahuatl,
  navajo,
  ojibwe,
  oneida,
  nuu_chah_nulth,
  powhatan,
  shawnee,
  sioux,
  zapotec
];

// --------------------- SOUTH AMERICA
const Origin mapuche = const Origin('Mapuche', 'map', 'btn');
const Origin quechua = const Origin('Quechua', 'que', 'btn');
const Origin tupi = const Origin('Tupi', 'tup', 'btn');

const List<Origin> tag_south_america = [mapuche, quechua, tupi];

////// CONTINENTS

// --------------------- LANGUAGE
const Origin catalan = const Origin('Catalan', 'cat', 'btn');
const Origin english = const Origin('English', 'eng', 'btn');
const Origin esperanto = const Origin('Esperanto', 'esp', 'btn');
const Origin french = const Origin('French', 'fre', 'btn');
const Origin german = const Origin('German', 'ger', 'btn');
const Origin greek = const Origin('Greek', 'gre', 'btn');

const Origin hebrew = const Origin('Hebrew', 'heb', 'btn');
const Origin hindi = const Origin('Hindi', 'hin', 'btn');
const Origin italian = const Origin('Italian', 'ita', 'btn');
const Origin low_german = const Origin('Low German', 'sax', 'btn');
const Origin occitan = const Origin('Occitan', 'occ', 'btn');
const Origin picard = const Origin('Picard', 'pcd', 'btn');

const Origin portugeuese = const Origin('Portugeuese', 'por', 'btn');
const Origin scots = const Origin('Scots', 'sct', 'btn');
const Origin sicilian = const Origin('Sicilian', 'sic', 'btn');
const Origin sorbian = const Origin('Sorbian', 'sor', 'btn');
const Origin spanish = const Origin('Spanish', 'spa', 'btn');
const Origin swahili = const Origin('Swahili', 'swa', 'btn');

const List<Origin> tag_languages = [
  catalan,
  english,
  esperanto,
  french,
  german,
  greek,
  hebrew,
  hindi,
  italian,
  low_german,
  occitan,
  picard,
  portugeuese,
  scots,
  sicilian,
  sorbian,
  spanish,
  swahili,
];

// --------------------- FUN
const Origin astronomy = const Origin('Astronomy', 'astr', 'btn');
const Origin fairy = const Origin('Fairy', 'fairy', 'btn');
const Origin goth = const Origin('Goth', 'goth', 'btn');
const Origin hillbilly = const Origin('Hillbilly', 'hb', 'btn');
const Origin hippy = const Origin('Hippy', 'hippy', 'btn');
const Origin kreatyve = const Origin('Kreatyve', 'kk', 'btn');
const Origin pet = const Origin('Pet', 'pets', 'btn');
const Origin rapper = const Origin('Rapper', 'rap', 'btn');
const Origin transformer = const Origin('Transformer', 'trans', 'btn');
const Origin witch = const Origin('Witch', 'witch', 'btn');
const Origin wrestler = const Origin('Wrestler', 'wrest', 'btn');

const List<Origin> tag_fun = [
  astronomy,
  fairy,
  goth,
  hillbilly,
  hippy,
  kreatyve,
  pet,
  rapper,
  transformer,
  witch,
  wrestler
];

// --------------------- FANTASY
const Origin gluttakh = const Origin('Gluttakh', 'fntsg', 'btn');
const Origin monstrall = const Origin('Monstrall', 'fntsm', 'btn');
const Origin romanto = const Origin('Romanto', 'fntsr', 'btn');
const Origin simitiq = const Origin('Simitiq', 'fntss', 'btn');
const Origin tsang = const Origin('Tsang', 'fntst', 'btn');
const Origin xalaxxi = const Origin('Xalaxxi', 'fntsx', 'btn');

const List<Origin> tag_fantasy = [
  gluttakh,
  monstrall,
  romanto,
  simitiq,
  tsang,
  xalaxxi,
];

// --------------------- RELIGION / MYTHOLOGY
const Origin theology = const Origin('Theology', 'theo', 'btn');
const Origin biblical = const Origin('Biblical', 'bibl', 'btn');
const Origin celtic_mythology = const Origin('Celtic Mythology', 'celm', 'btn');
const Origin greek_mythology = const Origin('Greek Mythology', 'grem', 'btn');
const Origin indian_mythology =
    const Origin('Indian Mythology ', 'indm', 'btn');
const Origin mormon = const Origin('Mormon', 'morm', 'btn');
const Origin mythology = const Origin('Mythology', 'myth', 'btn');
const Origin norse_mythology = const Origin('Norse Mythology', 'scam', 'btn');
const Origin norse_mythology_alt =
    const Origin('Norse Mythology Alt', 'slam', 'btn');
const Origin roman_mythology = const Origin('Roman Mythology', 'romm', 'btn');

const List<Origin> tag_religions = [
  theology,
  biblical,
  celtic_mythology,
  indian_mythology,
  mormon,
  mythology,
  norse_mythology,
  norse_mythology_alt,
  roman_mythology,
];

// --------------------- UNCATEGORIZED
const Origin anglo_saxon = const Origin('Anglo-Saxon', 'enga', 'btn');
const Origin history = const Origin('History', 'hist', 'btn');
const Origin literature = const Origin('Literature', 'lite', 'btn');
const Origin medieval = const Origin('Medieval', 'medi', 'btn');
const Origin popular_culture = const Origin('Popular Culture', 'popu', 'btn');
const Origin various = const Origin('Various', 'vari', 'btn');

const List<Origin> tag_uncategorized = [
  anglo_saxon,
  history,
  literature,
  medieval,
  popular_culture,
  various,
];

// --------------------- ALL
const List<Origin> allNameSources = [
  ancient,
  ancientCeltic,
  ancientGreek,
  ancientRoman,
  ancientScandi,
  astronomy,
  fairy,
  goth,
  hillbilly,
  hippy,
  kreatyve,
  pet,
  rapper,
  transformer,
  witch,
  wrestler,
];

const List<Origin> continent_origins = [
  ...tag_africa,
  ...tag_asia,
  ...tag_australia_oceania,
  ...tag_eurasia,
  ...tag_europe,
  ...tag_middle_east,
  ...tag_north_america,
  ...tag_south_america
];
const List<Origin> all_origins = [
  ...continent_origins,
  ...tag_ancient,
  ...tag_fantasy,
  ...tag_fun,
  ...tag_languages,
  ...tag_religions,
  ...tag_uncategorized
];
