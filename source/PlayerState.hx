package;

// Imports
import flixel

class PlayerState{

    // setup player-specific variables
    var player = {
        playerName: null;
        isClient: false;
        Enum playerAction {
            Idle;
            Moving;
            Sitting;
            Dancing;
            Waving(waveTimer:float);
            }

        playerOutfit:Object = {
            slotColor: null;
            slotHead: null;
            slotFace: null;
            slotNeck: null;
            slotBack: null;
            slotBody: null;
            slotFeet: null;
            slotPin: null;
            slotBackground: null;
            action: null;
        }

        playerLocation:Object = {
            Enum x: 0;
            Enum y: 0;
            Enum dir: 0;
        }

        
    }



    // PLAYER ACTIONS

    // function to update directwhen mouse moves into new-direction range


    function doWave(){
        player.playerAction = Waving();
        var waveDuration:Float = 1.33;
        // wave when W pressed or clicked on UI.
        // if outfit allows special wave, perform it. else standard wave
    }

    function doDance(){
        player.playerAction = "dance";
        // dance when D pressed or clicked on UI.
        // if outfit has special dance, perform that. else perform standard dance
    }

    function doSit(int dir){
        player.playerAction = "sit"
        // sit facing mouse (or last direction moved) when S pressed. pass in these directions
    }

    function movePlayer(Object target){
        player.playerAction = "walk"
        
        var difference:Object = {
            x:
            }

        // determine relative angles of player movement
        



    }

}