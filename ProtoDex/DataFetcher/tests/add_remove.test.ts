import { test } from '@playwright/test';
import * as path from "path";
import data from '../database/fixed_dex.json';
import * as fs from 'fs';
import { parse } from 'csv-parse';

// test('Clear Game Data', async ({ baseURL, page }) => {

//   for (let index = 0; index < data.length; index++) {
//     data[index].games = [];
//     if (data[index].forms.length > 0){
//       data[index].forms.forEach(form => {
//         form.games = [];
//         console.log("Deleted games for " + form.name); 
//       });
//     }
//     console.log("Deleted games for " + data[index].name); 
//   }

//   writeToFile("database/last_result.json", data);
// });

// test('Add Lets Go Games', async ({ baseURL, page }) => {
//   for (let index = 0; index < 150; index++) {
    
//     var number = (index + 1).toString();
    
//     while (number.length < 3) number = "0" + number;

//     //Pikachu Exclusives
//     var notes = "";
//     if(['Oddish',
//     'Gloom',
//     'Vileplume',
//     'Sandshrew',
//     'Sandslash',
//     'Growlithe',
//     'Arcanine',
//     'Grimer',
//     'Muk',
//     'Scyther',
//     'Mankey',
//     'Primeape'].includes(data[index].name)){
//         notes = "Let's Go Pikachu Exclusive"
//     }

//     //Eevee Exclusives
//     if(['Bellsprout',
//     'Weepinbell',
//     'Victreebel',
//     'Vulpix',
//     'Ninetales',
//     'Meowth',
//     'Persian',
//     'Koffing',
//     'Weezing',
//     'Pinsir',
//     'Ekans',
//     'Arbok'].includes(data[index].name)){
//       notes = "Let's Go Eevee Exclusive"
//     }

//     const  toAdd = [{'name':'Let\'s Go Pikachu','dex':'Base','number': number, 'notes': notes},
//                  {'name':'Let\'s Go Eevee','dex':'Base','number': number, 'notes': notes}
//                 ];
//     data[index].games = [];
//     data[index].games = [...data[index].games, ...toAdd];

//     //Alolan All
//     if(['Rattata', 'Geodude', 'Diglett', 'Raichu', 'Marowak','Exeggutor'].includes(data[index].name)){
//       data[index].forms.forEach(forms => {
//         if(forms.name.startsWith("Alolan")){

//           notes = "In Game Trade";
//           const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
//                  {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
//                 ];
//           forms.games = [];
//           forms.games = toAdd;
//         }
//       });
//     }

//     if(['Raticate', 'Graveler', 'Golem', 'Dugtrio'].includes(data[index].name)){
//       data[index].forms.forEach(forms => {
//         if(forms.name.startsWith("Alolan")){

//           notes = "In Game Trade - Evolve";
//           const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
//                  {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
//                 ];
//           forms.games = [];
//           forms.games = toAdd;
//         }
//       });
//     }

//     //Alolan Pikachu
//     if(['Sandshrew', 'Grimer'].includes(data[index].name)){
//       data[index].forms.forEach(forms => {
//         if(forms.name.startsWith("Alolan")){

//           notes = "Let's Go Pikachu Exclusive - In Game Trade";
//           const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
//                  {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
//                 ];
//           forms.games = [];
//           forms.games = toAdd;
//         }
//       });
//     }
//     if(['Sandslash', 'Muk'].includes(data[index].name)){
//       data[index].forms.forEach(forms => {
//         if(forms.name.startsWith("Alolan")){

//           notes = "Let's Go Pikachu Exclusive - In Game Trade - Evolve";
//           const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
//                  {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
//                 ];
//           forms.games = [];
//           forms.games = toAdd;
//         }
//       });
//     }

//     //Alolan Eevee
//     if(['Vulpix','Meowth'].includes(data[index].name)){
//       data[index].forms.forEach(forms => {
//         if(forms.name.startsWith("Alolan")){

