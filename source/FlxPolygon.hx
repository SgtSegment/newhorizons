package; // Keep this as the first line to avoid package errors

import flixel.math.FlxPoint;

class FlxPolygon {
    public var points:Array<FlxPoint>;

    public function new(points:Array<FlxPoint>) {
        this.points = points;
    }

    // Check if a point is inside the polygon (useful for collision detection)
    public function containsPoint(point:FlxPoint):Bool {
        var inside:Bool = false;
        var j:Int = points.length - 1;
        
        for (i in 0...points.length) {
            var pi:FlxPoint = points[i];
            var pj:FlxPoint = points[j];
            
            if (((pi.y > point.y) != (pj.y > point.y)) && 
                (point.x < (pj.x - pi.x) * (point.y - pi.y) / (pj.y - pi.y) + pi.x)) {
                inside = !inside;
            }
            j = i;
        }
        
        return inside;
    }
}
