const nba = require("nba-api-client");
const ObjectsToCsv = require('objects-to-csv');
const path = "C:\\Users\\Owner\\Desktop\\Test Data.csv"
const video = require("nba-pbp-video")

let team = "Los Angeles Lakers";
let bucks_id = nba.getTeamID(team).TeamID;
let DateFrom = "10/22/2019";
let DateTo = "11/22/2019";

//Game IDs
//let options = { formatted: true };
//let games = nba.leagueGameFinder({PlayerOrTeam: "T",DateFrom: DateFrom,DateTo: DateTo,TeamID: bucks_id,},options).then((data, err) => {
//    let games = [];
//    if (err) return console.log("Error: ", err);
//    else data = data.LeagueGameFinderResults;
//    
//    Object.values(data).forEach((val) => {
//      games.push(val.GAME_ID);
//    });
//
//    return games;
//  });
//
//  //Play by Play to CSV
//games.then((data) => {
//  
//  Object.values(data).forEach((val) => {
//
//    nba.playByPlay({ GameID: val }).then( (data) => {
//      
//      data = data.PlayByPlay;
//      var index = Object.keys(data).length;
//      var newArray = [];
//      for (i = 0; i < index; i++) {
//        newArray.push(data[i]);
//      }
//      new ObjectsToCsv(newArray).toDisk(path, { append: true });
//    });
//
//  });
//
//});
let game_id = '00'+ '21900' +'297'
let eventnum = 465

video.getPBPVideoURL({EventNum: eventnum, GameID: game_id}).then(function(data){
  console.log(data);
});