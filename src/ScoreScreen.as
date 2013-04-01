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
		public var calculated:Boolean = false;
		
		public static var checkObjectif1:Boolean;
		public static var checkObjectif2:Boolean;
		public static var checkObjectif3:Boolean;
		
		public var completed:FlxText;
		public var nodeath:FlxText;
		public var alltubes:FlxText;
		
		
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
				
				completed = new FlxText(Objectif1.x - 25, Objectif1.y - 70, Objectif1.frameWidth + 50, "Terminé");
				completed.y -= completed.frameHeight;
				completed.setFormat("onedalism", 40, 0xFFFFFF, "center", 0x000000);
				add(completed);
				
				
			/*	Tete alien 1 */
		
			/*	Tete alien 2 */
				Objectif2 = new FlxSprite(338, 232, ImgObjectif);
				Objectif2.loadGraphic(ImgObjectif, true, false, 120, 165);
				Objectif2.addAnimation("on", [0], 1, true);
				Objectif2.addAnimation("off", [1], 1, true);
				Objectif2.play("off");
				add (Objectif2);
				
				nodeath = new FlxText(Objectif2.x - 25, Objectif2.y - 70, Objectif2.frameWidth + 50, "Sans faute");
				nodeath.y -= nodeath.frameHeight;
				nodeath.setFormat("onedalism", 40, 0xFFFFFF, "center", 0x000000);
				add(nodeath);
				
			/*	Tete alien 2 */
		
			/*	Tete alien 3 */
				Objectif3 = new FlxSprite(542, 232, ImgObjectif);
				Objectif3.loadGraphic(ImgObjectif, true, false, 120, 165);
				Objectif3.addAnimation("on", [0], 1, true);
				Objectif3.addAnimation("off", [1], 1, true);
				Objectif3.play("off");
				add (Objectif3);
				
				
				alltubes = new FlxText(Objectif3.x - 25, Objectif3.y - 70, Objectif3.frameWidth + 50, "100 Tubes");
				alltubes.y -= alltubes.frameHeight;
				alltubes.setFormat("onedalism", 40, 0xFFFFFF, "center", 0x000000);
				add(alltubes);
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
			
			/* VALIDATION OBJECTIF 1*/
			Objectif1.play("on");
			switch (FlxG.univ) {
				case 1:
					switch (FlxG.level) {
						case 1:
							FlxG.usersave.level1[0] = 1;
							break;
						case 2:
							FlxG.usersave.level2[0] = 1;
							break;
						case 3:
							FlxG.usersave.level3[0] = 1;
							break;
					}
					break;
				case 2:
					switch (FlxG.level) {
						case 1:
							FlxG.usersave.level4[0] = 1;
							break;
						case 2:
							FlxG.usersave.level5[0] = 1;
							break;
						case 3:
							FlxG.usersave.level6[0] = 1;
							break;
					}
					break;
			}
		
			/* VALIDATION OBJECTIF SANS MORTS*/
			if (FlxG.player.deadscore == 0) {
				Objectif2.play("on");
				switch (FlxG.univ) {
					case 1:
						switch (FlxG.level) {
							case 1:
								FlxG.usersave.level1[1] = 1;
								break;
							case 2:
								FlxG.usersave.level2[1] = 1;
								break;
							case 3:
								FlxG.usersave.level3[1] = 1;
								break;
						}
						break;
					case 2:
						switch (FlxG.level) {
							case 1:
								FlxG.usersave.level4[1] = 1;
								break;
							case 2:
								FlxG.usersave.level5[1] = 1;
								break;
							case 3:
								FlxG.usersave.level6[1] = 1;
								break;
						}
						break;
				}
			}
			/* VALIDATION OBJECTIF 100 TUBES*/
			if (FlxG.score >= 100) {
				Objectif3.play("on");
				switch (FlxG.univ) {
					case 1:
						switch (FlxG.level) {
							case 1:
								FlxG.usersave.level1[2] = 1;
								break;
							case 2:
								FlxG.usersave.level2[2] = 1;
								break;
							case 3:
								FlxG.usersave.level3[2] = 1;
								break;
						}
						break;
					case 2:
						switch (FlxG.level) {
							case 1:
								FlxG.usersave.level4[2] = 1;
								break;
							case 2:
								FlxG.usersave.level5[2] = 1;
								break;
							case 3:
								FlxG.usersave.level6[2] = 1;
								break;
						}
						break;
				}
			}

			if (FlxG.overlap(cursor, retour))
			{
				retour.play("on");
				if (FlxG.mouse.justPressed())
				{
					FlxG.switchState(new UnivChooser());
				}
			}
			
			// Ajout de point d'objectifs
			if (FlxG.keys.pressed("ENTER")) 
			{
				FlxG.switchState(new UnivChooser());
			}
			else
			{
				retour.play("off");
			}
			// SI obj 1 = VALIDE, ALORS ANIM + AUGMENTATION DU SCORE DU JOUEUR
			if (!calculated) {
				FlxG.usersave.calcStars();
				calculated = true;
			}
			
			// Ajout de point d'objectifs
			if (FlxG.keys.pressed("O")) 
			{
				FlxG.usersave.scoreStars++;
			}
		}
	}
}
