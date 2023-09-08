import 'models/pokemon.dart';

const String kPokedexFileLocation = 'data/pokedex.json';
const String kPokedexKey = 'pokedex';
const String kImagesRoot = 'images/';
const String kImageLocalPrefix =
    "https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/ProtoDex/Art/";
const String kServerVersionLocation =
    'https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/ProtoDex/ServerVersions/versions.json';
const String kTrackerPrefix = 't_';
const String kCollectionBaseName = 'c_myCollection.json';
const String kLookingForBaseName = 'c_lookingFor.json';
const String kForTradeBaseName = 'c_forTrade.json';
// const String kCollectionFileLocation = 'data/collection.json';
// const String kCollectionKey = 'collection';

// const String kLookingForFileLocation = 'data/lf.json';
// const String kLookingForKey = 'lookingFor';

// const String kForTradeFileLocation = 'data/ft.json';
// const String kForTradeKey = 'forTrade';

const String kValueNotFound = "?";

List<Pokemon> kPokedex = [];
