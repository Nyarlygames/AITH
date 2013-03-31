package
{
	import com.greensock.core.TweenCore;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	import org.flixel.plugin.TimerManager;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.system.System;
	
	import org.flixel.plugin.photonstorm.FlxCollision;
	 
	/**
	 * Start
	 * @author 
	 */
	public class Start extends FlxState
	{
		[Embed(source = '../assets/gfx/ui/aith_logo.png')] 			protected var ImgLogo:Class;
		[Embed(source = '../assets/gfx/ui/tile-tubes.png')] 		protected var ImgTubes:Class;
		[Embed(source = '../assets/gfx/ui/logo-tile.png')]		 	protected var ImgLogoTile:Class;
		[Embed(source = '../assets/gfx/ui/etoile.png')] 			protected var ImgStars:Class;
		[Embed(source = '../assets/gfx/ui/play-arrow.png')] 		protected var ImgArrowPlay:Class;
		[Embed(source = '../assets/gfx/ui/jimi_roule_rapide.png')] 	protected var ImgRunningJimi:Class;
		[Embed(source = '../assets/gfx/ui/background-default.png')] protected var ImgBackDefault:Class;
		[Embed(source = '../assets/gfx/ui/borne-credits.png')] 		protected var ImgCredits:Class;
		[Embed(source = '../assets/gfx/ui/credits.png')] 			protected var ImgCreditsAuthors:Class;
		[Embed(source = '../assets/gfx/ui/cursor.png')] 			protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/cursor_anim.png')] 		protected var ImgCursorAnim:Class;
		[Embed(source = '../assets/fonts/Urban_slick.ttf',	fontFamily = "slick", embedAsCFF = "false")] protected var	Font:Class;
		
		public var backDefault:FlxSprite;
		public var retour:FlxSprite;
		public var logo:FlxSprite;
		public var cursor:FlxSprite;
		public var arrowPlay:FlxSprite;
		public var credits:FlxSprite;
		public var authors:FlxSprite;
		public var jimi:FlxSprite;
		public var timer : FlxTimer = new FlxTimer();
		
		override public function create():void
		{
			
			FlxG.bgColor = 0xaa519CCA;
			
			backDefault = new FlxSprite(490, 245, ImgBackDefault);
			backDefault.x = 0;
			backDefault.y = 0;
			add (backDefault);
			
			// LOGO
			logo = new FlxSprite(191,85, ImgLogoTile);
			logo.loadGraphic(ImgLogoTile, true, false, 1684/4, 399);
			logo.addAnimation("contour", [1,2,3], 1, true);
			logo.addAnimation("normal", [0], 5, true);
			logo.scale.x = 0.5; logo.scale.y = 0.5;
			timer.start(10, 1);
			add(logo);
			
			//CREDITS
				credits = new FlxSprite(700, 245, ImgCredits);
				credits.x = 700; credits.y = -200;
				add(credits);
			
			//Authors 
				authors = new FlxSprite(800, 206, ImgCreditsAuthors);
				authors.x = 0; authors.y = -200;
				add(authors);
			
			// Running Jimi
				jimi = new FlxSprite(80, 80, ImgRunningJimi);
				jimi.loadGraphic(ImgRunningJimi, true, false, 80, 80);
				jimi.addAnimation("normal", [0, 1, 2], 8, true);
				jimi.x = -100; jimi.y = 600 - jimi.height;
				jimi.velocity.x = 300;
				add (jimi);
			
			/*	Retour en arrière */
				retour = new FlxSprite(50, 194, ImgTubes);
				retour.loadGraphic(ImgTubes, true, false, 194, 50);
				retour.addAnimation("off", [0], 10, true);
				retour.addAnimation("on", [1], 10, true);
				retour.x = 576;
				retour.y = 38;
				retour.alpha = 0;
				add (retour);
				retour.play("off");
			/*	Retour en arrière */
			
			/*	Fleche pour jouer */
				arrowPlay = new FlxSprite(399, 17, ImgArrowPlay);
				arrowPlay.alpha = 0;
				add (arrowPlay);
			/*	Fleche pour jouer */
			
			// CURSEUR SOURIS
				cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
				cursor.loadGraphic(ImgCursorAnim, true, false, 40, 40);
				cursor.addAnimation("souris", [0, 1, 2, 3], 8, true);
				cursor.play("souris");
				add(cursor)
				FlxG.mouse.hide();
				
			if (FlxG.usersave == null)
				FlxG.usersave = new UserSave();
			
			//Tweens
			var twLogo : TweenMax = TweenMax.to(logo.scale, 1, { x : 1, y : 1, ease:Elastic.easeInOut, onComplete : twCred}  );
			function twCred() : void
			{
				TweenMax.to(credits, 0.8, { y:400, ease:Cubic.easeIn } );
				TweenMax.to(arrowPlay, 5, { alpha:1, ease:Elastic.easeIn}  );
			}
			
			
		}
		
		override public function update():void
		{
			super.update();
			cursor.x = FlxG.mouse.x - cursor.frameWidth/2;
			cursor.y = FlxG.mouse.y - cursor.frameHeight/2;
				
			//Défilement automatique de jimi
			if (jimi.x > 900)
			{
				jimi.x = -100;
			}
			
			// Gestion de la retour en arrière dans les crédits
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
			
			// VERS CHOIX DE L'UNIVERS
			logo.play("normal");
			if (FlxCollision.pixelPerfectCheck(cursor, logo))
			{
				logo.play("contour");
				if (FlxG.mouse.justPressed()) 
				{
					FlxG.switchState(new UnivChooser());
				}
			}
			if (FlxCollision.pixelPerfectCheck(cursor, credits))
			{
				TweenMax.to(credits, 1, { alpha:0.4, ease:Linear.easeOut } );
				if (FlxG.mouse.justPressed()) 
				{
					TweenMax.to(authors, 0.9, { y:300, ease:Linear.easeOut } );
					TweenMax.to(retour, 0.9, { alpha:1, ease:Linear.easeOut } );
					TweenMax.to(logo, 0.4, { alpha:0, ease:Linear.easeOut } );
					TweenMax.to(arrowPlay, 0.4, { alpha:0, ease:Linear.easeOut } );
					TweenMax.to(credits, 0.4, { alpha:0, ease:Linear.easeOut } );
					TweenMax.to(jimi, 0.4, { alpha:0, ease:Linear.easeOut } );
				}
			}
			else
			{
				TweenMax.to(credits, 1, { alpha:1, ease:Linear.easeOut } );
			}
			
			if (FlxG.keys.pressed("SPACE")) 
			{
				FlxG.switchState(new UnivChooser());
			}
			// DEV : FERME LA FENETRE (à supprimer plus tard)
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
		}
	}
}
