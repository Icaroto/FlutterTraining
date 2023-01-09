import { Page, Locator } from "@playwright/test";
import { BasePokemon } from "../models/basePokemon";
import { Pokemon } from "../models/pokemon";
import { Breeding } from "../models/breeding";
import { GenderRatio } from "../models/genderRatio";
import { Game } from "../models/game";
import {Utils} from "../utils/utils";

export default class DexPage {

  private utils:Utils = new Utils();

  readonly nextPageButton : Locator;
  readonly formsLocator : Locator;
  readonly nameTitleText : Locator;
  readonly nameTabText : Locator;
  readonly speciesText : Locator;
  readonly numberText : Locator;
  readonly typesText : Locator;
  readonly ability1 : Locator;
  readonly ability2 : Locator;
  readonly hiddenAbilityText : Locator;
  readonly weightText : Locator;
  readonly heightText : Locator;
  readonly eggGroupsText :Locator;
  readonly eggCyclesText : Locator;
  readonly weaknessList : Locator;
  readonly genderLabelText : Locator;
  readonly gamesList : Locator;

  constructor(public page : Page){
    this.nextPageButton = page.locator(".entity-nav-next").first();
    this.formsLocator = page.locator("div[class*=tabset-basics]  div[class=sv-tabs-tab-list] a[class*=sv-tabs-tab]");
    this.nameTitleText = page.locator("#main h1");
    this.nameTabText = page.locator("div[class*=tabset-basics] > div > a[class*=sv-tabs-tab]");
    this.speciesText  = page.locator("//*[contains(text(),'Species')]/parent::tr/td");
    this.numberText  = page.locator(".vitals-table td > strong");
    this.typesText = page.locator("//*[contains(text(),'Type')]/parent::tr/td");
    this.ability1 = page.locator("//*[contains(text(),'Abilities')]/parent::tr/td[1]/span[1]/a");
    this.ability2 = page.locator("//*[contains(text(),'Abilities')]/parent::tr/td[1]/span[2]/a");
    this.hiddenAbilityText = page.locator("//*[contains(text(),'Abilities')]/parent::tr/td[1]//small/a");
    this.weightText = page.locator("//*[contains(text(),'Weight')]/parent::tr/td");
    this.heightText = page.locator("//*[contains(text(),'Height')]/parent::tr/td");
    this.eggGroupsText = page.locator("//*[contains(text(),'Egg Groups')]/parent::tr/td");
    this.eggCyclesText = page.locator("//*[contains(text(),'Egg cycles')]/parent::th/parent::tr/td");
    this.weaknessList = page.locator("//*[@class='type-table type-table-pokedex']/parent::div");
    this.genderLabelText = page.locator("//*[contains(text(),'Gender')]/parent::tr/td");
    this.gamesList = page.locator("//*[contains(text(),'Local ')]/parent::tr/td");
  }

  async nextPage(){
    await this.nextPageButton.click();
  }

  async selectForm(index){
    return await this.formsLocator[index].click;
  }

  async hasForms(){
    return await this.formsLocator.count() > 1;
  }

  async howManyForms(){
    return await this.formsLocator.count();
  }

  async getData(){
    const pokemon = new Pokemon();
    const basePokemon = await this.getBaseData(0);
    
    pokemon.name = basePokemon.name;
    pokemon.number = basePokemon.number;
    pokemon.ref = basePokemon.ref;
    pokemon.species = basePokemon.species;
    pokemon.type1 = basePokemon.type1;
    pokemon.type2 = basePokemon.type2;
    pokemon.abilities = basePokemon.abilities;
    pokemon.hiddenAbility = basePokemon.hiddenAbility;
    pokemon.image = basePokemon.image;
    pokemon.height = basePokemon.height;
    pokemon.weight = basePokemon.weight;
    pokemon.breeding = basePokemon.breeding;
    pokemon.weaknessquarter = basePokemon.weaknessquarter
    pokemon.weaknesshalf = basePokemon.weaknesshalf
    pokemon.weaknessnone = basePokemon.weaknessnone
    pokemon.weaknessdouble = basePokemon.weaknessdouble
    pokemon.weaknessquadruple = basePokemon.weaknessquadruple
    pokemon.genderRatio = basePokemon.genderRatio
    pokemon.games = basePokemon.games

    return pokemon;
  }

