// import { test } from '@playwright/test';
// import * as fs from 'fs';

// test('Rename Data Base', async ({ baseURL, page }) => {
//   var path = 'C:\\Users\\icaro\\Desktop\\Pokemon\\Pokémon Resources\\PokemonImages\\play\\norms';
//   fs.readdir(path, (err, files) => {
//     files.forEach(file => {
//       if(file.indexOf(".png")  !== -1){

//         var number = file.replace("poke_capture_0","");
//         number = number.substring(0,3);

//         var newname = number.toString();

//         while (newname.length < 3) newname = "0" + newname;
        
//         if (file.endsWith("_r.png")) {
//           newname = newname + "-shiny";
//         }else{
//           newname = newname + "-normal";
//         }

//         if (file.indexOf("_md_")  !== -1){//male
//           newname = newname + "-m.png";
//         }else if(file.indexOf("_fd_")  !== -1){ //female
//           newname = newname + "-f.png";
//         }else if(file.indexOf("_mf_")  !== -1 || file.indexOf("_mo_")  !== -1) //both
//           newname = newname + "-mf.png";
//         else{ //genderless
//           newname = newname + "-g.png";
//         }

//         console.log("new name:" + newname);
//         fs.rename(path + '/' + file, path + '/' + newname, function(err) {
//           if ( err ) console.log('ERROR: ' + err);
//         });

//       }
//     });
//   });
// });

// test('Rename Data Mega', async ({ baseURL, page }) => {
//   var path = 'C:\\Users\\icaro\\Desktop\\Pokemon\\Pokémon Resources\\PokemonImages\\play\\mega';
//   fs.readdir(path, (err, files) => {
//     files.forEach(file => {
//       if(file.indexOf(".png")  !== -1){

//         var number = file.replace("poke_capture_0","");
//         number = number.substring(0,3);
//         // console.log("file name is: " + file);
//         // console.log("number is: " + number );

//         var newname = number.toString();

//         // console.log("old name:" + file);
//         // //poke_capture_0003_000_fd_n_00000000_f_r.png

//         while (newname.length < 3) newname = "0" + newname;
        
//         newname = newname + "-mega"

//         if (file.endsWith("_r.png")) {
//           newname = newname + "-shiny";
//         }else{
//           newname = newname + "-normal";
//         }

//         if (file.indexOf("_md_")  !== -1){//male
//           newname = newname + "-m.png";
//         }else if(file.indexOf("_fd_")  !== -1){ //female
//           newname = newname + "-f.png";
//         }else if(file.indexOf("_mf_")  !== -1 || file.indexOf("_mo_")  !== -1) //both
//           newname = newname + "-mf.png";
//         else{ //genderless
//           newname = newname + "-g.png";
//         }

//         console.log("new name:" + newname);
//         fs.rename(path + '/' + file, path + '/' + newname, function(err) {
//           if ( err ) console.log('ERROR: ' + err);
//         });

//       }
//     });
//   });
// });


// test('Rename Data Hisui', async ({ baseURL, page }) => {
//   var path = 'C:\\Users\\icaro\\Desktop\\Pokemon\\Pokémon Resources\\PokemonImages\\play\\hisui';
//   fs.readdir(path, (err, files) => {
//     files.forEach(file => {
//       if(file.indexOf(".png")  !== -1){

//         var number = file.replace("poke_capture_0","");
//         number = number.substring(0,3);
//         // console.log("file name is: " + file);
//         // console.log("number is: " + number );

//         var newname = number.toString();

//         // console.log("old name:" + file);
//         // //poke_capture_0003_000_fd_n_00000000_f_r.png

//         while (newname.length < 3) newname = "0" + newname;
        
//         newname = newname + "-hisuian"

//         if (file.endsWith("_r.png")) {
//           newname = newname + "-shiny";
//         }else{
//           newname = newname + "-normal";
//         }

//         if (file.indexOf("_md_")  !== -1){//male
//           newname = newname + "-m.png";
//         }else if(file.indexOf("_fd_")  !== -1){ //female
//           newname = newname + "-f.png";
//         }else if(file.indexOf("_mf_")  !== -1 || file.indexOf("_mo_")  !== -1) //both
//           newname = newname + "-mf.png";
//         else{ //genderless
//           newname = newname + "-g.png";
//         }

//         console.log("new name:" + newname);
//         fs.rename(path + '/' + file, path + '/' + newname, function(err) {
//           if ( err ) console.log('ERROR: ' + err);
//         });

//       }
//     });
//   });
// });

// test('Rename Data Galar', async ({ baseURL, page }) => {
//   var path = 'C:\\Users\\icaro\\Desktop\\Pokemon\\Pokémon Resources\\PokemonImages\\play\\galar';
//   fs.readdir(path, (err, files) => {
//     files.forEach(file => {
//       if(file.indexOf(".png")  !== -1){

//         var number = file.replace("poke_capture_0","");
//         number = number.substring(0,3);
//         // console.log("file name is: " + file);
//         // console.log("number is: " + number );

//         var newname = number.toString();

//         // console.log("old name:" + file);
//         // //poke_capture_0003_000_fd_n_00000000_f_r.png

//         while (newname.length < 3) newname = "0" + newname;
        
//         newname = newname + "-galar"

//         if (file.endsWith("_r.png")) {
//           newname = newname + "-shiny";
//         }else{
//           newname = newname + "-normal";
//         }

