/* 

i havent done haxe in a long time so sorry if this code is sh*t

<TO DO IN THIS FILE>
- write numBypassChecker()
- improve optimization i guess

*/

package utils;

import flixel.FlxG;
import openfl.utils.Assets;
import haxe.Json;

class ChatFilter {
    public static function filter(msg : String) { // returns true if no filtered words; otherwise false
        // feel like yandaredev with this optimization
        var _filtered = Json.parse(Assets.getText("assets/data/filter.json"));
        for (i in 0..._filtered.length) {
            if (_filtered[i] == msg.toLowerCase())
                return false;
            if (numBypassChecker(msg.toLowerCase()))
                return false;
            if (_filtered[i].indexOf(" ") != -1) {
                var spaceSplit = _filtered[i].split(" ");
                if (spaceSplit.contains(msg.toLowerCase()))
                    return false;
                for (x in 0...spaceSplit.length) {
                    if (numBypassChecker(spaceSplit[x]))
                        return false;
                }
            }
        }
        return true;
    }

    private static function numBypassChecker(str : String) {
        return false;
    }
}