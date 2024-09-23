package; // This Haxeflixel game uses 5.8.0
//#region imports
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;


import PlayerState.hx;

//#endregion

class PlayState extends FlxState
{
//#region vars
    var isMoving:Bool = false; // Add this line to track if the player is moving
    var shouldUpdateIdleDirection:Bool = false;
    var currentDirection:String = "idle_N"; // Default idle direction
    var mouseMovedSinceStop:Bool = false;
    var updateIdleDirection:Bool = false;
    private var previousSittingDirection:String = "";
    private var previousSittingAngle:Float = -1;    
    private var lastMouseX:Float = FlxG.mouse.x;
    private var lastMouseY:Float = FlxG.mouse.y;
    var newSittingDirection:String;
    var isSitting:Bool = false;
    var isDancing:Bool = false;
    var isWaving:Bool = false;
    var waveTimer:Float = 0;
    var waveDuration:Float = 1.33;
    var isSoftSitting:Bool = false;    
    var isIdleDirection:Bool = false; // Track if the player is in an idle direction
    var sittingDirection:String = "idle_S"; // Default sitting direction
    var background00:FlxSprite;
    var background00a:FlxSprite;
    var background00b:FlxSprite;
    var background01:FlxSprite;
    var beta:FlxSprite; //temp
    var background02:FlxSprite; //temp
    var background03:FlxSprite;
    var background04:FlxSprite;
    var background05:FlxSprite;
    var background06:FlxSprite;
    var background07:FlxSprite;
    var background08:FlxSprite;
    var background09:FlxSprite;
    var skyState:Int = 0;
    var playerClickCollision:FlxSprite;
    var player:FlxSprite;
    var playerCircle:FlxSprite;
    var target:FlxPoint; // Target position for the player
    var speed:Float = 200; // Speed of the player in pixels per second
    var targetCircle:FlxSprite; // Reference to the "targetCircle" sprite
    var uiCorner1:FlxSprite;
    var uiCorner2:FlxSprite;
    var uiCorner3:FlxSprite;
    var uiCorner4:FlxSprite;
    var tempInteractiveUI:FlxSprite;
    var playerName:FlxText;
    var renderGroup:FlxGroup;
//#endregion

