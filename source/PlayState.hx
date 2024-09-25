package;

import flixel.FlxG;
import flixel.FlxState;

import rooms.TownRoom;

class PlayState extends FlxState {
    // TODO(mvh): Eventually handle things like the play/create penguin screen here.
    //            But for now it just automatically switches to the town room.

    ///////// CREATE /////////
    override public function create(): Void {
        super.create();

        FlxG.autoPause = false; // Disable automatic pausing when the window loses focus
        FlxG.mouse.useSystemCursor = true; // Use native system cursor instead of Haxeflixel's

        // Change the active room/scene.
        FlxG.switchState(TownRoom.new);
    }

    ///////// UPDATE /////////
    override public function update(elapsed: Float): Void {
        super.update(elapsed);

        // Change the active room/scene.
        FlxG.switchState(TownRoom.new);
    }
}
