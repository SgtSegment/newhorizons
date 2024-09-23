package; // This Haxeflixel game uses 5.8.0

//#region imports
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
//#endregion


class PlayState extends FlxState
{
//#region vars
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
    var player:FlxSprite;
    var playerCircle:FlxSprite;
    var target:FlxPoint; // Target position for the player
    var speed:Float = 200; // Speed of the player in pixels per second
    var someGraphic:FlxSprite; // Reference to the "someGraphic" sprite
    var uiCorner1:FlxSprite;
    var uiCorner2:FlxSprite;
    var uiCorner3:FlxSprite;
    var uiCorner4:FlxSprite;
    var tempInteractiveUI:FlxSprite;
    var playerName:FlxText;
    //#region
    // Heptagon player click stuff that didnt really work //private var heptagonGraphic:FlxSprite;
    //private var heptagonCenter:FlxPoint;
    //private var heptagonRadius:Float;
    //private var heptagonVertices:Array<FlxPoint>;
    //#endregion
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

        // Initialize "someGraphic" (always in front of background but behind player)
        someGraphic = new FlxSprite();
        someGraphic.loadGraphic("assets/images/someGraphic.png");
        someGraphic.centerOrigin();
        someGraphic.visible = false; // Initially invisible
        add(someGraphic);
        
        // Create the player circle that follows the player (on top of everything)
        playerCircle = new FlxSprite(100, 100);
        playerCircle.loadGraphic("assets/images/playercircle.png");
        playerCircle.centerOrigin();
        add(playerCircle);

        // Create the player (on top of everything except the circle)
        player = new FlxSprite(100, 100);
        player.frames = frames; //player.loadGraphic("assets/images/player.png");
        player.animation.addByPrefix("idle", "0_idle", 12, true); // '0_idle' is the prefix common in all frames
        player.animation.play("idle");
        player.centerOrigin();
        player.screenCenter();
        add(player);

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
        add(background02);

        // Beta banner
        beta = new FlxSprite(188, 56);
        beta.loadGraphic("assets/images/rooms/town/beta.png");
        
        beta.origin.set(beta.width / 2, beta.height / 2);
        
        beta.visible = true; // Make sure it's visible
        add(beta);

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

//#region
    // Heptagon player click stuff that didnt really work //    // Define the heptagon's center and radius
    //    heptagonCenter = new FlxPoint(25, 25); // Example center point
    //    heptagonRadius = 50; // Example radius
    //        
    //    // Calculate the heptagon vertices
    //    heptagonVertices = calculateHeptagonVertices(heptagonCenter, heptagonRadius);
    //        
    //    // Create a FlxSprite for visualizing the heptagon
    //    heptagonGraphic = new FlxSprite(heptagonCenter.x, heptagonCenter.y);
    //    heptagonGraphic.makeGraphic(1440, 900, 0x00000000); // Create a blank graphic
    //        
    //    // Draw the heptagon at the correct position
    //    drawHeptagon(heptagonGraphic);
    //        
    //    // Add the heptagon graphic to the state
    //    add(heptagonGraphic);
    //#endregion

//#region bg button code
        var button = new FlxButton((1440/2), 675, "Sky switch", onButtonClicked);
        add(button);
//#endregion
          
    }

//#region bg button code
    function onButtonClicked()
    {
        switch (skyState)
        {
            case 0:
                background00.visible = false;
                background00a.visible = true;
                background00b.visible = false;
                skyState = 1; // Move to the next state

            case 1:
                background00.visible = false;
                background00a.visible = false;
                background00b.visible = true;
                skyState = 2; // Move to the next state
            case 2:
                background00.visible = true;
                background00a.visible = false;
                background00b.visible = false;
                skyState = 0; // Loop back to the first state
        }
    }
//#endregion
    
    ///////// UPDATE /////////
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
    
        movePlayer(elapsed); // Update the player's position
    
        // Sort the render group by the y-position considering the origin
        renderGroup.members.sort(orderByY);

        if (FlxG.mouse.justPressed) {
            // Ensure mouse click is within the game window bounds
            if (FlxG.mouse.x >= 0 && FlxG.mouse.x <= FlxG.width && FlxG.mouse.y >= 0 && FlxG.mouse.y <= FlxG.height) {
                var clickX:Float = FlxG.mouse.x;
                var clickY:Float = FlxG.mouse.y;
    
                // Define the bounds
                var minX:Int = 182;
                var minY:Int = 819;
                var maxX:Int = 1257;
                var maxY:Int = 900;
    
                // Check if click is within the restricted bounds
                if (clickX < minX || clickX > maxX || clickY < minY || clickY > maxY) {
                    // If the click is outside the restricted area, set the target position
                    target.x = clickX - player.origin.x;
                    target.y = clickY - player.origin.y;
    
                    // Set the position of someGraphic to the click position
                    someGraphic.x = clickX - someGraphic.origin.x;
                    someGraphic.y = clickY - someGraphic.origin.y;
                    someGraphic.visible = true; // Make it visible when you click
                }
            }
        }
    
        // Make the player circle always follow the player
        playerCircle.x = player.x + ((player.width / 2) - (playerCircle.width / 2));
        playerCircle.y = player.y + ((player.height / 2) - (playerCircle.height / 2));
    
        // Update player name text position to follow the player
        var textWidth:Float = playerName.width;
        playerName.x = player.x - (textWidth / 2) + (player.width / 2);
        playerName.y = player.y + 150;

