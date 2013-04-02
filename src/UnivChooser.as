package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
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
		[Embed(source = '../assets/gfx/ui/cadenas.png')] 				protected var ImgUni2Locked:Class;
		[Embed(source = '../assets/gfx/ui/univ_1_on.png')]				protected var ImgUni1On:Class;
		[Embed(source = '../assets/gfx/ui/univ_2_on.png')] 				protected var ImgUni2On:Class;
		[Embed(source = '../assets/gfx/ui/tetealienor_small.png')] 		protected var ImgAlienSmall:Class;
		
		[Embed(source = '../assets/sfx/gameplay/AlienTireur_Rebond.mp3')] protected var sfxChoose:Class;
		[Embed(source = '../assets/sfx/gameplay/AlienTireur_Tir1.mp3')] protected var sfxUniverse:Class;
		
		[Embed(source = '../assets/fonts/Urban_slick.ttf',	fontFamily = "slick", embedAsCFF = "false")] 	 protected var	Font:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")]	 protected var	Font3:Class;
		[Embed(source = '../assets/fonts/onedalism.ttf',	fontFamily = "onedalism", embedAsCFF = "false")] protected var	Font2:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Menu_Navigate_Click.wav')] public var SfxMenuClick:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Menu_Navigate_idle.wav')] public var SfxMenuIdle:Class;
		
		public var retour:FlxSprite;
		public var texteUnivers:FlxSprite;
		public var backDefault:FlxSprite;
		public var backUnivers:FlxSprite;
		public var backUnivers2:FlxSprite;
		public var cursor:FlxSprite;
		public var uni1:FlxSprite;
		public var uni2:FlxSprite;
		public var uni3:FlxSprite;
		
		public var trophy1:FlxText;
		public var trophy2:FlxText;
		public var trophy_help:FlxText;
		public var goldenalien1:FlxSprite;
		public var goldenalien2:FlxSprite;
		
		public var soundChoose:FlxSound = new FlxSound();
		public var soundUniverse:FlxSound = new FlxSound();
		public var sfxIdle:FlxSound = new FlxSound();
		public var sfxIdle2:FlxSound = new FlxSound();
		public var sfxIdle3:FlxSound = new FlxSound();
		public var end:EndGame;
		public var gamefinished:Boolean = false;
		
		override public function create():void
		{
			FlxG.bgColor = 0xaa519CCA;
			
			new UI();
			
			soundChoose.loadEmbedded(SfxMenuClick);
			soundUniverse.loadEmbedded(sfxUniverse);
			sfxIdle.loadEmbedded(SfxMenuIdle);
			sfxIdle2.loadEmbedded(SfxMenuIdle);
			sfxIdle3.loadEmbedded(SfxMenuIdle);
			FlxG.usersave.calcStars_univ();
			/*	Back par défaut */
				backDefault = new FlxSprite(490, 245, ImgBackDefault);
				backDefault.x = 0;
				backDefault.y = 0; 
				add (backDefault);
			/*	Back par défaut */

			/*	Setup Univers 2 */
				backUnivers2 = new FlxSprite(562/2, 287, ImgBackUnivers);
				backUnivers2.loadGraphic(ImgBackUnivers, true, false, 562/2, 287);
				backUnivers2.addAnimation("alien", [0], 10, true);
				backUnivers2.addAnimation("quartier", [1], 10, true);
				add (backUnivers2);
				backUnivers2.play("alien");
				uni2 = new FlxSprite(459, 260, ImgUni2Locked);
				add(uni2);
				backUnivers2.x = 420; backUnivers2.y = 200; backUnivers2.angle = -5;
				uni2.x = 435; uni2.y = 215; uni2.angle = -5;

				trophy2 = new FlxText(backUnivers2.x, backUnivers2.y + backUnivers2.frameHeight + 30, backUnivers2.frameWidth, "0/9");
				trophy2.y -= trophy2.frameHeight;
				trophy2.setFormat("onedalism", 40, 0xFFFFFF, "center", 0xaa000000);
				trophy2.text = FlxG.usersave.scoreuniv2 + "/9";
				add(trophy2);
				
				goldenalien2 = new FlxSprite(trophy2.x + 50, trophy2.y, ImgAlienSmall);
				add(goldenalien2);
				
				
				if (FlxG.usersave.scoreStars < FlxG.usersave.starsNeed) {
					trophy_help = new FlxText(backUnivers2.x, backUnivers2.y + backUnivers2.frameHeight /2, backUnivers2.frameWidth, "4 trophés requis");
					trophy_help.y -= trophy_help.frameHeight;
					trophy_help.setFormat("onedalism", 32, 0xFFFFFF, "center", 0xaa000000);
					add(trophy_help);
				}
				
			/*	Setup Univers 2 */
				
			/*	Setup Univers 1 */
				backUnivers = new FlxSprite(562/2, 287, ImgBackUnivers);
				backUnivers.loadGraphic(ImgBackUnivers, true, false, 562/2, 287);
				backUnivers.addAnimation("alien", [0], 10, true);
				backUnivers.addAnimation("quartier", [1], 10, true);
				add (backUnivers);
				backUnivers.play("quartier");	
				uni1 = new FlxSprite(124, 260, ImgUni1);
				add(uni1);
				backUnivers.x = 125; backUnivers.y = 200; backUnivers.angle = 10;
				uni1.x = 145; uni1.y = 220;  uni1.angle = 10;
				
				trophy1 = new FlxText(backUnivers.x, backUnivers.y + backUnivers.frameHeight + 30, backUnivers.frameWidth, "0/9");
				trophy1.y -= trophy1.frameHeight;
				trophy1.setFormat("onedalism", 40, 0xFFFFFF, "center", 0xaa000000);
				trophy1.text = FlxG.usersave.scoreuniv1 + "/9";
				add(trophy1);
				
				goldenalien1 = new FlxSprite(trophy1.x + 50, trophy1.y, ImgAlienSmall);
				add(goldenalien1);
				
			/*	Setup Univers 1 */
			
			/*	Retour en arrière */
				retour = new FlxSprite(50, 194, ImgTubes);
				retour.loadGraphic(ImgTubes, true, false, 194, 50);
				retour.addAnimation("off", [0], 10, true);
				retour.addAnimation("on", [1], 10, true);
				retour.x = 576; retour.y = 38;
				add (retour);
				retour.play("off");
			/*	Retour en arrière */
			
			/*	Texte Univers */
				var txtUnivers : FlxSprite = UI.choixTiles;
				add (txtUnivers);
				txtUnivers.x = 30; txtUnivers.y = 30; txtUnivers.play("univers");
			/*	Texte Univers */
			
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
			
			if ((FlxG.usersave.scoreStars >= FlxG.usersave.maxStars) && !gamefinished) {
				end = new EndGame();
				FlxG.switchState(end);
				gamefinished = true;
			}
			
			//REPLAY
			if (FlxG.overlap(cursor, retour))
			{
				sfxIdle.play();
				retour.play("on");
				if (FlxG.mouse.justPressed())
				{ soundChoose.play();
					sfxIdle.stop();
					FlxG.switchState(new Start()); 
					//FlxG.play(SfxMenuClick, 1, false, true);
				}
			}
			else
			{
				sfxIdle.stop();
				retour.play("off");
			}
			
			if (FlxCollision.pixelPerfectCheck(cursor, uni1)) 
			{
				uni1.loadGraphic(ImgUni1On);
				sfxIdle2.play();
				TweenMax.to(uni1.scale, 0.5, { y:1.1,x:1.1, ease:Linear.easeOut } );
				TweenMax.to(uni1, 0.5, { x:140, angle:0 , ease:Linear.easeOut } );
				TweenMax.to(backUnivers.scale, 0.5, { y:1.1,x:1.1, ease:Linear.easeOut } );
				TweenMax.to(backUnivers, 0.5, { angle:0, ease:Linear.easeOut } );
			}
			else
			{
				TweenMax.to(uni1, 0.5, { x: 145, y:220, angle:10, ease:Linear.easeOut } );
				TweenMax.to(uni1.scale, 0.5, { y:1,x:1, ease:Linear.easeOut } );
				TweenMax.to(backUnivers.scale, 0.5, { y:1,x:1, ease:Linear.easeOut } );
				TweenMax.to(backUnivers, 0.5, { angle:10, ease:Linear.easeOut } );
				uni1.loadGraphic(ImgUni1);
				sfxIdle2.stop();
				
			}
			
			if (FlxG.usersave.univUnlock == true) {
				trophy_help.visible = false;
				trophy_help.exists = false;
				if (FlxCollision.pixelPerfectCheck(cursor, uni2))
				{
					sfxIdle3.play();
					TweenMax.to(uni2.scale, 0.5, { y:1.2,x:1.2, ease:Bounce.easeOut } );
					TweenMax.to(backUnivers2.scale, 0.5, { y:1.2,x:1.2, ease:Bounce.easeOut } );
					uni2.loadGraphic(ImgUni2On);
				}
				else
				{
					sfxIdle3.stop();
					TweenMax.to(uni2.scale, 0.5, { y:1,x:1, ease:Bounce.easeOut } );
					TweenMax.to(backUnivers2.scale, 0.5, { y:1,x:1, ease:Linear.easeOut } );
					uni2.loadGraphic(ImgUni2);
				}
				if (FlxCollision.pixelPerfectCheck(cursor, uni2) && FlxG.mouse.justPressed()) 
					{
						sfxIdle3.stop();
						soundChoose.play();
						FlxG.univ = 2;
						//soundUniverse.play();
						// Does not work, dunno why :'(
						TweenMax.to(uni2, 3, { x : 1, y : 1, ease:Elastic.easeInOut, onComplete : FlxG.switchState(new LevelChooser())}  );
					}
				if (FlxG.keys.justPressed("TWO") || FlxG.keys.justPressed("NUMPADTWO")) {
						FlxG.univ = 2;
						sfxIdle3.stop();
						sfxIdle2.stop();
						sfxIdle.stop();
						sfxIdle.stop();
						soundChoose.play();
						//soundUniverse.play();
						FlxG.switchState(new LevelChooser());
				}
			}
			
			
				
			//Choix de l'univers à la souris
			if (FlxCollision.pixelPerfectCheck(cursor, uni1) && FlxG.mouse.justPressed()) 
				{
					FlxG.univ = 1;
					sfxIdle2.stop();
					//soundUniverse.play();
					// Does not work, dunno why :'(
					soundChoose.play();
					TweenMax.to(uni1, 15, { x : 1, y : 1, ease:Elastic.easeInOut, onComplete : FlxG.switchState(new LevelChooser())}  );
				}

			// Raccourcis développeurs pour choisir l'univers
			if (FlxG.keys.justPressed("T")) {
				FlxG.univ = -1;
				FlxG.switchState(new Play());
			}
			if (FlxG.keys.justPressed("U")) {
				FlxG.univ = -2;
				FlxG.switchState(new Play());
			}
			if (FlxG.keys.justPressed("ONE") || FlxG.keys.justPressed("NUMPADONE")) {
					FlxG.univ = 1;
					sfxIdle2.stop();
					sfxIdle3.stop();
					sfxIdle.stop();
					soundChoose.play();
					//soundUniverse.play();
					FlxG.switchState(new LevelChooser());
			}			
			if (FlxG.keys.justPressed("FOUR") || FlxG.keys.justPressed("NUMPADFOUR")) {
					FlxG.switchState(new ScoreScreen());
			}		
			if (FlxG.keys.justPressed("C")) {
					FlxG.usersave.univUnlock = true;
			}
		}
	}
}