    ///////// CREATE /////////
    override public function create():Void
    {
        super.create();
        
        FlxG.autoPause = false; // Disable automatic pausing when the window loses focus
        
        FlxG.mouse.useSystemCursor = true; // Use native system cursor instead of Haxeflixel's

//#region room gfx

        //// Town Room specific code ////

        // Room background - Sky color backdrop - second variant
        background00a = new FlxSprite(0, 0);
        background00a.loadGraphic("assets/images/rooms/sky00a.png");
        background00a.visible = false; // Initially invisible
        add(background00a);

        // Room background - Sky color backdrop - third variant
        background00b = new FlxSprite(0, 0);
        background00b.loadGraphic("assets/images/rooms/sky00b.png");
        background00b.visible = false; // Initially invisible
        add(background00b);

        // Room background - Sky color backdrop
        background00 = new FlxSprite(0, 0);
        background00.loadGraphic("assets/images/rooms/town/00.png");
        background00.visible = true; // Initially visible
        add(background00);

        // Room background
        background01 = new FlxSprite(0, 0);
        background01.loadGraphic("assets/images/rooms/town/01.png");
        add(background01);
        
//#endregion

        //// NOT Town Room code but necessary for layering for now with how it's implemented (bad? idk) ////

        // Load the texture atlas
        var graphic:FlxGraphic = FlxG.bitmap.add("assets/images/player/player.png");
        var frames:FlxAtlasFrames = FlxAtlasFrames.fromTexturePackerJson(graphic, "assets/images/player/player.json");

        // Initialize "targetCircle" (should be behind player but in front of backgrounds)
        targetCircle = new FlxSprite();
        targetCircle.loadGraphic("assets/images/targetcircle.png");
        targetCircle.centerOrigin();
        targetCircle.alpha = 1;
        targetCircle.visible = false; // Initially invisible
        add(targetCircle);
        
        // Create the player circle that follows the player (on top of everything)
        playerCircle = new FlxSprite(100, 100);
        playerCircle.loadGraphic("assets/images/playercircle.png");
        playerCircle.centerOrigin();
        add(playerCircle);

        // Create the player (on top of everything except the circle)
        player = new FlxSprite(100, 100);
        player.frames = frames; // Set the frames from your atlas //player.loadGraphic("assets/images/player.png");
        //player.animation.addByPrefix("idle", "0_idle", 12, true); // '0_idle' is the prefix common in all frames

        player.animation.add("idle_N", [0], 0, false);
        player.animation.add("idle_NW", [1], 0, false);
        player.animation.add("idle_W", [2], 0, false);
        player.animation.add("idle_SW", [3], 0, false);
        player.animation.add("idle_S", [4], 0, false);
        player.animation.add("idle_SE", [5], 0, false);
        player.animation.add("idle_E", [6], 0, false);
        player.animation.add("idle_NE", [7], 0, false);

        player.animation.add("walk_N", [8, 9, 10, 11, 12, 13, 14, 15], 13, true); 
        player.animation.add("walk_NW", [16, 17, 18, 19, 20, 21, 22, 23], 13, true); 
        player.animation.add("walk_W", [24, 25, 26, 27, 28, 29, 30, 31], 13, true); 
        player.animation.add("walk_SW", [32, 33, 34, 35, 36, 37, 38, 39], 13, true); 
        player.animation.add("walk_S", [40, 41, 42, 43, 44, 45, 46, 47], 13, true); 
        player.animation.add("walk_SE", [48, 49, 50, 51, 52, 53, 54, 55], 13, true); 
        player.animation.add("walk_E", [56, 57, 58, 59, 60, 61, 62, 63], 13, true); 
        player.animation.add("walk_NE", [64, 65, 66, 67, 68, 69, 70, 71], 13, true);

        player.animation.add("sit_N", [398,72], 13, false);
        player.animation.add("sit_NW", [400,73], 13, false);
        player.animation.add("sit_W", [402,74], 13, false);
        player.animation.add("sit_SW", [404,75], 13, false);
        player.animation.add("sit_S", [406,76], 13, false);
        player.animation.add("sit_SE", [408,77], 13, false);
        player.animation.add("sit_E", [410,78], 13, false);
        player.animation.add("sit_NE", [412,79], 13, false);

        player.animation.add("sit_N_ifidle", [397,398,72], 13, false);
        player.animation.add("sit_NW_ifidle", [399,400,73], 13, false);
        player.animation.add("sit_W_ifidle", [401,402,74], 13, false);
        player.animation.add("sit_SW_ifidle", [403,404,75], 13, false);
        player.animation.add("sit_S_ifidle", [405,406,76], 13, false);
        player.animation.add("sit_SE_ifidle", [407,408,77], 13, false);
        player.animation.add("sit_E_ifidle", [409,410,78], 13, false);
        player.animation.add("sit_NE_ifidle", [411,412,79], 13, false);
        
        player.animation.add("wave", [80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 88, 91, 91, 87, 88, 89, 90, 88, 91, 91, 87, 88, 89, 90, 88, 91, 91, 87, 88, 89, 90, 90, 90, 90], 13, false);

        player.animation.addByPrefix("dance", "4_dance", 13, true); 

        player.animation.play("idle_N");
        player.centerOrigin();
        player.screenCenter();
        add(player);

        // playerclick
        playerClickCollision = new FlxSprite(100, 100);
        playerClickCollision.loadGraphic("assets/images/player/collision.png");
        playerClickCollision.centerOrigin();
        playerClickCollision.visible = true;
        add(playerClickCollision);

        target = new FlxPoint(player.x, player.y); // Set the target to the player's position

        /// Back to Town room code ////

//#region room gfx 2

        //// Room objects ////

        // Nightclub entrance
        // Load the cropped image (one part of the background)
        background03 = new FlxSprite(594, 244);
        background03.loadGraphic("assets/images/rooms/town/03.png");
        
        // Set origin to center of the image or desired point
        background03.origin.set(background03.width / 2, background03.height / 1.13);
        
        background03.visible = true; // Make sure it's visible
        add(background03);

        // Gift shop ball box
        background04 = new FlxSprite(858, 369);
        background04.loadGraphic("assets/images/rooms/town/04.png");
        
        background04.origin.set(background04.width / 2, background04.height / 2);
        
        background04.visible = true; // Make sure it's visible
        add(background04);

        // Beta hat box
        background02 = new FlxSprite(764, 430);
        background02.loadGraphic("assets/images/rooms/town/02.png");
        
        background02.origin.set(background02.width / 2, background02.height / 2);
        
        background02.visible = true; // Make sure it's visible
        //add(background02);

        // Beta banner
        beta = new FlxSprite(188, 56);
        beta.loadGraphic("assets/images/rooms/town/beta.png");
        
        beta.origin.set(beta.width / 2, beta.height / 2);
        
        beta.visible = true; // Make sure it's visible
        //add(beta);

        // right chair
        background05 = new FlxSprite(382, 413);
        background05.loadGraphic("assets/images/rooms/town/05.png");
        
        background05.origin.set(background05.width / 2, background05.height / 2.5);
        
        background05.visible = true; // Make sure it's visible
        add(background05);

        // left chair
        background07 = new FlxSprite(322, 452);
        background07.loadGraphic("assets/images/rooms/town/07.png");
        
        background07.origin.set(background07.width / 2, background07.height / 2.3);
        
        background07.visible = true; // Make sure it's visible
        add(background07);

        // right table
        background08 = new FlxSprite(420, 420); // PEAK NUMBER??
        background08.loadGraphic("assets/images/rooms/town/08.png");
        
        background08.origin.set(background08.width / 2, background08.height / 1.6);
        
        background08.visible = true; // Make sure it's visible
        add(background08);

        // left table
        background06 = new FlxSprite(377, 465);
        background06.loadGraphic("assets/images/rooms/town/06.png");
        
        background06.origin.set(background06.width / 2, background06.height / 1.6);
        
        background06.visible = true; // Make sure it's visible
        add(background06);
        
//#endregion        

        // Create the group to hold the player and background03
        renderGroup = new FlxGroup();
        renderGroup.add(background03);
        renderGroup.add(background04);
        renderGroup.add(background02);
        renderGroup.add(background05);
        renderGroup.add(background07);
        renderGroup.add(background08);
        renderGroup.add(background06);
        renderGroup.add(player);
        
        // Add the group to the state so it can be updated and rendered
        add(renderGroup);

        // Room foreground
        background09 = new FlxSprite(0, 0);
        background09.loadGraphic("assets/images/rooms/town/09.png");
        add(background09);

        //// END of Town Room specific code ////

        // Create and add the text below the player
        playerName = new FlxText(0, 0, 0, "Penguin", 18);
        playerName.setFormat("Arial", 24, 0x000000, "center"); // Black color
        add(playerName);

//#region UI

        tempInteractiveUI = new FlxSprite(0, 0); // Adjust the positioning as needed
        tempInteractiveUI.loadGraphic("assets/images/interface_temp.png");
        add(tempInteractiveUI);

        // Adding the corner UI element
        uiCorner1 = new FlxSprite(-1, -1); // Adjust the positioning as needed
        uiCorner1.loadGraphic("assets/images/corner.png");
        add(uiCorner1);

        uiCorner2 = new FlxSprite(1425, -1); // Adjust the positioning as needed
        uiCorner2.loadGraphic("assets/images/corner.png");
        uiCorner2.angle = 90;
        add(uiCorner2);

        uiCorner3 = new FlxSprite(-1, 885); // Adjust the positioning as needed
        uiCorner3.loadGraphic("assets/images/corner.png");
        uiCorner3.angle = 270;
        add(uiCorner3);

        uiCorner4 = new FlxSprite(1425, 885); // Adjust the positioning as needed
        uiCorner4.loadGraphic("assets/images/corner.png");
        uiCorner4.angle = 180;
        add(uiCorner4);

//#endregion

//#region bg button code
//        var button = new FlxButton((1440/2), 675, "Sky switch", onButtonClicked);
//        add(button);
//#endregion
          
    }

//#region bg button code
//    function onButtonClicked()
//    {
//        switch (skyState)
//        {
//            case 0:
//                background00.visible = false;
//                background00a.visible = true;
//                background00b.visible = false;
//                skyState = 1; // Move to the next state
//
//            case 1:
//                background00.visible = false;
//                background00a.visible = false;
//                background00b.visible = true;
//                skyState = 2; // Move to the next state
//            case 2:
//                background00.visible = true;
//                background00a.visible = false;
//                background00b.visible = false;
//                skyState = 0; // Loop back to the first state
//        }
//    }
//#endregion
    