//           notes = "Let's Go Eevee Exclusive - In Game Trade";
//           const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
//                  {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
//                 ];
//           forms.games = [];
//           forms.games = toAdd;
//         }
//       });
//     }
//     if(['Ninetales','Persian'].includes(data[index].name)){
//       data[index].forms.forEach(forms => {
//         if(forms.name.startsWith("Alolan")){

//           notes = "Let's Go Eevee Exclusive - In Game Trade - Evolve";
//           const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
//                  {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
//                 ];
//           forms.games = [];
//           forms.games = toAdd;
//         }
//       });
//     }

//   }

//   //Additional (outside the 150 loop
//   //Mew
//   var  toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': '151', 'notes': 'Pokemon Go Plus'},
//   {'name':'Let\'s Go Eevee','dex':'Others','number': '151', 'notes': 'Pokemon Go Plus'}];
//   data[150].games = [];
//   data[150].games = [...data[150].games, ...toAdd];

//   //Meltan
//   var  toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': '152', 'notes': 'From Pokemon Go'},
//   {'name':'Let\'s Go Eevee','dex':'Others','number': '152', 'notes': 'From Pokemon Go'}];
//   data[807].games = [];
//   data[807].games = [...data[807].games, ...toAdd];

//   //Melmetal
//   toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': '153', 'notes': 'From Pokemon Go'},
//   {'name':'Let\'s Go Eevee','dex':'Others','number': '153', 'notes': 'From Pokemon Go'}];
//   data[808].games = [];
//   data[808].games = [...data[808].games, ...toAdd];

//   writeToFile("database/last_result.json", data);
// });

// test.skip('Scarlet Violet', async ({ baseURL, page }) => {

//   const csvFilePath = "/Users/itorres/Documents/Repos/FlutterTraining/ProtoDex/DataFetcher/database/dexes/svDex.csv";

//   const headers = ['number','ref','name','shinyLocked','exclusive'];

//   const fileContent = fs.readFileSync(csvFilePath, { encoding: 'utf-8' });

//   parse(fileContent, {
//     delimiter: ',',
//     columns: headers,
//   }, (error, dex: record[]) => {
//     if (error) {
//       console.error(error);
//     }

//     for (let index = 0; index < dex.length; index++) {
//       for (let i = 0; i < data.length; i++) {
//         if(data[i].name == dex[index].name){ //pokemon found in biglist
//           if(dex[index].ref == ""){ //means ALL forms are included
            
//             var sNotes = "";
//             var vNotes = "";

//             if (dex[index].exclusive == "SCARLET"){
//               vNotes = "Scarlet Exclusive";
//             }
//             else if(dex[index].exclusive == "VIOLET"){
//               sNotes = "Violet Exclusive";
//             }
            
//             // var notes = svExclusive(dex[index].exclusive);
            
//             var lock = convertStatus(dex[index].shinyLocked);
//             var num = toDexNumber(dex[index].number);
//             var toAdd = 
//               [
//                 {"name":"Scarlet","dex":"Base","number": num, "shinyLocked": lock, "notes": sNotes},
//                 {"name":"Violet","dex":"Base","number": num, "shinyLocked": lock, "notes": vNotes}
//               ]
//              data[i].games = [...data[i].games, ...toAdd];

//              console.log(data[i].name);
//              console.log(data[i].games);

//              for (let j = 0; j < data[i].forms.length; j++) {
//               var form = data[i].forms[j];
//               if(form.name.indexOf("Mega") === -1 && 
//                   form.name.indexOf("Gigantamax") === -1 &&
//                   form.name.indexOf("Alola") === -1 &&
//                   form.name.indexOf("Hisui") === -1 &&
//                   form.name.indexOf("Galar") === -1  ){

