import { test } from '@playwright/test';
import data from '../database/latest_dex.json';
import * as fs from 'fs';
import { parse } from 'csv-parse';
import Utils from '../utils/utils';
import { record } from '../utils/record';

const utils = new Utils();

test('Multiple Dexes', async ({ baseURL, page }) => {
  const games = [
    {'game' : 'Pokemon Ultra Sun', 'dexName': 'Ultra Wormholes Legendaries', 'dexfile' : 'gen7-dex-usun-wormhole.csv', },
    {'game' : 'Pokemon Ultra Moon', 'dexName': 'Ultra Wormholes Legendaries', 'dexfile' : 'gen7-dex-umoon-wormhole.csv', },
  ]

  for (let index = 0; index < games.length; index++) {
    const gameName = games[index].game;
    const dexCsvFileName = games[index].dexfile;
    const dexName = games[index].dexName;
    const csvFilePath = "D://Side-Projects//FlutterTraining//DataHandler//database//dexes//" + dexCsvFileName;
    const headers = ['number','name','shinyLocked','notes'];
    const fileContent = fs.readFileSync(csvFilePath, { encoding: 'utf-8' });
    var keyword = 'Alolan';
    parse(fileContent, {
      delimiter: ',',
      columns: headers,
    }, (error, csvFile: record[]) => {
      if (error) {
        console.error(error);
      }
    
      for (let index = 0; index < csvFile.length; index++) {
        for (let i = 0; i < data.length; i++) {
          // if (keyword == '') {
          if(csvFile[index].name == data[i].name) { 
            csvFile[index].number = "";
            var newGames = utils.createSingleGame(csvFile[index], dexName, gameName);
            
            var formIndex = -1;
            if (keyword != '') formIndex = data[i].forms.findIndex((el) => el.name.startsWith(keyword));
            if (formIndex != -1) {
              data[i].forms[formIndex].games = [...data[i].forms[formIndex].games, ...newGames];
            }
            else {
              data[i].games = [...data[i].games, ...newGames];
            }
          }
        }
       }
       utils.writeToFile("database/result.json", data);
      });
      
  }
  
});
