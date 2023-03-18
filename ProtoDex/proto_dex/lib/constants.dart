import 'models/pokemon.dart';

const String kPokedexFileLocation = 'data/pokedex.json';
const String kPokedexKey = 'pokedex';
const String kImagesRoot = 'images/';
const String kImageLocalPrefix =
    "https://raw.githubusercontent.com/Icaroto/FlutterTraining/main/ProtoDex/Art/";
const String kTrackerPrefix = 't_';
const String kCollectionBaseName = 'c_myCollection.json';
// const String kCollectionFileLocation = 'data/collection.json';
// const String kCollectionKey = 'collection';

// const String kLookingForFileLocation = 'data/lf.json';
// const String kLookingForKey = 'lookingFor';

// const String kForTradeFileLocation = 'data/ft.json';
// const String kForTradeKey = 'forTrade';

const String kValueNotFound = "?????";

List<Pokemon> kPokedex = [];
