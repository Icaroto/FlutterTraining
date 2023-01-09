export class Utils {

genderDiffMons =
[
  "Venusaur",
  "Butterfree",
  "Rattata",
  "Raticate",
  "Pikachu",
  "Raichu",
  "Zubat",
  "Golbat",
  "Gloom",
  "Vileplume",
  "Kadabra",
  "Alakazam",
  "Doduo",
  "Dodrio",
  "Hypno",
  "Rhyhorn",
  "Rhydon",
  "Goldeen",
  "Seaking",
  "Scyther",
  "Magikarp",
  "Gyarados",
  "Eevee",
  "Meganium",
  "Ledyba",
  "Ledian",
  "Xatu",
  "Sudowoodo",
  "Politoed",
  "Aipom",
  "Wooper",
  "Quagsire",
  "Murkrow",
  "Wobbuffet",
  "Girafarig",
  "Gligar",
  "Steelix",
  "Scizor",
  "Heracross",
  "Sneasel",
  "Hisuian Sneasel",
  "Ursaring",
  "Piloswine",
  "Octillery",
  "Houndoom",
  "Donphan",
  "Torchic",
  "Combusken",
  "Blaziken",
  "Beautifly",
  "Dustox",
  "Ludicolo",
  "Nuzleaf",
  "Shiftry",
  "Meditite",
  "Medicham",
  "Roselia",
  "Gulpin",
  "Swalot",
  "Numel",
  "Camerupt",
  "Cacturne",
  "Milotic",
  "Relicanth",
  "Starly",
  "Staravia",
  "Staraptor",
  "Bidoof",
  "Bibarel",
  "Kricketot",
  "Kricketune",
  "Shinx",
  "Luxio",
  "Luxray",
  "Roserade",
  "Combee",
  "Pachirisu",
  "Buizel",
  "Floatzel",
  "Ambipom",
  "Gible",
  "Gabite",
  "Garchomp",
  "Hippopotas",
  "Hippowdon",
  "Croagunk",
  "Toxicroak",
  "Finneon",
  "Lumineon",
  "Snover",
  "Abomasnow",
  "Weavile",
  "Rhyperior",
  "Tangrowth",
  "Mamoswine",
  "Unfezant",
  "Frillish",
  "Jellicent",
  "Pyroar",
  "Meowstic",
  "Indeedee",
  "Basculegion"
];

  getTypeName(index) : string | null {
    switch (index) {
      case 0:
        return "normal";
      case 1:
        return "fire";
      case 2:
        return "water";
      case 3:
        return "electric";
      case 4:
        return "grass";
      case 5:
        return "ice";
      case 6:
        return "fighting";
      case 7:
        return "poison";
      case 8:
        return "ground";
      case 9:
        return "flying";
      case 10:
        return "psychic";
      case 11:
        return "bug";
      case 12:
        return "rock";
      case 13:
        return "ghost";
      case 14:
        return "dragon";
      case 15:
        return "dark";
      case 16:
        return "steel";
      case 17:
        return "fairy";
      default:
        return "";
    }
  }
}
