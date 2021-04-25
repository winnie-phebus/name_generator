import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:name_generator/components/name_tile.dart';
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

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  prefixText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const ColorScheme kdefaultScheme = ColorScheme(
    surface: kLavenderGray,
    onSecondary: kDarkPurple,
    onError: kLavenderGray,
    brightness: Brightness.light,
    onSurface: kDarkPurple,
    onPrimary: kSlateBlue,
    background: kLinen,
    secondaryVariant: kCopper,
    primaryVariant: kSlateBlue,
    onBackground: kWhite,
    error: kLinen,
    secondary: kSandyBrown,
    primary: kMiddleBluePurple);

// Example NameTile
//var kWinn =
//NameTile('Winnie', 'English', 'Female', 'doronelle7@gmail.com', false);

// USAGE SOURCES
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
