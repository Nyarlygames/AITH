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
	
	/**
	 * Niveau
	 * @author ...
	 */
	public class Play extends FlxState 
	{
		
		// LA MUSIQUE ET LE SON MOTEUR SONT DESACTIVFES POUR PAUL.
		[Embed(source = "../assets/level/map_test.txt", mimeType = "application/octet-stream")] public var maptest:Class;
		[Embed(source = "../assets/level/map01.txt", mimeType = "application/octet-stream")] public var mapfile:Class;
		[Embed(source = "../assets/level/map02.txt", mimeType = "application/octet-stream")] public var mapfile2:Class;
		[Embed(source = "../assets/level/map03.txt", mimeType = "application/octet-stream")] public var mapfile3:Class;
		[Embed(source = "../assets/level/map04.txt", mimeType = "application/octet-stream")] public var mapfile4:Class;
		[Embed(source = "../assets/level/map05.txt", mimeType = "application/octet-stream")] public var mapfile5:Class;
		[Embed(source = "../assets/level/map06.txt", mimeType = "application/octet-stream")] public var mapfile6:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level1:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level2:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level3:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level4:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level5:Class;
		[Embed(source = "../assets/sfx/levels/level_1_1.mp3")] public var Sfx_Level6:Class;

		public var player:Player;
		public var map:Map;
		public var pause:PauseMenu = new PauseMenu();
		public var sound:FlxSound;
		public var alienkill:int = 800;						// GRAVITE MINIMALE POUR TUER UN ALIEN
		public var dest_ground:int = 10000;					// GRAVITE MINIMALE POUR DESTRUIRE UN SOL
		public var justloaded:Boolean = true;				// DEBUT MAP
		public var ui:UI = new UI();
		
		override public function create():void
		{	

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
					if (sound != null)
						//sound.play();
					justloaded = false;
				}
				super.update();
				
				// MENU PAUSE
				if ((FlxG.keys.justPressed("ESCAPE")) || (FlxG.keys.justPressed("P"))) {
					player.pause = true;
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
					player.die_motherfucker();
				}
				
				//DEV Respawn at checkpoint
				if (FlxG.keys.pressed("R")) 
				{
					player.die_motherfucker();
				}
				
				// COLLISIONS
				FlxG.overlap(player, map.ens, alien_coll);
				FlxG.overlap(player, map.item, getTube);
				if (FlxG.overlap(player, map.piques)) {
					player.die_motherfucker();
				}
				FlxG.collide(player, map.destructible, check_ground);
				
				// POUBELLE JOUEUR
				FlxG.overlap(player, map.DustbinBieber, player.dustbin);
				
				FlxG.collide(player, map.tile, player.tiles_coll)
				// UPDATE PAUSE SCREEN
				if (player.pause) {
					pause.inPause();
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
		public function check_ground(obj1:FlxObject, obj2:FlxObject):void {
			if (player.gravity > dest_ground)
				obj2.kill();
		}
		
		// GESTION Collision alien
		public function alien_coll(obj1:FlxObject, obj2:FlxObject):void {
			/*var from:int = 1; // 0 => haut, 1 => partout ailleurs
			if (player.y <= obj2.y)
				from = 0;
			if (FlxCollision.pixelPerfectCheck((obj1 as FlxSprite), (obj2 as FlxSprite))) {
				// TUE L'alien
				if ((player.gravity > alienkill) && (from == 0))
				{
					/*
					if (obj2 is AlienNormal)
					{
						(obj2 as AlienNormal).soundMort.play();
					}
					if (obj2 is AlienHorizontal)
					{
						(obj2 as AlienHorizontal).soundMort.play();
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
					/*if (obj2 is AlienHorizontal)
					{
						(obj2 as AlienHorizontal).soundRebond.play();
					}
					player.velocity.y = - player.velocity.x * 9 / 10;
				}
				// MEURT
				else {
					player.die_motherfucker();
				}
			}*/
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
				player.pause = false;
				player.set_old = true;
			}
		}
	}

}