    ///////// UPDATE /////////
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    
        // Reset certain states when moving
        if (isMoving) {
            isDancing = false;
            isWaving = false;
            isSitting = false;       // Ensure sitting is stopped
            isSoftSitting = false;   // Ensure soft sitting is stopped
        }   
    
        if (FlxG.keys.justPressed.D && !isMoving) {
            if (!isDancing) {
                isDancing = true;
                isWaving = false;
                isSitting = false;
                isSoftSitting = false;
                player.animation.play("dance");
            } else {
                // Restart the dance animation
                player.animation.play("dance", true); // Force restart
            }
            return; // Exit early to prevent further updates
        }
    
        if (isDancing) {
            if (FlxG.keys.justPressed.W) {
                isDancing = false;
                isWaving = true;
                player.animation.play("wave");
                waveTimer = 0; // Reset the timer when starting waving
                return; // Exit early to prevent further updates
            } else if (FlxG.keys.justPressed.S) {
                isDancing = false;
                isSitting = true;
                setSittingDirection();
                return; // Exit early to prevent further updates
            } else if (FlxG.mouse.justPressed) {
                isDancing = false;
                var clickX:Float = FlxG.mouse.x;
                var clickY:Float = FlxG.mouse.y;
                var minX:Int = 182;
                var minY:Int = 819;
                var maxX:Int = 1257;
                var maxY:Int = 900;
    
                if (clickX < minX || clickX > maxX || clickY < minY || clickY > maxY) {
                    target.x = clickX - player.origin.x;
                    target.y = clickY - player.origin.y;
                    targetCircle.x = clickX - targetCircle.origin.x;
                    targetCircle.y = clickY - targetCircle.origin.y;
                    targetCircle.visible = true;
                    targetCircle.alpha = 1;
                    movePlayer(elapsed);
                }
                return; // Exit early to prevent further updates
            }
            return; // Exit early to keep dancing
        }
    
