package;

// Imports
import flixel

class PlayerState{

    // Player-specific variables
    var playerName:FlxText;

    var isMoving:Bool = false; // Add this line to track if the player is moving
    var shouldUpdateIdleDirection:Bool = false;
    var currentDirection:String = "idle_N"; // Default idle direction


}