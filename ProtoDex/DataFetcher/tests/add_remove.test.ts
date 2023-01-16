import { test } from '@playwright/test';
import data from '../database/fixed_dex.json';
import * as fs from 'fs';

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

test('Add Lets Go Games', async ({ baseURL, page }) => {
  for (let index = 0; index < 150; index++) {
    
    var number = (index + 1).toString();
    
    while (number.length < 3) number = "0" + number;

    //Pikachu Exclusives
    var notes = "";
    if(['Oddish',
    'Gloom',
    'Vileplume',
    'Sandshrew',
    'Sandslash',
    'Growlithe',
    'Arcanine',
    'Grimer',
    'Muk',
    'Scyther',
    'Mankey',
    'Primeape'].includes(data[index].name)){
        notes = "Let's Go Pikachu Exclusive"
    }

    //Eevee Exclusives
    if(['Bellsprout',
    'Weepinbell',
    'Victreebel',
    'Vulpix',
    'Ninetales',
    'Meowth',
    'Persian',
    'Koffing',
    'Weezing',
    'Pinsir',
    'Ekans',
    'Arbok'].includes(data[index].name)){
      notes = "Let's Go Eevee Exclusive"
    }

    const  toAdd = [{'name':'Let\'s Go Pikachu','dex':'Base','number': number, 'notes': notes},
                 {'name':'Let\'s Go Eevee','dex':'Base','number': number, 'notes': notes}
                ];
    data[index].games = [];
    data[index].games = [...data[index].games, ...toAdd];

    //Alolan All
    if(['Rattata', 'Geodude', 'Diglett', 'Raichu', 'Marowak','Exeggutor'].includes(data[index].name)){
      data[index].forms.forEach(forms => {
        if(forms.name.startsWith("Alolan")){

          notes = "In Game Trade";
          const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
                 {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
                ];
          forms.games = [];
          forms.games = toAdd;
        }
      });
    }

    if(['Raticate', 'Graveler', 'Golem', 'Dugtrio'].includes(data[index].name)){
      data[index].forms.forEach(forms => {
        if(forms.name.startsWith("Alolan")){

          notes = "In Game Trade - Evolve";
          const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
                 {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
                ];
          forms.games = [];
          forms.games = toAdd;
        }
      });
    }

    //Alolan Pikachu
    if(['Sandshrew', 'Grimer'].includes(data[index].name)){
      data[index].forms.forEach(forms => {
        if(forms.name.startsWith("Alolan")){

          notes = "Let's Go Pikachu Exclusive - In Game Trade";
          const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
                 {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
                ];
          forms.games = [];
          forms.games = toAdd;
        }
      });
    }
    if(['Sandslash', 'Muk'].includes(data[index].name)){
      data[index].forms.forEach(forms => {
        if(forms.name.startsWith("Alolan")){

          notes = "Let's Go Pikachu Exclusive - In Game Trade - Evolve";
          const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
                 {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
                ];
          forms.games = [];
          forms.games = toAdd;
        }
      });
    }

    //Alolan Eevee
    if(['Vulpix','Meowth'].includes(data[index].name)){
      data[index].forms.forEach(forms => {
        if(forms.name.startsWith("Alolan")){

          notes = "Let's Go Eevee Exclusive - In Game Trade";
          const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
                 {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
                ];
          forms.games = [];
          forms.games = toAdd;
        }
      });
    }
    if(['Ninetales','Persian'].includes(data[index].name)){
      data[index].forms.forEach(forms => {
        if(forms.name.startsWith("Alolan")){

          notes = "Let's Go Eevee Exclusive - In Game Trade - Evolve";
          const toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': number, 'notes': notes},
                 {'name':'Let\'s Go Eevee','dex':'Others','number': number, 'notes': notes}
                ];
          forms.games = [];
          forms.games = toAdd;
        }
      });
    }

  }

  //Additional (outside the 150 loop
  //Mew
  var  toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': '151', 'notes': 'Pokemon Go Plus'},
  {'name':'Let\'s Go Eevee','dex':'Others','number': '151', 'notes': 'Pokemon Go Plus'}];
  data[150].games = [];
  data[150].games = [...data[150].games, ...toAdd];

  //Meltan
  var  toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': '152', 'notes': 'From Pokemon Go'},
  {'name':'Let\'s Go Eevee','dex':'Others','number': '152', 'notes': 'From Pokemon Go'}];
  data[807].games = [];
  data[807].games = [...data[807].games, ...toAdd];

  //Melmetal
  toAdd = [{'name':'Let\'s Go Pikachu','dex':'Others','number': '153', 'notes': 'From Pokemon Go'},
  {'name':'Let\'s Go Eevee','dex':'Others','number': '153', 'notes': 'From Pokemon Go'}];
  data[808].games = [];
  data[808].games = [...data[808].games, ...toAdd];

  writeToFile("database/last_result.json", data);
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