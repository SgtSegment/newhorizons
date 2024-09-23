package ;

import flixel.FlxG;
import flixel.system.FlxBasePreloader;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

@:keep @:bitmap("assets/images/corebackground.png")
private class CoreBackground extends BitmapData {}

class Preloader extends FlxBasePreloader
{
    public function new(MinDisplayTime:Float = 0)
    {
        super(0.5);
    }

    var bg:Sprite;

    override function create():Void 
    {
        // Use the stage width and height for responsiveness
        this._width = Std.int(Lib.current.stage.stageWidth);
        this._height = Std.int(Lib.current.stage.stageHeight);

        bg = new Sprite();
        
        // Use createBitmap function to handle asset loading
        var bitmap = createBitmap(CoreBackground, function(bmp:Bitmap)
        {
            var scaleX:Float = _width / bmp.width;
            var scaleY:Float = _height / bmp.height;
            var scale:Float = Math.max(scaleX, scaleY);
            
            bmp.scaleX = scale;
            bmp.scaleY = scale;
            bmp.x = (_width - bmp.width * scale) / 2;
            bmp.y = (_height - bmp.height * scale) / 2;
            
            bg.addChild(bmp);
        });

        bg.x = 0;
        bg.y = 0;
        addChild(bg);

        super.create();
    }   
}
