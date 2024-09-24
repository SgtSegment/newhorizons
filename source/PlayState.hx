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

import penguin.Penguin;
import penguin.PenguinControllable;

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
    var penguin: Penguin;
    var uiCorner1:FlxSprite;
    var uiCorner2:FlxSprite;
    var uiCorner3:FlxSprite;
    var uiCorner4:FlxSprite;
    var tempInteractiveUI:FlxSprite;
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
        // NOTE(mvh): Yeah, some of this stuff should probably be extracted to a separate class.
        //            Maybe a Room class?  And you have one instance per room.

        penguin = new PenguinControllable(100, 100);
        for (sprite in penguin.getSprites()) {
            add(sprite);
        }

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
        renderGroup.add(penguin.getPenguinSprite());
        
        // Add the group to the state so it can be updated and rendered
        add(renderGroup);

        // Room foreground
        background09 = new FlxSprite(0, 0);
        background09.loadGraphic("assets/images/rooms/town/09.png");
        add(background09);

        //// END of Town Room specific code ////

        add(penguin.getPenguinName());

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
    }

    ///////// UPDATE /////////
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        penguin.update(elapsed);

        renderGroup.members.sort(orderByY);
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
    
}
