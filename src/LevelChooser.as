package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxSubState;
	import flash.system.System;
	import org.flixel.plugin.photonstorm.FlxCollision;
	 
	/**
	 * LEVEL
	 * @author 
	 */
	public class LevelChooser extends FlxState
	{
		[Embed(source = '../assets/gfx/replay.png')] protected var ImgReplay:Class;
		[Embed(source = '../assets/gfx/cursor.png')] protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/niveau1.png')] protected var ImgUni1:Class;
		[Embed(source = '../assets/gfx/niveau2.png')] protected var ImgUni2:Class;
		[Embed(source = '../assets/gfx/niveau3.png')] protected var ImgUni3:Class;
		[Embed(source = '../assets/fonts/Urban_slick.ttf',	fontFamily = "slick", embedAsCFF = "false")] protected var	Font:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")] protected var	Font3:Class;
		[Embed(source = '../assets/fonts/onedalism.ttf',	fontFamily = "onedalism", embedAsCFF = "false")] protected var	Font2:Class;
		public var replaypic:FlxSprite;
		public var cursor:FlxSprite;
		public var uni1:FlxSprite;
		public var uni2:FlxSprite;
		public var uni3:FlxSprite;
		
		override public function create():void
		{
			
			FlxG.bgColor = 0xaa519CCA;
			// TEXTE EXPLICATIF
			var title:FlxText = new FlxText(50, 50, FlxG.height*2 / 3, "Choisir un niveau");
			title.setFormat("onedalism", 50, 0x044071);
			add(title);
			
			// REPLAY
			replaypic = new FlxSprite(FlxG.width, 50, ImgReplay);
			replaypic.x -= replaypic.frameWidth +50;
			add(replaypic);
			var replaytext:FlxText = new FlxText(replaypic.x, replaypic.y +18, replaypic.frameWidth, "Retour");
			replaytext.setFormat("philly", 32, 0x044071);
			replaytext.alignment = "center";
			add(replaytext);			
			
			// LEVEL 1 IMAGE
			uni1 = new FlxSprite(50, FlxG.height /2, ImgUni1);
			add(uni1);
			
			// LEVEL 2 IMAGE
			uni2 = new FlxSprite(300, FlxG.height /2, ImgUni2);
			add(uni2);
			
			// LEVEL 3 IMAGE
			uni3 = new FlxSprite(550, FlxG.height /2, ImgUni3);
			add(uni3);
			
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
			
			// GESTION CLICS SOURIS
			if (FlxG.mouse.justPressed()) {
				// RETURN
				if (FlxCollision.pixelPerfectCheck(cursor, replaypic))
					FlxG.switchState(new UnivChooser());

				// NIVEAU 1
				if (FlxCollision.pixelPerfectCheck(cursor, uni1)) {
					FlxG.score = -1;
					FlxG.switchState(new Play());
				}

				// NIVEAU 2
				if (FlxCollision.pixelPerfectCheck(cursor, uni2)) {
					FlxG.score = -2;
					FlxG.switchState(new Play());
				}

				// NIVEAU 3
				if (FlxCollision.pixelPerfectCheck(cursor, uni3)) {
					FlxG.score = -3;
					FlxG.switchState(new Play());
				}
			}
			
			// DEV : FERME LA FENETRE (à supprimer plus tard)
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
		}
	}
}