        if (FlxG.keys.justPressed.W && !isMoving) {
            if (!isWaving) {
                isWaving = true;
                player.animation.play("wave");
                waveTimer = 0; // Reset the timer when starting waving
            } else {
                // Restart the wave animation
                player.animation.play("wave", true); // Force restart
                waveTimer = 0; // Reset the timer when restarting waving
            }
            return; // Exit early to prevent further updates
        }
    
        if (isWaving) {
            waveTimer += elapsed;
            if (waveTimer >= waveDuration) {
                isWaving = false;
                currentDirection = "idle_N"; // Set currentDirection to "idle_N"
                player.animation.play(currentDirection);
                // Reset mouseMovedSinceStop to prevent immediate direction change
                mouseMovedSinceStop = false;
                lastMouseX = FlxG.mouse.x;
                lastMouseY = FlxG.mouse.y;
            }
        
            // Allow sitting to interrupt waving
            if (FlxG.keys.justPressed.S) {
                isWaving = false;
                isDancing = false;
                isSitting = true;
                isSoftSitting = false;
                setSittingDirection();
                targetCircle.visible = false;
                return; // Exit early to stop further updates
            }
        
            if (FlxG.mouse.justPressed) {
                isWaving = false; // Stop waving immediately
                var clickX:Float = FlxG.mouse.x;
                var clickY:Float = FlxG.mouse.y;
                var minX:Int = 182;
                var minY:Int = 819;
                var maxX:Int = 1257;
                var maxY:Int = 900;
        
                if (clickX < minX || clickX > maxX || clickY < minY || clickY > maxY) {
                    target.x = clickX - player.origin.x;
                    target.y = clickY - player.origin.y;
                    targetCircle.x = clickX - targetCircle.origin.x;
                    targetCircle.y = clickY - targetCircle.origin.y;
                    targetCircle.visible = true;
                    targetCircle.alpha = 1;
                    movePlayer(elapsed);
                }
            }
            return; // Exit early to keep waving
        }
    
