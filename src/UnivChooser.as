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
	 * UNIVERS
	 * @author 
	 */
	public class UnivChooser extends FlxState
	{
		[Embed(source = '../assets/gfx/ui/tile-tubes.png')] 			protected var ImgTubes:Class;
		[Embed(source = '../assets/gfx/ui/back-univers.png')] 			protected var ImgBackUnivers:Class;
		[Embed(source = '../assets/gfx/ui/background-default.png')] 	protected var ImgBackDefault:Class;
		[Embed(source = '../assets/gfx/ui/choix-tiles.png')] 			protected var ImgChoixTexte:Class;
		[Embed(source = '../assets/gfx/ui/cursor.png')] 				protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/cursor_anim.png')] 			protected var ImgCursorAnim:Class;
		[Embed(source = '../assets/gfx/ui/univ_1.png')] 				protected var ImgUni1:Class;
		[Embed(source = '../assets/gfx/ui/univ_2.png')] 				protected var ImgUni2:Class;
		[Embed(source = '../assets/gfx/ui/univ_1_on.png')]				protected var ImgUni1On:Class;
		[Embed(source = '../assets/gfx/ui/univ_2_on.png')] 				protected var ImgUni2On:Class;
		[Embed(source = '../assets/fonts/Urban_slick.ttf',	fontFamily = "slick", embedAsCFF = "false")] 	 protected var	Font:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")]	 protected var	Font3:Class;
		[Embed(source = '../assets/fonts/onedalism.ttf',	fontFamily = "onedalism", embedAsCFF = "false")] protected var	Font2:Class;
		
		public var retour:FlxSprite;
		public var texteUnivers:FlxSprite;
		public var backDefault:FlxSprite;
		public var backUnivers:FlxSprite;
		public var backUnivers2:FlxSprite;
		public var cursor:FlxSprite;
		public var uni1:FlxSprite;
		public var uni2:FlxSprite;
		public var uni3:FlxSprite;
		
		override public function create():void
		{
			
			FlxG.bgColor = 0xaa519CCA;
			
			/*	Back par défaut */
				backDefault = new FlxSprite(490, 245, ImgBackDefault);
				backDefault.x = 0;
				backDefault.y = 0;
				add (backDefault);
			
			/*	Setup Univers 1 */
				backUnivers = new FlxSprite(562/2, 287, ImgBackUnivers);
				backUnivers.loadGraphic(ImgBackUnivers, true, false, 562/2, 287);
				backUnivers.addAnimation("alien", [0], 10, true);
				backUnivers.addAnimation("quartier", [1], 10, true);
				backUnivers.x = 112;
				backUnivers.y = 249;
				add (backUnivers);
				backUnivers.play("quartier");	
				uni1 = new FlxSprite(124, 260, ImgUni1);
				add(uni1);
			/*	Setup Univers 1 */

			/*	Setup Univers 2 */
				backUnivers2 = new FlxSprite(562/2, 287, ImgBackUnivers);
				backUnivers2.loadGraphic(ImgBackUnivers, true, false, 562/2, 287);
				backUnivers2.addAnimation("alien", [0], 10, true);
				backUnivers2.addAnimation("quartier", [1], 10, true);
				backUnivers2.x = 447;
				backUnivers2.y = 249;
				add (backUnivers2);
				backUnivers2.play("alien");
				uni2 = new FlxSprite(459, 260, ImgUni2);
				add(uni2);
			/*	Setup Univers 2 */
			
			/*	Retour en arrière */
				retour = new FlxSprite(50, 194, ImgTubes);
				retour.loadGraphic(ImgTubes, true, false, 194, 50);
				retour.addAnimation("off", [0], 10, true);
				retour.addAnimation("on", [1], 10, true);
				retour.x = 576;
				retour.y = 38;
				add (retour);
				retour.play("off");
			/*	Retour en arrière */
			
			/*	Texte choix de l'univers */
				texteUnivers = new FlxSprite(482, 84, ImgChoixTexte);
				texteUnivers.loadGraphic(ImgChoixTexte, true, false, 482, 84);
				texteUnivers.addAnimation("univers", [0], 10, true);
				texteUnivers.addAnimation("niveaux", [1], 10, true);
				texteUnivers.x = 36;
				texteUnivers.y = 29;
				add (texteUnivers);
				texteUnivers.play("univers");
			/*	Retour en arrière */
			
			/*
			SCORE 1
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
			
			*/
			
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

			//REPLAY

			if (FlxG.overlap(cursor, retour))
			{
				retour.play("on");
				if (FlxG.mouse.justPressed())
				{ FlxG.switchState(new Start());  }
			}
			else
			{
				retour.play("off");
			}
			
			if (FlxCollision.pixelPerfectCheck(cursor, uni1)) {
				uni1.loadGraphic(ImgUni1On);
			}
			else
				uni1.loadGraphic(ImgUni1);
			
			if (FlxCollision.pixelPerfectCheck(cursor, uni2)) {
				uni2.loadGraphic(ImgUni2On);
			}
			else
				uni2.loadGraphic(ImgUni2);
				
			//Choix de l'univers à la souris
			if (FlxCollision.pixelPerfectCheck(cursor, uni1) && FlxG.mouse.justPressed()) 
				{
					FlxG.univ = 1;
					// Does not work, dunno why :'(
					TweenMax.to(uni1, 15, { x : 1, y : 1, ease:Elastic.easeInOut, onComplete : FlxG.switchState(new LevelChooser())}  );
				}
			if (FlxCollision.pixelPerfectCheck(cursor, uni2) && FlxG.mouse.justPressed()) 
				{
					FlxG.univ = 2;
					// Does not work, dunno why :'(
					TweenMax.to(uni2, 3, { x : 1, y : 1, ease:Elastic.easeInOut, onComplete : FlxG.switchState(new LevelChooser())}  );
				}
			
			// Raccourcis développeurs pour choisir l'univers
			if (FlxG.keys.justPressed("T")) {
				FlxG.univ = -1;
				FlxG.switchState(new Play());
			}
			if (FlxG.keys.justPressed("ONE") || FlxG.keys.justPressed("NUMPADONE")) {
					FlxG.univ = 1;
					FlxG.switchState(new LevelChooser());
			}
			
			if (FlxG.keys.justPressed("TWO") || FlxG.keys.justPressed("NUMPADTWO")) {
					FlxG.univ = 2;
					FlxG.switchState(new LevelChooser());
			}
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
		}
	}
}
