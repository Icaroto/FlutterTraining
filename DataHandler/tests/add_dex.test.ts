import { test } from '@playwright/test';
import data from '../database/latest_dex.json';
import * as fs from 'fs';
import { parse } from 'csv-parse';
import Utils from '../utils/utils';
import { record } from '../utils/record';

const utils = new Utils();

test('Add Single Dex', async ({ }) => {

  // const csvFilePath = "D://Side-Projects//FlutterTraining//ProtoDex//DataFetcher//database//dexes//teal-mask.csv";
  const game = "Pokemon Legends: Arceus";
  const dexName = "Regional";
  const dexCsvFileName = "arceus.csv";

  // const csvFilePath = "/Users/itorres/Documents/Repos/FlutterTraining/ProtoDex/DataFetcher/database/dexes/" + dexCsvFileName;
  const csvFilePath = "D://Side-Projects//FlutterTraining//ProtoDex//DataFetcher//database//dexes//" + dexCsvFileName;
  const headers = ['number','ref','name','shinyLocked','exclusive'];
  const fileContent = fs.readFileSync(csvFilePath, { encoding: 'utf-8' });
  
  
parse(fileContent, {
  delimiter: ',',
  columns: headers,
}, (error, csvFile: record[]) => {
  if (error) {
    console.error(error);
  }

  for (let index = 0; index < csvFile.length; index++) {
    for (let i = 0; i < data.length; i++) {
      if(data[i].name == csvFile[index].name){ //pokemon found in biglist
        
        var newGames = utils.createSingleGame(csvFile[index], dexName, game);
        
        if(csvFile[index].ref == "") {

           data[i].games = [...data[i].games, ...newGames];

           for (let j = 0; j < data[i].forms.length; j++) {
            var form = data[i].forms[j];
            if(form.name.indexOf("Mega") === -1 && 
              form.name.indexOf("Gigantamax") === -1 &&
              form.name.indexOf("Alola") === -1 &&
              form.name.indexOf("Hisui") === -1 &&
              form.name.indexOf("Galar") === -1 &&
              form.name.indexOf("Paldea") === -1 ){

                form.games = [...form.games, ...newGames];
            }
           }
        }
        else {
          if (csvFile[index].ref.includes(".0")) {
            data[i].games = [...data[i].games, ...newGames];
          }

          utils.processFormsRecursive (data[i].forms, csvFile, index, newGames);
        }
      }
    }
   }

   utils.writeToFile("database/result.json", data);
});

});

test('Add Double Dex', async ({ baseURL, page }) => {

  // const csvFilePath = "D://Side-Projects//FlutterTraining//ProtoDex//DataFetcher//database//dexes//teal-mask.csv";
  const gameA = "Pokemon Sword";
  const gameB = "Pokemon Shield";
  const dexName = "Dynamax Adventure Bosses";
  const dexCsvFileName = "arceus.csv";

  // const csvFilePath = "/Users/itorres/Documents/Repos/FlutterTraining/ProtoDex/DataFetcher/database/dexes/" + dexCsvFileName;
  const csvFilePath = "D://Side-Projects//FlutterTraining//ProtoDex//DataFetcher//database//dexes//" + dexCsvFileName;
  const headers = ['number','ref','name','shinyLocked','exclusive'];
  const fileContent = fs.readFileSync(csvFilePath, { encoding: 'utf-8' });
  
  
parse(fileContent, {
  delimiter: ',',
  columns: headers,
}, (error, csvFile: record[]) => {
  if (error) {
    console.error(error);
  }

  for (let index = 0; index < csvFile.length; index++) {
    for (let i = 0; i < data.length; i++) {
      if(data[i].name == csvFile[index].name){ //pokemon found in biglist
        
        var newGames = utils.createGames(csvFile[index], dexName, gameA, gameB);
        
        if(csvFile[index].ref == "") {

           data[i].games = [...data[i].games, ...newGames];

           for (let j = 0; j < data[i].forms.length; j++) {
            var form = data[i].forms[j];
            if(form.name.indexOf("Mega") === -1 && 
              form.name.indexOf("Gigantamax") === -1 &&
              form.name.indexOf("Alola") === -1 &&
              form.name.indexOf("Hisui") === -1 &&
              form.name.indexOf("Galar") === -1 &&
              form.name.indexOf("Paldea") === -1 ){

                form.games = [...form.games, ...newGames];
            }
           }
        }
        else {
          if (csvFile[index].ref.includes(".0")) {
            data[i].games = [...data[i].games, ...newGames];
          }

          utils.processFormsRecursive (data[i].forms, csvFile, index, newGames);
        }
      }
    }
   }

   utils.writeToFile("database/result.json", data);
  });
});

