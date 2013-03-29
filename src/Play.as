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
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.FlxPoint;
	import org.flixel.plugin.photonstorm.FlxControl;
	import org.flixel.plugin.photonstorm.FlxControlHandler;
	import org.flixel.FlxObject;
	import org.flixel.plugin.photonstorm.FlxScrollZone;
	import org.flixel.FlxCamera;
	import org.flixel.FlxSubState;
	import flash.events.Event;
	import org.flixel.system.FlxTile;
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
		[Embed(source = "../assets/level/map01.txt", mimeType = "application/octet-stream")] public var mapfile:Class;
		[Embed(source = "../assets/level/map02.txt", mimeType = "application/octet-stream")] public var mapfile2:Class;
		[Embed(source = "../assets/level/map03.txt", mimeType = "application/octet-stream")] public var mapfile3:Class;
		[Embed(source = "../assets/level/map04.txt", mimeType = "application/octet-stream")] public var mapfile4:Class;
		[Embed(source = "../assets/level/map05.txt", mimeType = "application/octet-stream")] public var mapfile5:Class;
		[Embed(source = "../assets/level/map06.txt", mimeType = "application/octet-stream")] public var mapfile6:Class;
		
		[Embed(source = "../assets/sfx/gameplay/SolDestructible_EnDestruction.mp3")] public var SfxCrepite:Class;
		[Embed(source = "../assets/sfx/gameplay/SolDestructible_Destruction.mp3")] public var SfxDestrSol:Class;
		
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level1:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level2:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level3:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level4:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level5:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level6:Class;
		
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
		public var dest_ground:int = 2000;					// GRAVITE MINIMALE POUR DESTRUIRE UN SOL
		public var justloaded:Boolean = true;				// DEBUT MAP
		public var ui:UI = new UI();
		
		override public function create():void
		{				
			tube_count = new FlxText(70, 0, 200, "0");
			tube_count.y += tube_count.frameHeight - 3;
			tube_count.setFormat("onedalism", 22, 0x000000);
			tube_count.scrollFactor = new FlxPoint(0, 0);

			soundCrepite.loadEmbedded(SfxCrepite);
			soundDestrSol.loadEmbedded(SfxDestrSol);
			switch (FlxG.univ) {
				// UNIVERS 1
				case -1:
					map = new Map(maptest);
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
					FlxG.state.add(ui);
					FlxG.state.add(tube_count);
					if (sound != null)
						sound.play();
					justloaded = false;
				}
				super.update(); 
				if ((!FlxG.player.pause) && (!FlxG.player.dead)) {
					tube_count.text = ""+FlxG.score;
					// MENU PAUSE
					if ((FlxG.keys.justPressed("ESCAPE")) || (FlxG.keys.justPressed("P"))) {
						player.pause = true;
						player.stopPlayer();
						this.setSubState(pause, onMenuClosed);
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
					if (!player.onScreen(FlxG.camera)) {
						player.die_motherfucker(1);
					}
					
					//DEV Respawn at checkpoint
					if (FlxG.keys.pressed("R")) 
					{
						player.die_motherfucker(0);
					}
					
					// COLLISIONS
					FlxG.overlap(player, map.ens, alien_coll);
					FlxG.overlap(player, map.item, getTube);
					if (FlxG.overlap(player, map.piques)) {
						player.die_motherfucker(0);
					}
					FlxG.collide(player, map.destructible, check_ground);
					
					// POUBELLE JOUEUR
					FlxG.overlap(player, map.DustbinBieber, player.dustbin);
					
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
				if (player.dead) {
					player.death.inPause();
				}
			}
		}
		
		// GESTION RECUP TUBE VERT
		public function getTube(obj1:FlxObject, tube:TubeVert):void {
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
		
		// GESTION SOL DESTRUCTIBLE
		public function check_ground(obj1:FlxObject, obj2:FlxObject):void 
		{
			soundCrepite.volume = 0.5;
			soundCrepite.play();
			player.angle = 0;
			if (player.gravity > dest_ground)
			{
				soundDestrSol.volume = 0.5;
				soundDestrSol.play();
				obj2.kill();
			}
		}
		
		// TOURELLES
		public function tourelle(obj1:FlxSprite, obj2:FlxSprite):void 
		{
			player.die_motherfucker(0);
		}
		
		// GESTION FIN DE NIVEAU
		public function endLevel(player:Player, end:FlxObject):void 
		{
			// play ending animations and sounds.
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
				t.start(2, 1,goScore) ;
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
			if (FlxCollision.pixelPerfectCheck((obj1 as FlxSprite), (obj2 as FlxSprite))) {
				if ((player.gravity > alienkill) && (from == 0))
				{
					
					if (obj2 is AlienNormal)
					{
						//(obj2 as AlienNormal).soundMort.play();
					}
					if (obj2 is AlienHorizontal)
					{
						//(obj2 as AlienHorizontal).soundMort.play();
					}
					
					obj2.kill();
					FlxG.state.add(new Loot(player,(obj2 as Alien).loot));
				}
				// REBONDS
				else if (from == 0) {
					if (obj2 is AlienNormal)
					{
						(obj2 as AlienNormal).soundRebond.play();
					}
					if (obj2 is AlienHorizontal)
					{
						//(obj2 as AlienHorizontal).soundRebond.play();
					}
					player.velocity.y = - 250;
				}
				// MEURT
				else {
					player.die_motherfucker(0);
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
				player.acceleration = player.old_acceleration;
				player.gravity = player.old_gravity;
				player.accumulateur = player.old_accu.x;
				player.palier_accumulateur = player.old_accu.y;
				player.velocity = player.old_velocity;
				trace("RESUME : ", player.velocity.x, player.velocity.y, player.acceleration.x, player.acceleration.y);
				player.pause = false;
				player.set_old = true;
			}
		}
	}

}