//         if (file.indexOf("_md_")  !== -1){//male
//           newname = newname + "-m.png";
//         }else if(file.indexOf("_fd_")  !== -1){ //female
//           newname = newname + "-f.png";
//         }else if(file.indexOf("_mf_")  !== -1 || file.indexOf("_mo_")  !== -1) //both
//           newname = newname + "-mf.png";
//         else{ //genderless
//           newname = newname + "-g.png";
//         }

//         console.log("new name:" + newname);
//         fs.rename(path + '/' + file, path + '/' + newname, function(err) {
//           if ( err ) console.log('ERROR: ' + err);
//         });

//       }
//     });
//   });
// });



// test('Rename Data Alola', async ({ baseURL, page }) => {
//   var path = 'C:\\Users\\icaro\\Desktop\\Pokemon\\Pokémon Resources\\PokemonImages\\play\\alola';
//   fs.readdir(path, (err, files) => {
//     files.forEach(file => {
//       if(file.indexOf(".png")  !== -1){

//         var number = file.replace("poke_capture_0","");
//         number = number.substring(0,3);
//         // console.log("file name is: " + file);
//         // console.log("number is: " + number );

//         var newname = number.toString();

//         // console.log("old name:" + file);
//         // //poke_capture_0003_000_fd_n_00000000_f_r.png

//         while (newname.length < 3) newname = "0" + newname;
        
//         newname = newname + "-alolan"

//         if (file.endsWith("_r.png")) {
//           newname = newname + "-shiny";
//         }else{
//           newname = newname + "-normal";
//         }

//         if (file.indexOf("_md_")  !== -1){//male
//           newname = newname + "-m.png";
//         }else if(file.indexOf("_fd_")  !== -1){ //female
//           newname = newname + "-f.png";
//         }else if(file.indexOf("_mf_")  !== -1 || file.indexOf("_mo_")  !== -1 || file.indexOf("_fo_")  !== -1) //both
//           newname = newname + "-mf.png";
//         else{ //genderless
//           newname = newname + "-g.png";
//         }

//         console.log("new name:" + newname);
//         fs.rename(path + '/' + file, path + '/' + newname, function(err) {
//           if ( err ) console.log('ERROR: ' + err);
//         });

//       }
//     });
//   });
// });
  
// test('Rename Data Giga', async ({ baseURL, page }) => {
//   var path = 'C:\\Users\\icaro\\Desktop\\Pokemon\\Pokémon Resources\\PokemonImages\\play\\giga';
//   fs.readdir(path, (err, files) => {
//     files.forEach(file => {
//       if(file.indexOf(".png")  !== -1){

//         var number = file.replace("poke_capture_0","");
//         number = number.substring(0,3);
//         // console.log("file name is: " + file);
//         // console.log("number is: " + number );

//         var newname = number.toString();

//         // console.log("old name:" + file);
//         // //poke_capture_0003_000_fd_n_00000000_f_r.png

//         while (newname.length < 3) newname = "0" + newname;
        
//         newname = newname + "-giga"

//         if (file.endsWith("_r.png")) {
//           newname = newname + "-shiny";
//         }else{
//           newname = newname + "-normal";
//         }

//         if (file.indexOf("_md_")  !== -1){//male
//           newname = newname + "-m.png";
//         }else if(file.indexOf("_fd_")  !== -1){ //female
//           newname = newname + "-f.png";
//         }else if(file.indexOf("_mf_")  !== -1 || file.indexOf("_mo_")  !== -1 || file.indexOf("_fo_")  !== -1) //both
//           newname = newname + "-mf.png";
//         else{ //genderless
//           newname = newname + "-g.png";
//         }

//         console.log("new name:" + newname);
//         fs.rename(path + '/' + file, path + '/' + newname, function(err) {
//           if ( err ) console.log('ERROR: ' + err);
//         });

//       }
//     });
//   });
// });

// test('Rename Data Forms', async ({ baseURL, page }) => {
//   var path = 'C:\\Users\\icaro\\Desktop\\Pokemon\\Pokémon Resources\\PokemonImages\\play\\forms';
//   var formNum = 1;
//   fs.readdir(path, (err, files) => {
//     files.forEach(file => {
//       if(file.indexOf(".png")  !== -1){
        
//         //"741-002-normal-mf.png"

//         var number = file.replace("poke_capture_0","");
//         number = number.substring(0,3);
//         // console.log("file name is: " + file);
//         // console.log("number is: " + number );

//         var newname = number.toString();

//         // console.log("old name:" + file);
//         // //poke_capture_0003_000_fd_n_00000000_f_r.png

//         while (newname.length < 3) newname = "0" + newname;
//         var form = formNum.toString();
//         while (form.length < 3) form = "0" + form;
//         newname = newname + "-" + form;

//         if (file.endsWith("_r.png")) {
//           newname = newname + "-shiny";
//         }else{
//           newname = newname + "-normal";
//         }

//         if (file.indexOf("_md_")  !== -1){//male
//           newname = newname + "-m.png";
//         }else if(file.indexOf("_fd_")  !== -1){ //female
//           newname = newname + "-f.png";
//         }else if(file.indexOf("_mf_")  !== -1 || file.indexOf("_mo_")  !== -1 || file.indexOf("_fo_")  !== -1) //both
//           newname = newname + "-mf.png";
//         else{ //genderless
//           newname = newname + "-g.png";
//         }

//         console.log("new name:" + newname);
//         fs.rename(path + '/' + file, path + '/' + newname, function(err) {
//           if ( err ) console.log('ERROR: ' + err);
//         });

//         if (file.endsWith("_r.png"))
//           formNum++;
//       }
//     });
//   });
// });