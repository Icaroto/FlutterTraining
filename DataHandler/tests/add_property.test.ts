import { test } from '@playwright/test';
import data from '../database/latest_dex.json';
import Utils from "../utils/utils";

const utils = new Utils();


test('Add property', async ({ }) => {

  // Add a new property to each item in the array using type assertion
  for (let i = 0; i < data.length; i++) {
    var gen = '0';
    if (i  < 151) gen = '1';
    if ((i  < 251) && gen == '0') gen = '2';
    if ((i  < 386) && gen == '0') gen = '3';
    if ((i  < 493) && gen == '0') gen = '4';
    if ((i  < 649) && gen == '0') gen = '5';
    if ((i  < 721) && gen == '0') gen = '6';
    if ((i  < 809) && gen == '0') gen = '7';
    if ((i  < 905) && gen == '0') gen = '8';
    if ((i  < 1025) && gen == '0') gen = '9';

    data[i] = addNewProperty(data[i], gen);

    if (data[i].name == 'Tauros' || data[i].name == 'Alcremie' || data[i].name == 'Urshifu') {
      console.log(data[i]);
    }
    
  }

  utils.writeToFile("database/result.json", data);
    // var newData : Object[] = [];
    // for (let i = 0; i < data.length; i++) {
    //   var forms : Object[] = [];
    //   data[i].forms.forEach(form => {
    //     var formToAdd = 
    //     {
    //       "name": form.name,
    //       "formName": "",
    //       "species": form.species,
    //       "height": form.height,
    //       "weight": form.weight,
    //       "breeding":  form.breeding,
    //       "number":form.number,
    //       "ref": form.ref,
    //       "type1": form.type1,
    //       "type2": form.type2,
    //       "image": form.image,
    //       "abilities": form.abilities,
    //       "hiddenAbility": form.hiddenAbility,
    //       "weaknessquarter": form.weaknessquarter,
    //       "weaknesshalf": form.weaknesshalf,
    //       "weaknessnone": form.weaknessnone,
    //       "weaknessdouble": form.weaknessdouble,
    //       "weaknessquadruple": form.weaknessquadruple,
    //       "genderRatio": form.genderRatio,
    //       "games": form.games,
    //     };
    //     forms.push(formToAdd);
    //   });


    //   var toAdd = 
    //   {
    //     "name": data[i].name,
    //     "formName": "",
    //     "species": data[i].species,
    //     "height": data[i].height,
    //     "weight": data[i].weight,
    //     "breeding":  data[i].breeding,
    //     "number":data[i].number,
    //     "ref": data[i].ref,
    //     "type1": data[i].type1,
    //     "type2": data[i].type2,
    //     "image": data[i].image,
    //     "abilities": data[i].abilities,
    //     "hiddenAbility": data[i].hiddenAbility,
    //     "weaknessquarter": data[i].weaknessquarter,
    //     "weaknesshalf": data[i].weaknesshalf,
    //     "weaknessnone": data[i].weaknessnone,
    //     "weaknessdouble": data[i].weaknessdouble,
    //     "weaknessquadruple": data[i].weaknessquadruple,
    //     "genderRatio": data[i].genderRatio,
    //     "games": data[i].games,
    //     "forms": forms
    //   };
      
    //   newData.push(toAdd);
    // }
    
  function addNewProperty (data, value) {
    (data as any).generation = value;
    if (data.hasOwnProperty('forms') && data.forms.length >  0) {
      for (let i = 0; i < data.forms.length; i++) {
        data.forms[i] = addNewProperty(data.forms[i], value);
      }
    }
    return data;
  }
    // utils.writeToFile("database/result.json", newData);
});



