import * as fs from 'fs';

export default class Utils {

  public writeToFile(file, content){
    fs.writeFile(file, JSON.stringify(content), (err) => {
      if (err)
        console.log(err);
      else {
        console.log("File written successfully\n");
      }
    });
  }

  public processFormsRecursive(forms, csvFile, index, newGames) {
    for (let j = 0; j < forms.length; j++) {
      var form = forms[j];
      var refs = csvFile[index].ref.split("|");
      if (refs.includes(form.ref)) {
        form.games = [...form.games, ...newGames];
      }
  
      // Check if the current form has nested forms
      if (form.forms && form.forms.length > 0) {
        // Recursive call to process nested forms
        this.processFormsRecursive(form.forms, csvFile, index, newGames);
      }
    }
  }

  public createSingleGame(record, dexName, game) {

    var lock = this.convertStatus(record.shinyLocked);
    var num = this.toDexNumber(record.number);
    var notes = (record.notes != "") ? record.notes : "";
    var toAdd = 
        [
        {"name":game, "dex":dexName, "number": num, "shinyLocked": lock, "notes": notes}
        ]
        
    return toAdd;
  }

  public createGames(record, dexName, gameA, gameB) {
    var aNotes = "";
    var bNotes = "";
  
    if (record.exclusive == this.getGameExclusiveTag(gameA)) {
        bNotes = gameA.split(' ')[2] +  " Exclusive";
    }
    else if(record.exclusive == this.getGameExclusiveTag(gameB)){
        aNotes = gameB.split(' ')[2] + " Exclusive";
    }
    
    var lock = this.convertStatus(record.shinyLocked);
    var num = this.toDexNumber(record.number);
    var toAdd = 
        [
        {"name":gameA, "dex":dexName, "number": num, "shinyLocked": lock, "notes": aNotes},
        {"name":gameB, "dex":dexName, "number": num, "shinyLocked": lock, "notes": bNotes}
        ]
        
    return toAdd;
  }
  
  public getGameExclusiveTag(gameName: string): string {
    const words = gameName.split(' ');
  
    if (words.length == 3) {
      return words[2].toUpperCase();
    }
    else if (words.length == 2) {
        return words[1].toUpperCase();
    } else {
        return '';
    }
  }
  
  public toDexNumber(num)
  {
    if (num == "") return "";
    while(num.length < 3) num = "0" + num;
    return num;
  }
  
  public convertStatus(status){
    switch (status) {
      case "FALSE":
        return "UNLOCKED";
      case "TRUE":
        return "LOCKED";
      case "EVENT_ONLY":
        return "EVENT_ONLY";
      default:
        return "";
    }
  }

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
