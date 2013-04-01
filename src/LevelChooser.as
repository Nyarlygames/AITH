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
		[Embed(source = '../assets/gfx/ui/background-default.png')] protected var ImgBackDefault:Class;
		[Embed(source = '../assets/gfx/ui/choix-tiles.png')] 	 	protected var ImgChoixTexte:Class;
		[Embed(source = '../assets/gfx/ui/tetealienor_small.png')] 		protected var ImgAlienSmall:Class;
		[Embed(source = '../assets/gfx/ui/tetealiengrise_small.png')] 		protected var ImgAlienGrisSmall:Class;
		[Embed(source = '../assets/gfx/ui/backChxLvl.png')] 	protected var ImgFondLevel:Class;
		[Embed(source = '../assets/gfx/ui/tile-tubes.png')] 	protected var ImgTubes:Class;
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
		public var texteUnivers:FlxSprite;
		public var backLevel1:FlxSprite;
		public var backLevel2:FlxSprite;
		public var backLevel3:FlxSprite;
		public var backDefault:FlxSprite;
		public var retour:FlxSprite;
		public var cursor:FlxSprite;
		public var level1:FlxSprite;
		public var level2:FlxSprite;
		public var level3:FlxSprite;
		public var trophy1:FlxSprite;
		public var trophy2:FlxSprite;
		public var trophy3:FlxSprite;
		public var trophy4:FlxSprite;
		public var trophy5:FlxSprite;
		public var trophy6:FlxSprite;
		public var trophy7:FlxSprite;
		public var trophy8:FlxSprite;
		public var trophy9:FlxSprite;
		
		override public function create():void
		{
			
			FlxG.bgColor = 0xaa519CCA;
			
			new UI();
			FlxG.usersave.calcStars_levels();
			/*	Back par défaut */
				backDefault = new FlxSprite(490, 245, ImgBackDefault);
				backDefault.x = 0;
				backDefault.y = 0;
				add (backDefault);
			/*	Back par défaut */
		
			/*	Texte Niveaux */
				var txtNiveaux : FlxSprite = UI.choixTiles;
				add (txtNiveaux);
				txtNiveaux.x = 30; txtNiveaux.y = 30; txtNiveaux.play("niveaux");
			/*	Texte Univers */
			
			/*	Back level 1 */
				backLevel1 = new FlxSprite(206, 206, ImgFondLevel);
				backLevel1.x = 58;
				backLevel1.y = 312;
				add (backLevel1);	
				trophy1 = new FlxSprite(70, backLevel1.y - 120, ImgAlienGrisSmall);
				trophy2 = new FlxSprite(130, backLevel1.y - 120, ImgAlienGrisSmall);
				trophy3 = new FlxSprite(190, backLevel1.y - 120, ImgAlienGrisSmall);
				switch (FlxG.usersave.score1) {
					case 1:
						trophy1.loadGraphic(ImgAlienSmall);
						break;
					case 2:
						trophy1.loadGraphic(ImgAlienSmall);
						if (FlxG.usersave.level1[1] == 1)
							trophy2.loadGraphic(ImgAlienSmall);
						else
							trophy3.loadGraphic(ImgAlienSmall);
						break;
					case 3:
						trophy1.loadGraphic(ImgAlienSmall);
						trophy2.loadGraphic(ImgAlienSmall);
						trophy3.loadGraphic(ImgAlienSmall);
						break;
					default:
						break;
				}
				add(trophy1);
				add(trophy2);
				add(trophy3);
			/*	Back level 1 */
			
			/*	Back level 2 */
				backLevel2 = new FlxSprite(206, 206, ImgFondLevel);
				backLevel2.x = 315;
				backLevel2.y = 312;
				add (backLevel2);			
				trophy4 = new FlxSprite(325, backLevel2.y - 120, ImgAlienGrisSmall);
				trophy5 = new FlxSprite(385, backLevel2.y - 120, ImgAlienGrisSmall);
				trophy6 = new FlxSprite(445, backLevel2.y - 120, ImgAlienGrisSmall);
				switch (FlxG.usersave.score2) {
					case 1:
						trophy4.loadGraphic(ImgAlienSmall);
						break;
					case 2:
						trophy4.loadGraphic(ImgAlienSmall);
						if (FlxG.usersave.level2[1] == 1) {
							trophy5.loadGraphic(ImgAlienSmall);
						}
						else
							trophy6.loadGraphic(ImgAlienSmall);
						break;
					case 3:
						trophy4.loadGraphic(ImgAlienSmall);
						trophy5.loadGraphic(ImgAlienSmall);
						trophy6.loadGraphic(ImgAlienSmall);
						break;
					default:
						break;
				}
				add(trophy4);
				add(trophy5);
				add(trophy6);				
			/*	Back level 2 */
			
			/*	Back level 3 */
				backLevel3 = new FlxSprite(206, 206, ImgFondLevel);
				backLevel3.x = 565;
				backLevel3.y = 312;
				add (backLevel3);
				trophy7 = new FlxSprite(575, backLevel3.y - 120, ImgAlienGrisSmall);
				trophy8 = new FlxSprite(635, backLevel3.y - 120, ImgAlienGrisSmall);
				trophy9 = new FlxSprite(695, backLevel3.y - 120, ImgAlienGrisSmall);
				switch (FlxG.usersave.score3) {
					case 1:
						trophy7.loadGraphic(ImgAlienSmall);
						break;
					case 2:
						trophy7.loadGraphic(ImgAlienSmall);
						if (FlxG.usersave.level3[1] == 1)
							trophy8.loadGraphic(ImgAlienSmall);
						else
							trophy9.loadGraphic(ImgAlienSmall);
						break;
					case 3:
						trophy7.loadGraphic(ImgAlienSmall);
						trophy8.loadGraphic(ImgAlienSmall);
						trophy9.loadGraphic(ImgAlienSmall);
						break;
					default:
						break;
				}
				add(trophy7);
				add(trophy8);
				add(trophy9);
			/*	Back level 3 */
			
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
			
			/*	Images des niveaux */
			level1 = new FlxSprite(50, FlxG.height /2);
			level2 = new FlxSprite(300, FlxG.height /2);
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
			super.update();
			cursor.x = FlxG.mouse.x - cursor.frameWidth/2;
			cursor.y = FlxG.mouse.y - cursor.frameHeight / 2;
			
			if (FlxG.overlap(cursor, retour))
			{
				retour.play("on");
				if (FlxG.mouse.justPressed())
				{ FlxG.switchState(new UnivChooser());  }
			}
			else
			{
				retour.play("off");
			}
				
			if (FlxG.univ == 1) {
				if (FlxCollision.pixelPerfectCheck(cursor, level1)) 
				{
					level1.loadGraphic(ImgLevel1On);
					TweenMax.to(level1.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
					TweenMax.to(backLevel1.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
				}
				else
				{
					level1.loadGraphic(ImgLevel1);
					TweenMax.to(level1.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
					TweenMax.to(backLevel1.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
				}
				
				if (FlxCollision.pixelPerfectCheck(cursor, level2)) 
				{
					level2.loadGraphic(ImgLevel2On);
					TweenMax.to(level2.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
					TweenMax.to(backLevel2.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
				}
				else
				{
					level2.loadGraphic(ImgLevel2);
					TweenMax.to(level2.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
					TweenMax.to(backLevel2.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
				}
				
				if (FlxCollision.pixelPerfectCheck(cursor, level3)) 
				{
					level3.loadGraphic(ImgLevel3On);
					TweenMax.to(level3.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
					TweenMax.to(backLevel3.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
				}
				else
				{
					level3.loadGraphic(ImgLevel3);
					TweenMax.to(level3.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
					TweenMax.to(backLevel3.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
				}
			}
			else if (FlxG.univ == 2) {
				if (FlxCollision.pixelPerfectCheck(cursor, level1)) 
				{
					level1.loadGraphic(ImgLevel4On);
					TweenMax.to(level1.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
					TweenMax.to(backLevel1.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
				}
				else
				{
					level1.loadGraphic(ImgLevel4);
					TweenMax.to(level1.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
					TweenMax.to(backLevel1.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
				}
				
				if (FlxCollision.pixelPerfectCheck(cursor, level2)) 
				{
					level2.loadGraphic(ImgLevel5On);
					TweenMax.to(level2.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
					TweenMax.to(backLevel2.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
				}
				else
				{
					level2.loadGraphic(ImgLevel5);
					TweenMax.to(level2.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
					TweenMax.to(backLevel2.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
				}
				
				if (FlxCollision.pixelPerfectCheck(cursor, level3)) 
				{
					level3.loadGraphic(ImgLevel6On);
					TweenMax.to(level3.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
					TweenMax.to(backLevel3.scale, 0.2, { x:1.1,y:1.1, ease:Bounce.easeIn } );
				}
				else
				{
					level3.loadGraphic(ImgLevel6);
					TweenMax.to(level3.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
					TweenMax.to(backLevel3.scale, 0.2, { x:1,y:1, ease:Bounce.easeOut } );
				}
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
			
			if (FlxG.keys.pressed("ESCAPE")) {
				FlxG.switchState(new UnivChooser());
			}
		}
	}
}
