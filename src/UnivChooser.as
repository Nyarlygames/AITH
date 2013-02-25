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
	 * UNIVERS
	 * @author 
	 */
	public class UnivChooser extends FlxState
	{
		[Embed(source = '../assets/gfx/ui/btn_replay.png')] protected var ImgReplay:Class;
		[Embed(source = '../assets/gfx/ui/cursor.png')] protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/univ_1.png')] protected var ImgUni1:Class;
		[Embed(source = '../assets/gfx/ui/univ_2.png')] protected var ImgUni2:Class;
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
			var title:FlxText = new FlxText(50, 50, FlxG.height*2 / 3, "Les aliens ont envahi la terre et veulent nous détruire! Aidez Jimi à leur botter le train hors de notre belle planète");
			title.setFormat("onedalism", 22, 0x044071);
			add(title);
			
			// REPLAY
			replaypic = new FlxSprite(FlxG.width, 50, ImgReplay);
			replaypic.x -= replaypic.frameWidth +50;
			add(replaypic);
			var replaytext:FlxText = new FlxText(replaypic.x, replaypic.y +18, replaypic.frameWidth, "Replay");
			replaytext.setFormat("philly", 32, 0x044071);
			replaytext.alignment = "center";
			add(replaytext);			
			
			// UNIVERS 1 IMAGE
			uni1 = new FlxSprite(150, FlxG.height /2, ImgUni1);
			add(uni1);
			
			// UNIVERS 2 IMAGE
			uni2 = new FlxSprite(450, FlxG.height /2, ImgUni2);
			add(uni2);
			
			//SCORE 1
			var uni1text:FlxText = new FlxText(uni1.x + uni1.frameWidth/5, uni1.y + uni1.frameHeight /2, uni1.frameWidth, "0");
			uni1text.setFormat("slick", 32, 0x044071);
			add(uni1text);	
			
			//TOTAL 1
			var uni1text2:FlxText = new FlxText(uni1.x, uni1.y + uni1.frameHeight *4/5, uni1.frameWidth *4/5, "15");
			uni1text2.setFormat("slick", 32, 0x044071);
			uni1text2.alignment = "right";
			add(uni1text2);		
			
			
			//SCORE 2
			var uni2text:FlxText = new FlxText(uni2.x + uni2.frameWidth*2/5, uni2.y + uni2.frameHeight /2, uni2.frameWidth, "0");
			uni2text.setFormat("slick", 32, 0x044071);
			add(uni2text);	
			
			//TOTAL 2
			var uni2text2:FlxText = new FlxText(uni2.x, uni2.y + uni2.frameHeight *4/5, uni2.frameWidth *4/5, "13");
			uni2text2.setFormat("slick", 32, 0x044071);
			uni2text2.alignment = "right";
			add(uni2text2);	
			
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
				//REPLAY
				if (FlxCollision.pixelPerfectCheck(cursor, replaypic))
					FlxG.switchState(new Start());

				//UNIVERS 1
				if (FlxCollision.pixelPerfectCheck(cursor, uni1)) {
					FlxG.univ = 1;
					FlxG.switchState(new LevelChooser());
				}

				//UNIVERS 2
				if (FlxCollision.pixelPerfectCheck(cursor, uni2)) {
					FlxG.univ = 2;
					FlxG.switchState(new LevelChooser());
				}
			}
			
			if (FlxG.keys.justPressed("ONE") || FlxG.keys.justPressed("NUMPADONE")) {
					FlxG.univ = 1;
					FlxG.switchState(new LevelChooser());
			}
			
			if (FlxG.keys.justPressed("TWO") || FlxG.keys.justPressed("NUMPADTWO")) {
					FlxG.univ = 2;
					FlxG.switchState(new LevelChooser());
			}
			
			// DEV : FERME LA FENETRE (à supprimer plus tard)
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
		}
	}
}
