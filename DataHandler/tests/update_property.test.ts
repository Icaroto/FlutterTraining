import { test } from '@playwright/test';
import data from '../database/latest_dex.json';
import Utils from "../utils/utils";

const utils = new Utils();

test('Update Property property', async ({ baseURL, page }) => {
  for (let i = 0; i < data.length; i++) {
    while (data[i].number.length < 4) data[i].number = "0" + data[i].number;


    data[i].forms.forEach(form => {
      if (data[i].forms.length > 0)
      {
        while (form.number.length < 4) form.number = "0" + form.number;
        if (form.forms != null && form.forms.length > 0)
        {
          form.forms.forEach(form => {
            while (form.number.length < 4) form.number = "0" + form.number;
          });
        }
    }
    });
  }
  utils.writeToFile("database/result.json", data);

});