        // Handle input for sitting and soft sitting
        if (FlxG.keys.justPressed.S && !isMoving) {
            // Enter sitting state only if not moving
            isSitting = true;
            isSoftSitting = false; // Ensure soft sitting is disabled
            previousSittingDirection = ""; // Reset previous sitting direction
            previousSittingAngle = -1;     // Reset previous angle
            setSittingDirection(false, true); // Pass forcePlay as true
            targetCircle.visible = false;
            return; // Exit early to prevent movement
        } else if ((FlxG.keys.pressed.A || FlxG.keys.pressed.Q) && !isMoving && !isSitting) {
            // Enter soft sitting state only if not moving and not sitting
            isSoftSitting = true;
            isSitting = false; // Ensure sitting is disabled
            setSittingDirection(true, true); // Force the animation to play
            return; // Exit early to prevent movement
        }
        
              
    
        // Handle sitting and soft sitting logic (remains the same)
        if (isSitting || isSoftSitting) {
            if (isSoftSitting) {
                if (FlxG.keys.pressed.A || FlxG.keys.pressed.Q) {
                    setSittingDirection(true, false); // Do not force play during soft sitting
                } else {
                    isSoftSitting = false;
                    mouseMovedSinceStop = false;
                }
            }
            
             else if (isSitting) {
                if (FlxG.keys.pressed.S) {
                    setSittingDirection(false, false); // Continue sitting without forcing animation
                } else if (FlxG.mouse.justPressed) {
                    isSitting = false;
                    previousSittingDirection = ""; // Reset previous sitting direction
                    previousSittingAngle = -1;     // Reset previous angle
                    // Handle movement initiation here...
                }
            }            
    
            if (FlxG.mouse.justPressed && !FlxG.keys.pressed.S && !FlxG.keys.pressed.A && !FlxG.keys.pressed.Q) {
                isSitting = false;
                isSoftSitting = false;
    
                var clickX:Float = FlxG.mouse.x;
                var clickY:Float = FlxG.mouse.y;
                var minX:Int = 182;
                var minY:Int = 819;
                var maxX:Int = 1257;
                var maxY:Int = 900;
    
                if (clickX < minX || clickX > maxX || clickY < minY || clickY > maxY) {
                    target.x = clickX - player.origin.x;
                    target.y = clickY - player.origin.y;
                    targetCircle.x = clickX - targetCircle.origin.x;
                    targetCircle.y = clickY - targetCircle.origin.y;
                    targetCircle.visible = true;
                    targetCircle.alpha = 1;
                }
    
                movePlayer(elapsed);
            }
            return; // Exit early to prevent further updates while sitting or soft sitting
        }
    
        movePlayer(elapsed);

