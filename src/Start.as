package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import flash.system.System;
	import org.flixel.plugin.photonstorm.FlxCollision;
	 
	/**
	 * Start
	 * @author 
	 */
	public class Start extends FlxState
	{
		[Embed(source = '../assets/gfx/ui/aith_logo.png')] protected var ImgLogo:Class;
		[Embed(source = '../assets/gfx/ui/cursor.png')] protected var ImgCursor:Class;
		[Embed(source = '../assets/fonts/Urban_slick.ttf',	fontFamily = "slick", embedAsCFF = "false")] protected var	Font:Class;
		public var logo:FlxSprite;
		public var cursor:FlxSprite;
		
		override public function create():void
		{
			
			FlxG.bgColor = 0xaa519CCA;
			// TITRE
			var title:FlxText = new FlxText(0, FlxG.height / 15, FlxG.width, "Aliens In The Hood");
			title.setFormat("slick", 42, 0x044071);
			title.alignment = "center";
			add(title);
			
			// LOGO
			logo = new FlxSprite(FlxG.width / 2, FlxG.height / 4, ImgLogo);
			logo.x -= logo.frameWidth / 2;
			add(logo);
			
			// CURSEUR SOURIS
			cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y, ImgCursor);
			add(cursor)
			FlxG.mouse.hide();
		}
		
		override public function update():void
		{
			cursor.x = FlxG.mouse.x - cursor.frameWidth/2;
			cursor.y = FlxG.mouse.y - cursor.frameHeight/2;
			super.update();
			
			// VERS CHOIX DE L'UNIVERS
			if (FlxG.mouse.justPressed()) {
				if (FlxCollision.pixelPerfectCheck(cursor, logo))
					FlxG.switchState(new UnivChooser());
			}
			// DEV : FERME LA FENETRE (à supprimer plus tard)
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
		}
	}
}
