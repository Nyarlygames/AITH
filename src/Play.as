package  
{
	import flash.media.Camera;
	import flash.utils.Timer;
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;
	import org.flixel.FlxSound;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxTimer;
	import flash.events.Event;
	import com.greensock.*;
	import com.greensock.easing.*;
	import org.flixel.FlxPoint;
	import org.flixel.FlxObject;
	import org.flixel.FlxCamera;
	import org.flixel.FlxSubState;
	import org.flixel.system.FlxTile;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	import org.flixel.plugin.photonstorm.FlxScrollZone;
	import org.flixel.plugin.photonstorm.FlxControl;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxControlHandler;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	import org.flixel.FlxText;
	
	/**
	 * Niveau
	 * @author ...
	 */
	public class Play extends FlxState 
	{
		
		[Embed(source = "../assets/level/map_test.txt", mimeType = "application/octet-stream")] public var maptest:Class;
		[Embed(source = "../assets/level/mapDesignerTest.txt", mimeType = "application/octet-stream")] public var mapDesignerTest:Class;
		[Embed(source = "../assets/level/map01.txt", mimeType = "application/octet-stream")] public var mapfile:Class;
		[Embed(source = "../assets/level/map02.txt", mimeType = "application/octet-stream")] public var mapfile2:Class;
		[Embed(source = "../assets/level/map03.txt", mimeType = "application/octet-stream")] public var mapfile3:Class;
		[Embed(source = "../assets/level/map04.txt", mimeType = "application/octet-stream")] public var mapfile4:Class;
		[Embed(source = "../assets/level/map05.txt", mimeType = "application/octet-stream")] public var mapfile5:Class;
		[Embed(source = "../assets/level/map06.txt", mimeType = "application/octet-stream")] public var mapfile6:Class;
		[Embed(source = '../assets/gfx/ui/backflip.png')] 	 		protected var ImgBackflip:Class;
		
		[Embed(source = "../assets/sfx/gameplay/SolDestructible_EnDestruction.mp3")] public var SfxCrepite:Class;
		[Embed(source = "../assets/sfx/gameplay/SolDestructible_Destruction.mp3")] public var SfxDestrSol:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level1:Class;
		[Embed(source = "../assets/sfx/levels/level_1_2.mp3")] public var Sfx_Level2:Class;
		[Embed(source = "../assets/sfx/levels/level_1_2.mp3")] public var Sfx_Level3:Class;
		[Embed(source = "../assets/sfx/levels/level_1_2.mp3")] public var Sfx_Level4:Class;
		[Embed(source = "../assets/sfx/levels/level_1_2.mp3")] public var Sfx_Level5:Class;
		[Embed(source = "../assets/sfx/levels/level_1_2.mp3")] public var Sfx_Level6:Class;
		
		[Embed(source = '../assets/fonts/Urban_slick.ttf',	fontFamily = "slick", embedAsCFF = "false")] protected var	Font:Class;
		
		
		public var soundCrepite:FlxSound = new FlxSound();
		public var soundDestrSol:FlxSound = new FlxSound();

		public var tube_count:FlxText;
		public var player:Player;
		public var map:Map;
		public var pause:PauseMenu = new PauseMenu();
		public var ending:FlxSubState;
		public var sound:FlxSound;
		public var alienkill:int = 33000;					// GRAVITE MINIMALE POUR TUER UN ALIEN
		public var dest_ground:int = 6;					// GRAVITE MINIMALE POUR DESTRUIRE UN SOL
		public var justloaded:Boolean = true;				// MAP CHARGEE?
		public var begin:Boolean = true;					// TUTORIAL DU DEBUT?
		public var ui:UI = new UI();
		public var backflip  : FlxSprite;
		public var tuto:Tutorial;
		
		override public function create():void
		{				
			tube_count = new FlxText(75, 0, 200, "0");
			tube_count.y += tube_count.frameHeight - 10;
			tube_count.setFormat("onedalism", 35,0xFF0000000 , null, 0xFFFFFF );
			tube_count.scrollFactor = new FlxPoint(0, 0);
			
			backflip = new FlxSprite(500, 100, ImgBackflip);
			backflip.loadGraphic(ImgBackflip, false, false, 210, 82);
			backflip.scrollFactor.x = 0;
			backflip.scrollFactor.y = 0;

			soundCrepite.loadEmbedded(SfxCrepite);
			soundDestrSol.loadEmbedded(SfxDestrSol);
			switch (FlxG.univ) {
				// UNIVERS 1
				case -1:
					map = new Map(maptest);
					break;
				case -2:
					map = new Map(mapDesignerTest);
					break;
				case 1:
					switch (FlxG.level) { 
						case 1:
							map = new Map(mapfile);
							// SON ARRIERE PLAN
							if (sound == null) {
								sound = new FlxSound();
								sound.loadEmbedded(Sfx_Level1, true, true);
							}
							break;
						case 2:
							map = new Map(mapfile2);
							if (sound == null) {
								sound = new FlxSound();
								sound.loadEmbedded(Sfx_Level2, true, true);
							}
							break;
						case 3:    
							map = new Map(mapfile3);
							if (sound == null) {
								sound = new FlxSound();
								sound.loadEmbedded(Sfx_Level3, true, true);
							}
							break;
					}
					break;
				// UNIVERS 2
				case 2:
					switch (FlxG.level) { 
						case 1:
							map = new Map(mapfile4);
							if (sound == null) {
								sound = new FlxSound();
								sound.loadEmbedded(Sfx_Level4, true, true);
							}
							break;
						case 2:
							map = new Map(mapfile5);
							if (sound == null) {
								sound = new FlxSound();
								sound.loadEmbedded(Sfx_Level5, true, true);
							}
							break;
						case 3:
							map = new Map(mapfile6);
							if (sound == null) {
								sound = new FlxSound();
								sound.loadEmbedded(Sfx_Level6, true, true);
							}
							break;
					}
					break;
			}
		}

		override public function update():void
		{		
			// ON VERIFIE LE CHARGEMENT DE LA MAP
			if (map.loaded) {
				if (justloaded == true) {
					player = map.player;
					ui = new UI();
					FlxG.state.add(ui);
					FlxG.state.add(tube_count);
					if (sound != null)
						sound.play();
					justloaded = false;
				}
				super.update(); 
				if ((!FlxG.player.pause) && (!FlxG.player.dead) && (!FlxG.player.endLvl)) 
				{
					tube_count.text = "" + FlxG.score;
					// MENU PAUSE
					if ((FlxG.keys.justPressed("ESCAPE")) || (FlxG.keys.justPressed("P")))
					{
						player.pause = true;
						player.stopPlayer();
						this.setSubState(pause, onMenuClosed);
					}
					
					if (!player.onScreen(FlxG.camera)) {
						player.die_motherfucker(1);
					}
					
					//DEV Respawn at checkpoint
					if (FlxG.keys.pressed("R")) 
					{
						player.die_motherfucker(4);
					}
					// DEV : PASSE AU MENU DE SCORING
					if ((FlxG.keys.justPressed("S"))) 
					{
						FlxG.switchState(new ScoreScreen());
					}
					// DEV : TP A LA FIN
					if ((FlxG.keys.justPressed("E"))) 
					{
						player.checkpoint.x = map.fin.members[0].x - 200;
						player.checkpoint.y = map.fin.members[0].y + (map.fin.members[0] as FinNiveau).frameHeight - 100;
						player.die_motherfucker( -1);
						player.deadscore = 0;
					}
					// DEV : PASSE AU MENU DE SCORING
					if ((FlxG.keys.justPressed("L"))) 
					{
						var loot:TubeVert = new TubeVert(0, 0, 100, 1);
						getTube(player, loot);
					}
					// DEV : RESTART ET DEPASSEMENT (à supprimer plus tard)
					if (FlxG.keys.pressed("BACKSPACE")) {
						if (sound != null)
							sound.destroy();
						player.vitesse1.destroy();
						player.vitesse2.destroy();
						player.vitesse3.destroy();
						FlxG.score = -map.id;
						FlxG.resetState();
					}
					
					// COLLISIONS
					FlxG.overlap(player, map.ens, alien_coll);
					FlxG.overlap(player, map.item, getTube);
					FlxG.collide(player, map.piques, die_piques);
					FlxG.collide(player, map.souffleries);
					FlxG.collide(player, map.destructible, check_ground);
					FlxG.overlap(player, map.backflip, startBackflip);
					FlxG.overlap(player, map.endBackflip, endBackflip);
					
					// POUBELLE JOUEUR
					FlxG.collide(player, map.DustbinBieber, player.dustbin);
					
					// TOURELLE
					FlxG.overlap(map.tourelles, player, tourelle);
					
					// Fin JOUEUR
					FlxG.overlap(player, map.fin, endLevel);
					
					if (!FlxG.collide(player, map.tile, player.tiles_coll)) {
						player.accumulateur = 0;
					}
				}
				// UPDATE PAUSE SCREEN
				if (player.pause) {
					pause.inPause();
				}
				// UPDATE PAUSE SCREEN
				if ((player.dead) && (player.death != null)){
					player.death.inPause();
				}
			}
			else if (map.finishedload) {
				if (tuto != null)
					tuto.update();
				else
					tuto = new Tutorial();
			}
		}
		
		// GESTION RECUP TUBE VERT
		public function getTube(obj1:FlxObject, tube:TubeVert):void {
			if (!player.dead && tube_count.alive)
			{
				TweenMax.to(tube_count.scale, 0.1, { x:1.2,y:1.2, ease:Bounce.easeIn, onComplete : resetTubes } );
				TweenMax.to(tube_count, 0.1, { x:100, y:10, ease:Bounce.easeIn, onComplete : resetTubes  } );
				
				function resetTubes():void
				{
					TweenMax.to(tube_count.scale, 0.1, { x:1,y:1, ease:Bounce.easeIn } );
					TweenMax.to(tube_count, 0.1, { x:80, y:0, ease:Bounce.easeIn  } );
				}
			}
			if (tube.loot == 5)
			{
				tube.soundGrosTube.play();
			}
			if (tube.loot == 1)
			{
				tube.soundPetitTube.play();
			}
			tube.kill();
			tube.destroy();
			FlxG.score += tube.loot;
			FlxG.state.add(new Loot(player,tube.loot));
		}
		
		// Commencement du backflip
		public function startBackflip(obj1:FlxObject, obj2:FlxObject):void 
		{
<<<<<<< HEAD
			TweenMax.to(player, 2, { angle : -360, ease: Linear.easeOut } );
			TweenMax.to(player.scale, 1, { x : 3, y : 3, ease: Bounce.easeInOut, onComplete:outBackflip } );
			
			function outBackflip() :void
			{
				TweenMax.to(player.scale, 1, { x : 1, y : 1, ease: Bounce.easeOut } );
			}
=======
			TweenMax.to(player, 4, { angle : -360, ease:Linear.easeOut, onComplete:testBackflip } );
			backflip = new FlxSprite(0, 0, ImgBackflip);
			add (backflip);
		}
		
		// Commencement du backflip
		public function testBackflip():void 
		{
			TweenMax.to(player, 2, { angle:0, ease:Linear.easeNone } );
			TweenMax.to(player, 3, { alpha:1, ease:Cubic.easeInOut } );
>>>>>>> 60754fc71905f2692db75cac3e5f37872c9b9bf6
		}
		
		// Fin du backflip
		public function endBackflip(obj1:FlxObject, obj2:FlxObject):void 
		{
			//TweenMax.to(player.scale, 3, { x : 1, y:1, ease:Linear.easeNone } );
			//TweenMax.to(player, 2, { angle : 720, ease:Linear.easeNone } );
		}
		
		
		
		// GESTION SOL DESTRUCTIBLE
		public function check_ground(obj1:FlxObject, obj2:FlxObject):void 
		{
			soundCrepite.volume = 0.5;
			soundCrepite.play();
			if (player.jauge.frame > dest_ground)
			{
				(obj2 as Destructible_ground).play("destruction");
				(obj2 as Destructible_ground).destruction = true;
				(obj2 as Destructible_ground).height = 0;
				(obj2 as Destructible_ground).width = 0;
				soundDestrSol.volume = 0.5;
				soundDestrSol.play();
			}
			else if (!(obj2 as Destructible_ground).destruction) {
				(obj2 as Destructible_ground).frame = 1;
			}
			
		}
		
		// TOURELLES
		public function tourelle(obj1:FlxSprite, obj2:FlxSprite):void 
		{
			player.die_motherfucker(0);
		}
		
		// PIQUES
		public function die_piques(obj1:FlxSprite, obj2:FlxSprite):void 
		{
			switch ((obj2 as Piques).angle){
				case 180:
					// "bas"
					if (obj1.y > obj2.y)
						player.die_motherfucker(2);
					break;
				case -90:
					if (obj1.x < obj2.x)
						player.die_motherfucker(2);
					//"gauche"
					break;
				case 90:
					if (obj1.x > obj2.x)
						player.die_motherfucker(2);
					// "droite"
					break;
				case 0:
					if (obj1.y < obj2.y)
						player.die_motherfucker(2);
					// "haut"
					break;
			}
		}
		
		// GESTION FIN DE NIVEAU
		public function endLevel(player:Player, end:FlxObject):void 
		{
			// play ending animations and sounds.
				FlxG.player.endLvl = true;
				TweenMax.to(FlxG.player, 1, { x: FlxG.player.x + 100 , alpha : 0, ease:Linear.easeOut } );
				TweenMax.to(FlxG.player.jauge, 0.3, { alpha : 0, ease:Linear.easeOut } );
				player.stopPlayer();
				if (sound != null) {
					sound.stop();
					sound.destroy();
				}			
				if ((player.vitesse1 != null) && (player.vitesse2 != null) && (player.vitesse3 != null)) {
					player.vitesse1.stop();
					player.vitesse1.destroy();
					player.vitesse2.stop();
					player.vitesse2.destroy();
					player.vitesse3.stop();
					player.vitesse3.destroy();
				}
				var t : FlxTimer = new FlxTimer();
				t.start(3, 1,goScore) ;
			// Then go to Score Screens
			function goScore():void
			{
				var stateScore : ScoreScreen = new ScoreScreen();
				FlxG.switchState(stateScore);
			}
		}
		
		// GESTION Collision alien
		public function alien_coll(obj1:FlxObject, obj2:FlxObject):void {
			var from:int = 1; // 0 => haut, 1 => partout ailleurs
			if (player.y <= obj2.y)
				from = 0;
			if (FlxCollision.pixelPerfectCheck((obj1 as FlxSprite), (obj2 as FlxSprite)))  {
				// TUE
				if ((player.gravity > alienkill) && (from == 0))
				{
					if (obj2 is AlienNormal)
					{
						(obj2 as AlienNormal).play("mort");
						(obj2 as AlienNormal).killed = true;
						//(obj2 as AlienNormal).soundMort.play();
					}
					if (obj2 is AlienHorizontal)
					{
						(obj2 as AlienHorizontal).play("mort");
						(obj2 as AlienHorizontal).killed = true;
						//(obj2 as AlienHorizontal).soundMort.play();
					}
				}
				// REBONDS
				else if (from == 0) {
					if (obj2 is AlienNormal)
					{
						(obj2 as AlienNormal).play("rebonds");
						(obj2 as AlienNormal).soundRebond.play();
					}
					if (obj2 is AlienHorizontal)
					{
						(obj2 as AlienHorizontal).play("rebonds");
						//(obj2 as AlienHorizontal).soundRebond.play();
					}
					player.velocity.y = - 250;
				}
				// MEURT
				else {
					if (obj2 is AlienHorizontal)
					{
						if ((obj2 as AlienHorizontal).killed == false)
							player.die_motherfucker(3);
					}
					if (obj2 is AlienNormal)
					{
						if ((obj2 as AlienNormal).killed == false)
							player.die_motherfucker(3);
					}
				}
			}
		}

		// FIN DU MENU PAUSE
		private function onMenuClosed(state:FlxSubState, result:String):void
		{
			// RETOUR AU MENU
			if (result == PauseMenu.QUIT_GAME)
			{
				if (sound != null)
					sound.destroy();
				player.vitesse1.destroy();
				player.vitesse2.destroy();
				player.vitesse3.destroy();
				FlxG.switchState(new UnivChooser()); 
			}
			// REDEMARRE LE NIVEAU
			else if (result == PauseMenu.RESTART)
			{
				if (sound != null)
					sound.destroy();
				player.vitesse1.destroy();
				player.vitesse2.destroy();
				player.vitesse3.destroy();
				FlxG.score = -map.id;
				FlxG.resetState();
			}
			// RETOUR AU JEU
			else if (result == PauseMenu.RESUME_GAME) {
				player.acceleration.x = player.old_acceleration.y;
				player.acceleration.x = player.old_acceleration.y;
				player.gravity = player.old_gravity;
				player.accumulateur = player.old_accu.x;
				player.palier_accumulateur = player.old_accu.y;
				player.velocity.y = player.old_velocity.y;
				player.velocity.x = player.old_velocity.x;
				player.angle = player.old_angle;
				player.angularVelocity = - player.angularspeed;
				player.pause = false;
			}
		}
	}

}