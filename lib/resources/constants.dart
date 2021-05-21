import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:name_generator/resources/source.dart';

// NAME + APP DATA
//TODO: finally decide on a name!
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
  hintStyle: TextStyle(color: kCopper), //TODO: sort out the great theme mystery

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

// Example NameTile
//var kWinn =
//NameTile('Winnie', 'English', 'Female', 'doronelle7@gmail.com', false);

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
const List<Origin> tag_africa = [];

// --------------------- ASIA
const List<Origin> tag_asia = [];

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
const List<Origin> tag_europe = [];

// --------------------- MIDDLE EAST
const Origin arabic = const Origin('Arabic', 'ara', 'btn');
const Origin jewish = const Origin('Jewish', 'jew', 'btn');
const Origin kurdish = const Origin('Kurdish', 'kur', 'btn');
const Origin pashto = const Origin('Pashto', 'kaz', 'btn');

const List<Origin> tag_middle_east = [arabic, jewish, kurdish, pashto];

// --------------------- NORTH AMERICA
const List<Origin> tag_north_america = [];

// --------------------- SOUTH AMERICA
const Origin mapuche = const Origin('Mapuche', 'map', 'btn');
const Origin quechua = const Origin('Quechua', 'que', 'btn');
const Origin tupi = const Origin('Tupi', 'tup', 'btn');

const List<Origin> tag_south_america = [mapuche, quechua, tupi];

////// CONTINENTS

// --------------------- LANGUAGE
const List<Origin> tag_languages = [];

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
