import { test, expect } from '@playwright/test';
import DexPage from '../pages/base.page';
import { Pokemon } from "../models/pokemon";
import { appendFile, readFileSync, writeFile } from 'fs';

test('Capture Data', async ({ baseURL, page }) => {
  var data = "Bulbasaur";
  var limit = 3;
  await page.goto("https://pokemondb.net/pokedex/" + data);
  
  const dexList : Pokemon[] = [];

  var dexPage = new DexPage(page);

  for (let i = 0; i < limit; i++) {

    dexList.push(await dexPage.getData());

    if (await dexPage.hasForms()){
      for (let index = 1; index < await dexPage.howManyForms(); index++) {
        dexList[i].forms.push(await dexPage.getBaseData(index));
      }
    }
    await dexPage.nextPage();
  }
  console.log(JSON.stringify(dexList));


  var content: Pokemon[] = [];
  const file = readFileSync('./database/pokedex.json',"utf-8");
  if(file.length == 0){
    content = dexList;
  }
  else{
    let items = JSON.parse(file);
    dexList.forEach(mon => items.push(mon));
    content =  items;
  }

  writeFile('./database/pokedex.json', JSON.stringify(content, null, 4), err => {
      if (err) {
        throw err
      }
    })
    
  // await page.waitForTimeout(5000);
});
