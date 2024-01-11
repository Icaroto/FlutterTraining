import { test } from '@playwright/test';
import data from '../database/latest_dex.json';
import Utils from "../utils/utils";

const utils = new Utils();

test('Add property', async ({ }) => {
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
    

    utils.writeToFile("database/result.json", newData);
});
