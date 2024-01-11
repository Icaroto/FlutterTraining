import { test } from '@playwright/test';
import data from '../database/latest_dex.json';
import Utils from "../utils/utils";

const utils = new Utils();

test('Clear Game Data', async ({}) => {
  for (let index = 0; index < data.length; index++) {
    data[index].games = [];
    if (data[index].forms.length > 0){
      data[index].forms.forEach(form => {
        form.games = [];
        console.log("Deleted games for " + form.name); 
      });
    }
    console.log("Deleted games for " + data[index].name); 
  }

  utils.writeToFile("database/last_result.json", data);
});
