package ;

import flixel.system.FlxBasePreloader;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;

@:bitmap("assets/images/corebackground.png") class CoreBackground extends BitmapData {}

class Preloader extends FlxBasePreloader {
    public function new(MinDisplayTime:Float = 0)
    {
        super(0.5);
    }

    var bg:Sprite;
     
    override function create():Void 
    {
        this._width = 1440;
        this._height = 900;
         
        bg = new Sprite();
        var bitmap:Bitmap = new Bitmap(new CoreBackground(0,0));
        
        var scaleX:Float = this._width / bitmap.width;
        var scaleY:Float = this._height / bitmap.height;
        var scale:Float = Math.max(scaleX, scaleY);
        
        bitmap.scaleX = scale;
        bitmap.scaleY = scale;
        bitmap.x = (this._width - bitmap.width * scale) / 2;
        bitmap.y = (this._height - bitmap.height * scale) / 2;
        
        bg.addChild(bitmap);
        bg.x = 0;
        bg.y = 0;
        addChild(bg);
         
        super.create();
    }   
}