        // Update idle animation based on currentDirection when not moving and not in other states
        if (!isMoving && !isDancing && !isWaving && !isSitting && !isSoftSitting) {
            updateIdleAnimation();
        }

    
        if (FlxG.mouse.justPressed) {
            if (FlxG.mouse.x >= 0 && FlxG.mouse.x <= FlxG.width && FlxG.mouse.y >= 0 && FlxG.mouse.y <= FlxG.height) {
                var clickX:Float = FlxG.mouse.x;
                var clickY:Float = FlxG.mouse.y;
                var minX:Int = 182;
                var minY:Int = 819;
                var maxX:Int = 1257;
                var maxY:Int = 900;

                var localX:Float = FlxG.mouse.x - playerClickCollision.x;
                var localY:Float = FlxG.mouse.y - playerClickCollision.y;

    
                if (clickX < minX || clickX > maxX || clickY < minY || clickY > maxY) {
                    target.x = clickX - player.origin.x;
                    target.y = clickY - player.origin.y;
                    targetCircle.x = clickX - targetCircle.origin.x;
                    targetCircle.y = clickY - targetCircle.origin.y;
                    targetCircle.visible = true;
                    targetCircle.alpha = 1;
                }

                // Ensure the mouse click is within the b﻿e mouse position in the collision graphic
                    var pixelColor:Int = playerClickCollision.pixels.getPixel(Std.int(localX), Std.int(localY));
                
                    // Check if the clicked pixel is green (#00FF00)
                    if (pixelColor == 0x00FF00) {
                        // Do something when the green pixel is clicked
                        trace("Green pixel clicked!");
                    }
                }
            }
        }
    
        playerCircle.x = player.x + ((player.width / 2) - (playerCircle.width / 2));
        playerCircle.y = player.y + ((player.height / 2) - (playerCircle.height / 2));

        playerClickCollision.x = player.x + ((player.width / 2) - (playerCircle.width / 2));
        playerClickCollision.y = player.y + ((player.height / 2) - (playerCircle.height / 2)) - 31;
    
        var textWidth:Float = playerName.width;
        playerName.x = player.x - (textWidth / 2) + (player.width / 2);
        playerName.y = player.y + 150;

        renderGroup.members.sort(orderByY);
    ﻿

    // Function to calculate and update the idle animation based on mouse position
    function updateIdleAnimation():Void {
        // Only update idle direction if mouse has moved
        if (FlxG.mouse.x != lastMouseX || FlxG.mouse.y != lastMouseY) {
            // Update last mouse positions
            lastMouseX = FlxG.mouse.x;
            lastMouseY = FlxG.mouse.y;
    
            // Set mouseMovedSinceStop to true
            mouseMovedSinceStop = true;
        }
    
        // Update idle direction only if mouse has moved since player stopped moving
        if (mouseMovedSinceStop) {
            // Calculate angle and update currentDirection
            var deltaX = FlxG.mouse.x - (player.x + player.width / 2);
            var deltaY = FlxG.mouse.y - (player.y + player.height / 2.75);
            var angle = Math.atan2(deltaY, deltaX) * (180 / Math.PI);
            if (angle < 0) angle += 360;
    
            if (angle >= 337.5 || angle < 22.5) {
                currentDirection = "idle_E";
            } else if (angle >= 22.5 && angle < 67.5) {
                currentDirection = "idle_NE";
            } else if (angle >= 67.5 && angle < 112.5) {
                currentDirection = "idle_N";
            } else if (angle >= 112.5 && angle < 157.5) {
                currentDirection = "idle_NW";
            } else if (angle >= 157.5 && angle < 202.5) {
                currentDirection = "idle_W";
            } else if (angle >= 202.5 && angle < 247.5) {
                currentDirection = "idle_SW";
            } else if (angle >= 247.5 && angle < 292.5) {
                currentDirection = "idle_S";
            } else if (angle >= 292.5 && angle < 337.5) {
                currentDirection = "idle_SE";
            }
    
            // Update the idle animation to the new direction
            player.animation.play(currentDirection);
        } else {
            // Ensure the player is using the correct idle animation
            if (player.animation.curAnim.name != currentDirection) {
                player.animation.play(currentDirection);
            }
        }
    }

    function setSittingDirection(isSoftSitting:Bool = false, forcePlay:Bool = false):Void {
        var deltaX = FlxG.mouse.x - (player.x + player.width / 2);
        var deltaY = FlxG.mouse.y - (player.y + player.height / 2.75);
        var angle = Math.atan2(deltaY, deltaX) * (180 / Math.PI);
        if (angle < 0) angle += 360;
    
        // Round the angle to minimize minor fluctuations
        var roundedAngle:Int = Math.round(angle);
    
        // Determine the sitting direction based on the rounded angle
        var newSittingDirection:String;
    
        if (roundedAngle >= 337 || roundedAngle < 22) {
            if (player.animation.curAnim.name == currentDirection) {
                newSittingDirection = "sit_E_ifi﻿fidle";
            } else { newSittingDirection = "sit_NE"; }
        } else if (roundedAngle >= 67 && roundedAngle < 112) {
            if (player.animation.curAnim.name == currentDirection) {
                newSittingDirection = "sit_N_ifidle";
            } else { newSittingDirection = "sit_N"; }
        } else if (roundedAngle >= 112 && roundedAngle < 157) {
            if (player.animation.curAnim.name == currentDirection) {
                newSittingDirection = "sit_NW_ifidle";
            } else { newSittingDirection = "sit_NW"; }
        } else if (roundedAngle >= 157 && roundedAngle < 202) {
            if (player.animation.curAnim.name == currentDirection) {
                newSittingDirection = "sit_W_ifidle";
            } else { newSittingDirection = "sit_W"; }
        } else if (roundedAngle >= 202 && roundedAngle < 247) {
            if (player.animation.curAnim.name == currentDirection) {
                newSittingDirection = "sit_SW_ifidle";
            } else { newSittingDirection = "sit_SW"; }
        } else if (roundedAngle >= 247 && roundedAngle < 292) {
            if (player.animation.curAnim.name == currentDirection) {
                newSittingDirection = "sit_S_ifidle";
            } else { newSittingDirection = "sit_S"; }
        } else if (roundedAngle >= 292 && roundedAngle < 337) {
            if (player.animation.curAnim.name == currentDirection) {
                newSittingDirection = "sit_SE_ifidle";
            } else { newSittingDirection = "sit_SE"; }
        } else {
            // In case none of the above conditions are met, keep the current sitting direction
            newSittingDirection = sittingDirection;
        }
    
        // Only play the animation if the sitting direction has changed or if forcePlay is true
        if (newSittingDirection != previousSittingDirection || forcePlay) {
            sittingDirection = newSittingDirection;
            previousSittingDirection = newSittingDirection;
            player.animation.play(sittingDirection); // Play the new animation
        }
        // Do nothing if the direction is the same and forcePlay is false to prevent animation restart
    }
    
    // Function to sort objects by Y value for draw order
    private function orderByY(a:FlxBasic, b:FlxBasic):Int {
        var spriteA:FlxSprite = cast a;
        var spriteB:FlxSprite = cast b;
    
        // Sort based on the y-position plus origin y
        var posA = spriteA.y + spriteA.origin.y;
        var posB = spriteB.y + spriteB.origin.y;
    
        if (posA < posB) return -1;
        if (posA > posB) return 1;
        return 0;
    }
    
    // Function to handle movement and animations when the player is walking
    private function movePlayer(elapsed:Float):V﻿ out to begin
        var fadeOutDistance:Float = 105;
        
        // Define a multiplier to make the fade out happen faster
        var fadeMultiplier:Float = 3; // Increase this value to make it fade faster
    
        // Check if the player is close enough for the fade-out effect
        if (distance < fadeOutDistance && targetCircle.alpha > 0) { // Only fade if alpha is greater than 0
            // Fade out faster using the multiplier
            targetCircle.alpha = Math.max(0, (distance / fadeOutDistance) * fadeMultiplier);
    
            // Clamp the alpha value to a maximum of 1
            targetCircle.alpha = Math.min(targetCircle.alpha, 1);
    
            // Once alpha reaches 0, we hide the targetCircle
            if (targetCircle.alpha == 0) {
                targetCircle.visible = false;
            }
        }

        if (distance < speed * elapsed) {﻿
        }
    
        direction.normalize();
        player.x += direction.x * speed * elapsed;
        player.y += direction.y * speed * elapsed;
        isMoving = true;
    
        var moveAngle:Float = Math.atan2(direction.y, direction.x) * (180 / Math.PI);
        if (moveAngle < 0) moveAngle += 360;
    
        // Determine walking animation and update currentDirection
        if (moveAngle >= 337.5 || moveAngle < 22.5) {
            player.animation.play("walk_E");
            currentDirection = "idle_E";﻿
        } else if (moveAngle >= 22.5 && moveAngle < 67.5) {
            player.animation.play("walk_NE");
            currentDirection = "idle_NE";
        } else if (moveAngle >= 67.5 && moveAngle < 112.5) {
            player.animation.play("walk_N");
            currentDirection = "idle_N";
        } else if (moveAngle >= 112.5 && moveAngle < 157.5) {
            player.animation.play("walk_NW");
            currentDirection = "idle_NW";
        } else if (moveAngle >= 157.5 && moveAngle < 202.5) {
            player.animation.play("walk_W");
            currentDirection = "idle_W";
        } else if (moveAngle >= 202.5 && moveAngle < 247.5) {
            player.animation.play("walk_SW");
            currentDirection = "idle_SW";
        } else if (moveAngle >= 247.5 && moveAngle < 292.5) {
            player.animation.play("walk_S");
            currentDirection = "idle_S";
        } else if (moveAngle >= 292.5 && moveAngle < 337.5) {
            player.animation.play("walk_SE");
            currentDirection = "idle_SE";
        }
    }   