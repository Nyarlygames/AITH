package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxSave;
	import org.flixel.FlxSubState;
	import flash.system.System;
	import com.greensock.*;
	import com.greensock.easing.*;
	import org.flixel.plugin.photonstorm.FlxCollision;
	 
	/**
	 * LEVEL
	 * @author 
	 */
	public class ScoreScreen extends FlxState
	{
		[Embed(source = '../assets/gfx/ui/background-default.png')] protected var ImgBackDefault:Class;
		[Embed(source = '../assets/gfx/ui/choix-tiles.png')] 	 	protected var ImgChoixTexte:Class;
		[Embed(source = '../assets/gfx/ui/backChxLvl.png')] 		protected var ImgFondLevel:Class;
		[Embed(source = '../assets/gfx/ui/objectifs.png')] 			protected var ImgObjectif:Class;
		[Embed(source = '../assets/gfx/ui/tile-tubes.png')] 		protected var ImgTubes:Class;
		[Embed(source = '../assets/gfx/ui/cursor.png')] 			protected var ImgCursor:Class;
		[Embed(source = '../assets/gfx/ui/cursor_anim.png')]		protected var ImgCursorAnim:Class;
		
		[Embed(source = '../assets/gfx/ui/etoile.png')] 		protected var ImgStar:Class;
		
		[Embed(source = '../assets/fonts/Urban_slick.ttf',	fontFamily = "slick", embedAsCFF = "false")] protected var	Font:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")] protected var	Font3:Class;
		[Embed(source = '../assets/fonts/onedalism.ttf',	fontFamily = "onedalism", embedAsCFF = "false")] protected var	Font2:Class;
		
		public var finTexte:FlxSprite;
		public var texteUnivers:FlxSprite;
		
		public var backLevel1:FlxSprite;
		public var backLevel2:FlxSprite;
		public var backLevel3:FlxSprite;
		
		public var Objectif1:FlxSprite;
		public var Objectif2:FlxSprite;
		public var Objectif3:FlxSprite;
		
		public var backDefault:FlxSprite;
		public var retour:FlxSprite;
		public var cursor:FlxSprite;
		public var level1:FlxSprite;
		public var level2:FlxSprite;
		public var level3:FlxSprite;
		
		public var save:FlxSave;
		
		static var checkObjectif1:Boolean;
		static var checkObjectif2:Boolean;
		static var checkObjectif3:Boolean;
		
		override public function create():void
		{
			
			FlxG.bgColor = 0xaa519CCA;
			
			FlxG.pauseSounds();
			
			/*	Back par défaut */
				backDefault = new FlxSprite(490, 245, ImgBackDefault);
				backDefault.x = 0;
				backDefault.y = 0;
				add (backDefault);
			/*	Back par défaut */
			
			/*	Texte Score */
				var txtScore : FlxSprite = UI.choixTiles;
				add (txtScore);
				txtScore.x = 30; txtScore.y = 30; txtScore.play("score");
			/*	Texte Score */
		
			/*	Tete alien 1 */
				Objectif1 = new FlxSprite(132, 232, ImgObjectif);
				Objectif1.loadGraphic(ImgObjectif, true, false, 120, 165);
				Objectif1.addAnimation("on", [0], 1, true);
				Objectif1.addAnimation("off", [1], 1, true);
				Objectif1.play("off");
				add (Objectif1);
			/*	Tete alien 1 */
		
			/*	Tete alien 2 */
				Objectif2 = new FlxSprite(338, 232, ImgObjectif);
				Objectif2.loadGraphic(ImgObjectif, true, false, 120, 165);
				Objectif2.addAnimation("on", [0], 1, true);
				Objectif2.addAnimation("off", [1], 1, true);
				Objectif2.play("off");
				add (Objectif2);
			/*	Tete alien 2 */
		
			/*	Tete alien 3 */
				Objectif3 = new FlxSprite(542, 232, ImgObjectif);
				Objectif3.loadGraphic(ImgObjectif, true, false, 120, 165);
				Objectif3.addAnimation("on", [0], 1, true);
				Objectif3.addAnimation("off", [1], 1, true);
				Objectif3.play("off");
				add (Objectif3);
			/*	Tete alien 2 */
			
			
			/*	Retour au menu */
				retour = new FlxSprite(50, 194, ImgTubes);
				retour.loadGraphic(ImgTubes, true, false, 194, 50);
				retour.addAnimation("off", [0], 10, true);
				retour.addAnimation("on", [1], 10, true);
				retour.x = 576;
				retour.y = 38;
				add (retour);
				retour.play("off");
			/*	Retour au menu */			
			
			/*	Images des étoiles */
			level1 = new FlxSprite(50, FlxG.height /2);
			level2 = new FlxSprite(300, FlxG.height /2);
			level3 = new FlxSprite(550, FlxG.height / 2);
		
			
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
		
			if (FlxG.overlap(cursor, retour))
			{
				retour.play("on");
				if (FlxG.mouse.justPressed())
				{ FlxG.switchState(new UnivChooser());
				
				}
			}
			else
			{
				retour.play("off");
			}
			// SI obj 1 = VALIDE, ALORS ANIM + AUGMENTATION DU SCORE DU JOUEUR
			
			
			
			// etc
		}
	}
}