//                     form.games = [...form.games, ...toAdd];
//               }
//              }
//           }
//           else {
//             for (let j = 0; j < data[i].forms.length; j++) {
//               var form = data[i].forms[j];
//               var refs = dex[index].ref.split("|");

//               if(refs.includes(form.ref)){
//                 var sNotes = "";
//                 var vNotes = "";
//                 if (dex[index].exclusive == "SCARLET"){
//                   vNotes = "Scarlet Exclusive";
//                 }
//                 else if(dex[index].exclusive == "VIOLET"){
//                   sNotes = "Violet Exclusive";
//                 }

//                 var lock = convertStatus(dex[index].shinyLocked);
//                 var num = toDexNumber(dex[index].number);
//                 var toAdd = 
//                   [
//                     {"name":"Scarlet","dex":"Base","number": num, "shinyLocked": lock, "notes": sNotes},
//                     {"name":"Violet","dex":"Base","number": num, "shinyLocked": lock, "notes": vNotes}
//                   ]
                  
//                   form.games = [...form.games, ...toAdd];
//               }
//              }
//           }
//         }
//       }
//      }

//      writeToFile("database/last_result.json", data);

//     // console.log("Result", data);
//   });

//   function toDexNumber(num)
//   {
//     while(num.length < 3) num = "0" + num;
//     return num;
//   }

//   function convertStatus(status){
//     switch (status) {
//       case "FALSE":
//         return "UNLOCKED";
//       case "TRUE":
//         return "LOCKED";
//       case "EVENT_ONLY":
//         return "EVENT_ONLY";
//       default:
//         return "";
//     }
//   }

//   type record = {
//     number: string;
//     ref: string;
//     name: string;
//     shinyLocked: string;
//     exclusive: string;
//   };
// });

test('Add property', async ({ baseURL, page }) => {
    var newData : Object[] = [];
    
    for (let i = 0; i < data.length; i++) {
      var forms : Object[] = [];
      data[i].forms.forEach(form => {
        var formToAdd = 
        {
          "name": form.name,
          "formName": "",
          "species": form.species,
          "height": form.height,
          "weight": form.weight,
          "breeding":  form.breeding,
          "number":form.number,
          "ref": form.ref,
          "type1": form.type1,
          "type2": form.type2,
          "image": form.image,
          "abilities": form.abilities,
          "hiddenAbility": form.hiddenAbility,
          "weaknessquarter": form.weaknessquarter,
          "weaknesshalf": form.weaknesshalf,
          "weaknessnone": form.weaknessnone,
          "weaknessdouble": form.weaknessdouble,
          "weaknessquadruple": form.weaknessquadruple,
          "genderRatio": form.genderRatio,
          "games": form.games,
        };
        forms.push(formToAdd);
      });


      var toAdd = 
      {
        "name": data[i].name,
        "formName": "",
        "species": data[i].species,
        "height": data[i].height,
        "weight": data[i].weight,
        "breeding":  data[i].breeding,
        "number":data[i].number,
        "ref": data[i].ref,
        "type1": data[i].type1,
        "type2": data[i].type2,
        "image": data[i].image,
        "abilities": data[i].abilities,
        "hiddenAbility": data[i].hiddenAbility,
        "weaknessquarter": data[i].weaknessquarter,
        "weaknesshalf": data[i].weaknesshalf,
        "weaknessnone": data[i].weaknessnone,
        "weaknessdouble": data[i].weaknessdouble,
        "weaknessquadruple": data[i].weaknessquadruple,
        "genderRatio": data[i].genderRatio,
        "games": data[i].games,
        "forms": forms
      };
      
      newData.push(toAdd);
    }
    

    writeToFile("database/last_result.json", newData);
  });

function writeToFile(file, content){
  fs.writeFile(file, JSON.stringify(content), (err) => {
    if (err)
      console.log(err);
    else {
      console.log("File written successfully\n");
      console.log("The written has the following contents:");
      // console.log(fs.readFileSync("books.txt", "utf8"));
    }
  });
}