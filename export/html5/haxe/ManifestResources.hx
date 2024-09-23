package;

import haxe.io.Bytes;
import haxe.io.Path;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos || webassembly)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif (console || sys)
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		data = '{"name":null,"assets":"aoy4:pathy32:assets%2Fimages%2Fbackground.pngy4:sizei1039662y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y36:assets%2Fimages%2Fcorebackground.pngR2i1284663R3R4R5R7R6tgoR0y28:assets%2Fimages%2Fcorner.pngR2i260R3R4R5R8R6tgoR0y36:assets%2Fimages%2Finterface_temp.pngR2i60978R3R4R5R9R6tgoR0y40:assets%2Fimages%2Fplayer%2Fcollision.pngR2i307R3R4R5R10R6tgoR0y38:assets%2Fimages%2Fplayer%2Fplayer.jsonR2i87847R3y4:TEXTR5R11R6tgoR0y37:assets%2Fimages%2Fplayer%2Fplayer.pngR2i394759R3R4R5R13R6tgoR0y28:assets%2Fimages%2Fplayer.pngR2i6582R3R4R5R14R6tgoR0y34:assets%2Fimages%2Fplayercircle.pngR2i1822R3R4R5R15R6tgoR0y35:assets%2Fimages%2Frooms%2Fsky00.pngR2i3284R3R4R5R16R6tgoR0y36:assets%2Fimages%2Frooms%2Fsky00a.pngR2i74534R3R4R5R17R6tgoR0y36:assets%2Fimages%2Frooms%2Fsky00b.pngR2i182691R3R4R5R18R6tgoR0y39:assets%2Fimages%2Frooms%2Ftown%2F00.pngR2i11228R3R4R5R19R6tgoR0y40:assets%2Fimages%2Frooms%2Ftown%2F00a.pngR2i74534R3R4R5R20R6tgoR0y40:assets%2Fimages%2Frooms%2Ftown%2F00b.pngR2i182691R3R4R5R21R6tgoR0y39:assets%2Fimages%2Frooms%2Ftown%2F01.pngR2i591266R3R4R5R22R6tgoR0y39:assets%2Fimages%2Frooms%2Ftown%2F02.pngR2i7819R3R4R5R23R6tgoR0y39:assets%2Fimages%2Frooms%2Ftown%2F03.pngR2i14942R3R4R5R24R6tgoR0y39:assets%2Fimages%2Frooms%2Ftown%2F04.pngR2i13467R3R4R5R25R6tgoR0y39:assets%2Fimages%2Frooms%2Ftown%2F05.pngR2i4140R3R4R5R26R6tgoR0y39:assets%2Fimages%2Frooms%2Ftown%2F06.pngR2i9751R3R4R5R27R6tgoR0y39:assets%2Fimages%2Frooms%2Ftown%2F07.pngR2i4659R3R4R5R28R6tgoR0y39:assets%2Fimages%2Frooms%2Ftown%2F08.pngR2i6534R3R4R5R29R6tgoR0y39:assets%2Fimages%2Frooms%2Ftown%2F09.pngR2i113025R3R4R5R30R6tgoR0y41:assets%2Fimages%2Frooms%2Ftown%2Fbeta.pngR2i59477R3R4R5R31R6tgoR0y46:assets%2Fimages%2Frooms%2Ftown%2Fcollision.bmpR2i162062R3R4R5R32R6tgoR0y47:assets%2Fimages%2Frooms%2Ftown%2Fcollision.jsonR2i8523R3R12R5R33R6tgoR0y48:assets%2Fimages%2Frooms%2Ftown%2Fdoor_coffee.pngR2i6247R3R4R5R34R6tgoR0y46:assets%2Fimages%2Frooms%2Ftown%2Fdoor_gift.pngR2i14642R3R4R5R35R6tgoR0y34:assets%2Fimages%2Ftargetcircle.pngR2i1833R3R4R5R36R6tgoR2i8220R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3y9:pathGroupaR38y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R37R5y28:flixel%2Fsounds%2Fflixel.mp3R39aR41y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i6840R3y5:SOUNDR5R40R39aR38R40hgoR2i33629R3R43R5R42R39aR41R42hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R44R45y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i277R3R4R5R50R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i203R3R4R5R51R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

	}


}

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_corebackground_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_corner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_interface_temp_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_player_collision_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_player_player_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_player_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_playercircle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_sky00_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_sky00a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_sky00b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_00_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_00a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_00b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_01_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_02_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_03_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_04_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_05_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_06_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_07_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_08_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_09_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_beta_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_collision_bmp extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_collision_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_door_coffee_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_door_gift_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_targetcircle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:image("assets/images/background.png") @:noCompletion #if display private #end class __ASSET__assets_images_background_png extends lime.graphics.Image {}
@:keep @:image("assets/images/corebackground.png") @:noCompletion #if display private #end class __ASSET__assets_images_corebackground_png extends lime.graphics.Image {}
@:keep @:image("assets/images/corner.png") @:noCompletion #if display private #end class __ASSET__assets_images_corner_png extends lime.graphics.Image {}
@:keep @:image("assets/images/interface_temp.png") @:noCompletion #if display private #end class __ASSET__assets_images_interface_temp_png extends lime.graphics.Image {}
@:keep @:image("assets/images/player/collision.png") @:noCompletion #if display private #end class __ASSET__assets_images_player_collision_png extends lime.graphics.Image {}
@:keep @:file("assets/images/player/player.json") @:noCompletion #if display private #end class __ASSET__assets_images_player_player_json extends haxe.io.Bytes {}
@:keep @:image("assets/images/player/player.png") @:noCompletion #if display private #end class __ASSET__assets_images_player_player_png extends lime.graphics.Image {}
@:keep @:image("assets/images/player.png") @:noCompletion #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:keep @:image("assets/images/playercircle.png") @:noCompletion #if display private #end class __ASSET__assets_images_playercircle_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/sky00.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_sky00_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/sky00a.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_sky00a_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/sky00b.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_sky00b_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/00.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_00_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/00a.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_00a_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/00b.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_00b_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/01.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_01_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/02.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_02_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/03.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_03_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/04.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_04_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/05.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_05_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/06.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_06_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/07.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_07_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/08.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_08_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/09.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_09_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/beta.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_beta_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/collision.bmp") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_collision_bmp extends lime.graphics.Image {}
@:keep @:file("assets/images/rooms/town/collision.json") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_collision_json extends haxe.io.Bytes {}
@:keep @:image("assets/images/rooms/town/door_coffee.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_door_coffee_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/town/door_gift.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_town_door_gift_png extends lime.graphics.Image {}
@:keep @:image("assets/images/targetcircle.png") @:noCompletion #if display private #end class __ASSET__assets_images_targetcircle_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/5,8,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/5,8,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/5,8,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/5,8,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/5,8,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/5,8,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end