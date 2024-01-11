import { Breeding } from "./breeding";
import { Game } from "./game";
import { GenderRatio } from "./genderRatio";

export class BasePokemon {
    name : string|null = "";
    species : string|null = "";
    height : string|null = "";
    weight : string|null = "";
    breeding : Breeding;
    number: string|null = "";
    ref: string|null = "";
    type1 : string|null = "";
    type2? : string|null = null;
    image : string[] = [];
    abilities : (string | null)[] = [];
    hiddenAbility : string|null = "";
    weaknessquarter : (string | null)[] = [];
    weaknesshalf : (string | null)[] = [];
    weaknessnone : (string | null)[] = [];
    weaknessdouble : (string | null)[] = [];
    weaknessquadruple : (string | null)[] = [];
    genderRatio : GenderRatio;
    games : Game[] = [];
  basePokemon: GenderRatio;
}