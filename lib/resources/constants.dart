import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:name_generator/resources/source.dart';

// NAME + APP DATA
//TODO: finally decide on a name!
const String app_name = 'Nameleon';

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

// USAGE SOURCES
const Source defaultSource = const Source('Default', '', 'btn');
const Source ancient = const Source('Ancient', 'anci', 'btn');
const Source ancientCeltic = const Source('Ancient Celtic', 'cela', 'btn');
const Source ancientGreek = const Source('Ancient Greek', 'gmca', 'btn');
const Source ancientRoman = const Source('Ancient Roman', 'roma', 'btn');
const Source ancientScandi =
    const Source('Ancient Scandinavian', 'scaa', 'btn');

const List<Source> tag_ancient = [
  ancient,
  ancientCeltic,
  ancientGreek,
  ancientRoman,
  ancientScandi
];

const Source astronomy = const Source('Astronomy', 'astr', 'btn');
const Source fairy = const Source('Fairy', 'fairy', 'btn');
const Source goth = const Source('Goth', 'goth', 'btn');
const Source hillbilly = const Source('Hillbilly', 'hb', 'btn');
const Source hippy = const Source('Hippy', 'hippy', 'btn');
const Source kreatyve = const Source('Kreatyve', 'kk', 'btn');
const Source pet = const Source('Pet', 'pets', 'btn');
const Source rapper = const Source('Rapper', 'rap', 'btn');
const Source transformer = const Source('Transformer', 'trans', 'btn');
const Source witch = const Source('Witch', 'witch', 'btn');
const Source wrestler = const Source('Wrestler', 'wrest', 'btn');

const List<Source> tag_fun = [
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

const List<Source> allNameSources = [
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