  async getBaseData(index){
    var basePokemon = new BasePokemon();

    basePokemon.name = (index == 0 ) 
      ? await this.nameTitleText.textContent()
      : await this.nameTabText.nth(index).textContent();
  
    basePokemon.number = await this.numberText.nth(index).textContent();
    basePokemon.ref = `${basePokemon.number}.${index}`;
    basePokemon.species = await this.speciesText.nth(index).textContent();

    const typesCount = await this.typesText.nth(index).locator("a").count();
    const types = await this.typesText.nth(index).locator("a");
      basePokemon.type1 = (await types.nth(0).textContent())!.toLocaleLowerCase();
    if (typesCount > 1 ) basePokemon.type2 = (await types.nth(1).textContent())!.toLocaleLowerCase();
    
    basePokemon.abilities.push(await this.ability1.nth(index).textContent());
    if (await this.ability2.count() > 0) basePokemon.abilities.push(await this.ability2.nth(index).textContent()); 

    if (await this.hiddenAbilityText.nth(index).count() > 0) basePokemon.hiddenAbility = await this.hiddenAbilityText.nth(index).textContent();

    basePokemon.height = await this.heightText.nth(index).textContent();
    basePokemon.height = basePokemon.height!.substring(0, basePokemon.height!.indexOf(" (")).replace(" ","");
    
    basePokemon.weight = await this.weightText.nth(index).textContent();
    basePokemon.weight = basePokemon.weight!.substring(0, basePokemon.weight!.indexOf(" (")).replace(" ","");


    const breeding = new Breeding()
      breeding.groups = await (await this.eggGroupsText.nth(index).textContent())!.split(", ");
      breeding.cycles =  await this.eggCyclesText.nth(index).textContent();
      breeding.cycles = breeding.cycles!.substring(0, breeding.cycles!.indexOf(" ("));
      basePokemon.breeding = breeding;


    const parts = await this.weaknessList.nth(index).locator("table > tbody > tr > td");
    for (let index = 0; index < await parts.count(); index++) {
      const res = await parts.nth(index).textContent();
      switch (res) {
        case "¼":
          basePokemon.weaknessquarter.push(this.utils.getTypeName(index));
          break;
        case "½":
          basePokemon.weaknesshalf.push(this.utils.getTypeName(index));
          break;
        case "0":
          basePokemon.weaknessnone.push(this.utils.getTypeName(index));
          break;
        case "2":
          basePokemon.weaknessdouble.push(this.utils.getTypeName(index));
          break;
        case "4":
          basePokemon.weaknessquadruple.push(this.utils.getTypeName(index));
          break;
        default:
          break;
      }
    }


    //IMAGE
    var imageStart = "";
    if(basePokemon.name!.startsWith("Mega ")){
      if(basePokemon.name!.endsWith(" X")){
        imageStart = "-megax";
      }else if(basePokemon.name!.endsWith(" Y")){
        imageStart = "-megay";
      }
      else{
        imageStart = "-mega";
      }
    }
    else if(basePokemon.name!.startsWith("Alolan ")){
        imageStart = "-alolan";
    }
    else if(basePokemon.name!.startsWith("Galarian ")){
      imageStart = "-galar";
    }
    

    if (this.utils.genderDiffMons.includes(basePokemon.name!)){
      const normM = basePokemon.number + imageStart + "-normal-m.png";
      const normF = basePokemon.number + imageStart + "-normal-f.png";
      const shinM = basePokemon.number + imageStart + "-shiny-m.png";
      const shinF = basePokemon.number + imageStart + "-shiny-f.png";
      basePokemon.image.push(normM, normF, shinF, shinM);
    }else if(await this.genderLabelText.nth(index).textContent() == "Genderless") {
      const norm = basePokemon.number + imageStart + "-normal-g.png";
      const shin = basePokemon.number + imageStart + "-shiny-g.png";  
      basePokemon.image.push(norm, shin);
    }
    else{
      const norm = basePokemon.number + imageStart + "-normal-mf.png";
      const shin = basePokemon.number + imageStart + "-shiny-mf.png";  
      basePokemon.image.push(norm, shin);
    }
    //IMAGE

    //GENDER
    const genderRatio = new GenderRatio();
    const genderLabel = await this.genderLabelText.nth(index).textContent();
    if (genderLabel == "Genderless") {
      genderRatio.genderless = "100";
      genderRatio.male = "0";
      genderRatio.female = "0";
    }
    else if(genderLabel == "—"){
      genderRatio.genderless = null;
      genderRatio.male = null;
      genderRatio.female = null;
    }
    else {
      genderRatio.genderless = "0";
      genderRatio.male = await (await this.genderLabelText.nth(index)).locator("span[class=text-blue]").textContent();
      genderRatio.male = genderRatio.male!.replace(/[%]*[a-z]*[A-Z]*/g,'').trim();
      genderRatio.female = await (await this.genderLabelText.nth(index)).locator("span[class=text-pink]").textContent();
      genderRatio.female = genderRatio.female!.replace(/[[%]*[a-z]*[A-Z]*/g,'').trim();
    }
    basePokemon.genderRatio = genderRatio;
    //GENDER

    //GAMES
    const valor = await this.gamesList.nth(index).textContent();
    const games = valor!.split(")");
    for (let index = 0; index < games.length; index++) {
      const game = new Game();
      game.number = games[index].substring(0, games[index].indexOf(" "));
      game.name = games[index].substring(games[index].indexOf(" ") + 2);
      if (game.name != "" ) basePokemon.games.push(game);      
    }
    //GAMES

    return basePokemon;
  }

  

}