package penguin;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class PenguinControllable extends Penguin {
    // Sprite state.
    private var targetSprite: FlxSprite;
    private var circleSprite: FlxSprite;
    private var clickCollisionSprite: FlxSprite;

    // Constructor.
    override public function new(X: Float, Y: Float) {
        if (sprites == null) sprites = new Array<FlxSprite>();

        loadTargetSprite(X, Y);
        loadCircleSprite(X, Y);
        loadClickCollisionSprite(X, Y);

        super(X, Y);

    }

    // General updates.
    override public function update(elapsed: Float): Void {
        handleInput();
        super.update(elapsed);

        circleSprite.x = penguinSprite.x + ((penguinSprite.width / 2) - (circleSprite.width / 2));
        circleSprite.y = penguinSprite.y + ((penguinSprite.height / 2) - (circleSprite.height / 2));

        clickCollisionSprite.x = penguinSprite.x + ((penguinSprite.width / 2) - (circleSprite.width / 2));
        clickCollisionSprite.y = penguinSprite.y + ((penguinSprite.height / 2) - (circleSprite.height / 2)) - 31;
    }

    // Action setters.
    override public function setIdle(direction: CardinalDirection) {
        targetSprite.visible = false;

        super.setIdle(direction);
    }
    override public function setMoving(goalX: Float, goalY: Float) {
        final min: FlxPoint = FlxPoint.get( 182, 819);
        final max: FlxPoint = FlxPoint.get(1257, 900);

        if (goalX > min.x && goalX < max.x && goalY > min.x && goalY < max.y) {
            targetSprite.x = goalX - targetSprite.origin.x;
            targetSprite.y = goalY - targetSprite.origin.y;
            targetSprite.visible = true;
            targetSprite.alpha = 1;

            super.setMoving(goalX, goalY);
        }
    }

    // Handle keyboard input.
    private function handleInput(): Void {
        if (FlxG.keys.justPressed.W) setWaving();
        if (FlxG.keys.justPressed.S) setSitting(South);
        if (FlxG.keys.justPressed.D) setDancing();
        if (FlxG.mouse.justPressed) setMoving(FlxG.mouse.x, FlxG.mouse.y);
    }

    // Load the target sprite related stuff.
    private function loadTargetSprite(X: Float, Y: Float): Void {
        targetSprite = new FlxSprite();
        targetSprite.loadGraphic("assets/images/targetcircle.png");
        targetSprite.centerOrigin();
        targetSprite.alpha = 1;
        targetSprite.visible = false; // Initially invisible
        addSprite(targetSprite);
    }

    // Load the circle sprite related stuff.
    private function loadCircleSprite(X: Float, Y: Float): Void {
        circleSprite = new FlxSprite(X, Y);
        circleSprite.loadGraphic("assets/images/playercircle.png");
        circleSprite.centerOrigin();
        addSprite(circleSprite);
    }

    // Load the click collisions sprite related stuff.
    private function loadClickCollisionSprite(X: Float, Y: Float): Void {
        clickCollisionSprite = new FlxSprite(X, Y);
        clickCollisionSprite.loadGraphic("assets/images/player/collision.png");
        clickCollisionSprite.centerOrigin();
        clickCollisionSprite.visible = true;
        addSprite(clickCollisionSprite);
    }
}
