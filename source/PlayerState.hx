package;

// Imports
import flixel

class PlayerState{

    // Player-specific variables
    var playerName:FlxText;
    
    var isSitting:Bool = false;
    var isDancing:Bool = false;
    var isWaving:Bool = false;
    var isMoving:Bool = false;
    
    var shouldUpdateIdleDirection:Bool = false;
    var playerLocation:Object = {0, 0, 0};
    var playerAction:String = "idle";
    
    var playerOutfit:Object = {};
    var playerOutfitAction;


    // actions

    function doWave(){
        // wave when W pressed or clicked on UI.
        // if outfit allows special wave, perform it. else standard wave
    }

    function doDance(){
        // dance when D pressed or clicked on UI.
        // if outfit has special dance, perform that. else perform standard dance
    }

    function movePlayer(){

    }

}