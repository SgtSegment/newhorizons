package;

import haxe.Json;
import haxe.ds.StringMap;
import flixel.FlxSprite;
import openfl.utils.Assets;

class RoomAsset {
    public var name: String;
    public var sprite: FlxSprite;
    public function new(assetName: String, assetSprite: FlxSprite) {
        name = assetName;
        sprite = assetSprite;
    }
}

class RoomAssetLoader {
    private var assets: Array<RoomAsset>;

    public function new(): Void {
        assets = new Array<RoomAsset>();
    }

    // Get an array of the assets.
    public function getAssets(): Array<RoomAsset> {
        return assets;
    }

    // Get a specific sprite.
    public function getSprite(name: String): FlxSprite {
        for (asset in assets) {
            if (asset.name == name) return asset.sprite;
        }
        return null;
    }

    // Load a JSON file specifying sprites.
    // It's first in first out ordering.
    public function loadSprites(jsonPath: String): Bool {
        var content: String = Assets.getText(jsonPath);
        var assetsConfig: Array<Dynamic> = Json.parse(content);

        for (asset in assetsConfig) {
            if (asset.name == null) continue;
            if (asset.path == null) continue;

            var sprite = new FlxSprite(asset.x ?? 0, asset.y ?? 0);
            sprite.loadGraphic(asset.path);
            sprite.visible = asset.visible ?? true;

            if (asset.centered) {
                var width = asset.centeredWidth ?? 2;
                var height = asset.centeredHeight ?? 2;

                sprite.origin.set(sprite.width / width, sprite.height / height);
            }

            if (asset.angle != null) sprite.angle = asset.angle;

            assets.push(new RoomAsset(asset.name, sprite));
        }

        return true;
    }
}
