package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

@:keep @:bitmap("assets/images/corebackground.png")
private class CoreBackground extends BitmapData {}

class Main extends Sprite
{
    var bg:Sprite;

    public function new()
    {
        super();

        // Set up the background image
        setupBackground();

        // Start the FlxGame
        addChild(new FlxGame(0, 0, PlayState, 60, 60, true, false));
    }

    function setupBackground():Void
    {
        // Get the stage width and height
        var stageWidth:Int = Std.int(Lib.current.stage.stageWidth);
        var stageHeight:Int = Std.int(Lib.current.stage.stageHeight);

        bg = new Sprite();

        // Create and scale the background bitmap
        var bitmap:Bitmap = new Bitmap(new CoreBackground(0, 0));
        var scaleX:Float = stageWidth / bitmap.width;
        var scaleY:Float = stageHeight / bitmap.height;
        var scale:Float = Math.max(scaleX, scaleY);

        bitmap.scaleX = scale;
        bitmap.scaleY = scale;
        bitmap.x = (stageWidth - bitmap.width * scale) / 2;
        bitmap.y = (stageHeight - bitmap.height * scale) / 2;

        // Add the background to the sprite
        bg.addChild(bitmap);
        bg.x = 0;
        bg.y = 0;

        // Add the background to the display list
        addChildAt(bg, 0);  // Make sure it's added at index 0 so it stays behind everything
    }
}
