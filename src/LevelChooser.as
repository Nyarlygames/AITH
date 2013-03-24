package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxSubState;
	import flash.system.System;
	import com.greensock.*;
	import com.greensock.easing.*;
	import org.flixel.plugin.photonstorm.FlxCollision;
	 
	/**
	 * LEVEL
	 * @author 
	 */
	public class LevelChooser extends FlxState
	{
		[Embed(source = '../assets/gfx/ui/btn_menu.png')] 		protected var ImgReplay:Class;
		[Embed(source = '../assets/gfx/ui/btn_menu_on.png')] 	protected var ImgReplayOn:Class;
		[Embed(source = '../assets/gfx/ui/background-default.png')] 	protected var ImgBackDefault:Class;
		[Embed(source = '../assets/gfx/ui/cursor.png')] 		protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/cursor_anim.png')]	protected var ImgCursorAnim:Class;
		[Embed(source = '../assets/gfx/ui/exte_niv1.png')] 		protected var ImgLevel1:Class;
		[Embed(source = '../assets/gfx/ui/exte_niv2.png')] 		protected var ImgLevel2:Class;
		[Embed(source = '../assets/gfx/ui/exte_niv3.png')] 		protected var ImgLevel3:Class;
		[Embed(source = '../assets/gfx/ui/vaiss_niv1.png')] 	protected var ImgLevel4:Class;
		[Embed(source = '../assets/gfx/ui/vaiss_niv2.png')] 	protected var ImgLevel5:Class;
		[Embed(source = '../assets/gfx/ui/vaiss_niv3.png')] 	protected var ImgLevel6:Class;
		[Embed(source = '../assets/gfx/ui/exte_niv1_on.png')] 	protected var ImgLevel1On:Class;
		[Embed(source = '../assets/gfx/ui/exte_niv2_on.png')]	protected var ImgLevel2On:Class;
		[Embed(source = '../assets/gfx/ui/exte_niv3_on.png')] 	protected var ImgLevel3On:Class;
		[Embed(source = '../assets/gfx/ui/vaiss_niv1_on.png')]	protected var ImgLevel4On:Class;
		[Embed(source = '../assets/gfx/ui/vaiss_niv2_on.png')] 	protected var ImgLevel5On:Class;
		[Embed(source = '../assets/gfx/ui/vaiss_niv3_on.png')] 	protected var ImgLevel6On:Class;
		[Embed(source = '../assets/fonts/Urban_slick.ttf',	fontFamily = "slick", embedAsCFF = "false")] protected var	Font:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")] protected var	Font3:Class;
		[Embed(source = '../assets/fonts/onedalism.ttf',	fontFamily = "onedalism", embedAsCFF = "false")] protected var	Font2:Class;
		
		public var replaypic:FlxSprite;
		public var cursor:FlxSprite;
		public var level1:FlxSprite;
		public var backDefault:FlxSprite;
		public var level2:FlxSprite;
		public var level3:FlxSprite;
		
		override public function create():void
		{
			
			FlxG.bgColor = 0xaa519CCA;
			// TEXTE EXPLICATIF
			var title:FlxText = new FlxText(50, 50, FlxG.height*2 / 3, "Choisir un niveau");
			title.setFormat("onedalism", 50, 0x044071);
			add(title);
			
			//Back
			backDefault = new FlxSprite(490, 245, ImgBackDefault);
			backDefault.x = 0;
			backDefault.y = 0;
			add (backDefault);
			
			// REPLAY
			replaypic = new FlxSprite(FlxG.width, 50, ImgReplay);
			replaypic.x -= replaypic.frameWidth +50;
			add(replaypic);
			var replaytext:FlxText = new FlxText(replaypic.x, replaypic.y +18, replaypic.frameWidth, "Retour");
			replaytext.setFormat("philly", 32, 0x044071);
			replaytext.alignment = "center";
			add(replaytext);			
			
			// LEVEL 1 IMAGE
			level1 = new FlxSprite(50, FlxG.height /2);
			// LEVEL 2 IMAGE
			level2 = new FlxSprite(300, FlxG.height /2);
			// LEVEL 3 IMAGE
			level3 = new FlxSprite(550, FlxG.height / 2);
			
			if (FlxG.univ == 1) {
				level1.loadGraphic(ImgLevel1);
				level2.loadGraphic(ImgLevel2);
				level3.loadGraphic(ImgLevel3);
			}
			else {
				level1.loadGraphic(ImgLevel4);
				level2.loadGraphic(ImgLevel5);
				level3.loadGraphic(ImgLevel6);
			}
			
			
			add(level1);
			add(level2);			
			add(level3);
			
			// CURSEUR SOURIS
			cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			cursor.loadGraphic(ImgCursorAnim, true, false, 40, 40);
			cursor.addAnimation("souris", [0, 1, 2, 3], 8, true);
			cursor.play("souris");
			add(cursor)
			FlxG.mouse.hide();
		}
		

		override public function update():void
		{
			cursor.x = FlxG.mouse.x - cursor.frameWidth/2;
			cursor.y = FlxG.mouse.y - cursor.frameHeight/2;
			super.update();
			
			// RETURN
			if (FlxCollision.pixelPerfectCheck(cursor, replaypic)) {
				replaypic.loadGraphic(ImgReplayOn);
				if (FlxG.mouse.justPressed())
					FlxG.switchState(new UnivChooser());
			}
			else
				replaypic.loadGraphic(ImgReplay);
				
			if (FlxG.univ == 1) {
				if (FlxCollision.pixelPerfectCheck(cursor, level1)) {
					level1.loadGraphic(ImgLevel1On);
				}
				else
					level1.loadGraphic(ImgLevel1);
				
				if (FlxCollision.pixelPerfectCheck(cursor, level2)) {
					level2.loadGraphic(ImgLevel2On);
				}
				else
					level2.loadGraphic(ImgLevel2);
				
				if (FlxCollision.pixelPerfectCheck(cursor, level3)) {
					level3.loadGraphic(ImgLevel3On);
				}
				else
					level3.loadGraphic(ImgLevel3);
			}
			else if (FlxG.univ == 2) {
				if (FlxCollision.pixelPerfectCheck(cursor, level1)) {
					level1.loadGraphic(ImgLevel4On);
				}
				else
					level1.loadGraphic(ImgLevel4);
				
				if (FlxCollision.pixelPerfectCheck(cursor, level2)) {
					level2.loadGraphic(ImgLevel5On);
				}
				else
					level2.loadGraphic(ImgLevel5);
				
				if (FlxCollision.pixelPerfectCheck(cursor, level3)) {
					level3.loadGraphic(ImgLevel6On);
				}
				else
					level3.loadGraphic(ImgLevel6);
			}
			

			// GESTION CLICS SOURIS
			if (FlxG.mouse.justPressed()) {
				// NIVEAU 1
				if (FlxCollision.pixelPerfectCheck(cursor, level1)) {
					FlxG.level = 1;
					FlxG.switchState(new Play());
				}

				// NIVEAU 2
				if (FlxCollision.pixelPerfectCheck(cursor, level2)) {
					FlxG.level = 2;
					FlxG.switchState(new Play());
				}

				// NIVEAU 3
				if (FlxCollision.pixelPerfectCheck(cursor, level3)) {
					FlxG.level = 3;
					FlxG.switchState(new Play());
				}
			}
			
			
			
			if (FlxG.keys.justPressed("ONE") || FlxG.keys.justPressed("NUMPADONE")) {
					FlxG.level = 1;
					FlxG.switchState(new Play());
			}
			
			if (FlxG.keys.justPressed("TWO") || FlxG.keys.justPressed("NUMPADTWO")) {
					FlxG.level = 2;
					FlxG.switchState(new Play());
			}
			
			if (FlxG.keys.justPressed("THREE") || FlxG.keys.justPressed("NUMPADTHREE")) {
					FlxG.level = 3;
					FlxG.switchState(new Play());
			}
			
			// DEV : FERME LA FENETRE (à supprimer plus tard)
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
		}
	}
}