//#region
    // Heptagon player click stuff that didnt really work //    if (FlxG.mouse.justPressed) {
    //        var mouseX:Float = FlxG.mouse.x;
    //        var mouseY:Float = FlxG.mouse.y;
    //        trace("Mouse clicked at: x=" + mouseX + ", y=" + mouseY);
    //    
    //        if (isPointInPolygon(mouseX - heptagonCenter.x, mouseY - heptagonCenter.y, heptagonVertices)) {
    //            trace("Mouse click is inside the heptagon!");
    //        } else {
    //            trace("Mouse click is outside the heptagon.");
    //        }
    //    }
    //#endregion   

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
    

    private function movePlayer(elapsed:Float):Void {
        var direction:FlxPoint = new FlxPoint(target.x - player.x, target.y - player.y); // Calculate the direction towards the target
    
        var distance:Float = Math.sqrt(Math.pow(direction.x, 2) + Math.pow(direction.y, 2)); // Calculate distance to the target
    
        // Stop moving if the player is close enough to the target
        if (distance < 1) { // If distance is very small (within 1 pixel), stop the player
            player.x = target.x;
            player.y = target.y;
            return;
        }
    
        // Otherwise, move the player towards the target
        direction.normalize();
        player.x += direction.x * speed * elapsed;
        player.y += direction.y * speed * elapsed;
    
        // Optional: Hide the "someGraphic" sprite once the player reaches the target
        if (distance < speed * elapsed) {
            someGraphic.visible = false; // Hide the sprite when the player reaches the target
        }
    }
    
//#region
// Heptagon player click stuff that didnt really work //    private function drawHeptagon(graphic:FlxSprite):Void {
//        var canvas:BitmapData = graphic.pixels;
//        var width:Int = canvas.width;
//        var height:Int = canvas.height;
//    
//        // Clear the previous drawing
//        canvas.fillRect(new Rectangle(0, 0, width, height), 0x00000000); // Clear with transparent color
//    
//        // Draw heptagon
//        var vertices:Array<FlxPoint> = heptagonVertices;
//        
//        // Adjust vertices to be relative to the center of the heptagon
//        for (vertex in vertices) {
//            vertex.x += heptagonCenter.x; // Adjust x position
//            vertex.y += heptagonCenter.y; // Adjust y position
//        }
//    
//        var xMin:Float = vertices[0].x;
//        var xMax:Float = vertices[0].x;
//        var yMin:Float = vertices[0].y;
//        var yMax:Float = vertices[0].y;
//    
//        for (vertex in vertices) {
//            xMin = Math.min(xMin, vertex.x);
//            xMax = Math.max(xMax, vertex.x);
//            yMin = Math.min(yMin, vertex.y);
//            yMax = Math.max(yMax, vertex.y);
//        }
//    
//        for (x in Math.floor(xMin)...Math.ceil(xMax)) {
//            for (y in Math.floor(yMin)...Math.ceil(yMax)) {
//                if (isPointInPolygon(x - heptagonCenter.x, y - heptagonCenter.y, heptagonVertices)) {
//                    canvas.setPixel32(x, y, 0xFFFF0000); // Red fill
//                }
//            }
//        }
//    
//        graphic.pixels = canvas;
//    }    
//    
//    private function calculateHeptagonVertices(center:FlxPoint, radius:Float):Array<FlxPoint> {
//        var vertices:Array<FlxPoint> = [];
//        for (i in 0...7) {
//            var angle:Float = (Math.PI * 2 / 7) * i - Math.PI / 2; // Heptagon angles
//            var x:Float = center.x + Math.cos(angle) * radius;
//            var y:Float = center.y + Math.sin(angle) * radius;
//            vertices.push(new FlxPoint(x, y));
//        }
//        return vertices;
//    }
//
//    private function isPointInPolygon(px:Float, py:Float, vertices:Array<FlxPoint>):Bool {
//        var isInside:Bool = false;
//        var j:Int = vertices.length - 1;
//        for (i in 0...vertices.length) {
//            var vi:FlxPoint = vertices[i];
//            var vj:FlxPoint = vertices[j];
//            if ((vi.y > py) != (vj.y > py) && (px < (vj.x - vi.x) * (py - vi.y) / (vj.y - vi.y) + vi.x)) {
//                isInside = !isInside;
//            }
//            j = i;
//        }
//        return isInside;
//    }
//#endregion

}