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
		[Embed(source = "../level/map01.txt", mimeType = "application/octet-stream")] public var mapfile:Class;
		[Embed(source = "../level/map02.txt", mimeType = "application/octet-stream")] public var mapfile2:Class;
		[Embed(source = "../level/map03.txt", mimeType = "application/octet-stream")] public var mapfile3:Class;
		[Embed(source="../assets/sfx/binding2.mp3")] public  var Sfx_BG2:Class;

		public var player:Player;
		public var map:Map;
		public var pause:PauseMenu = new PauseMenu();
		public var sound:FlxSound;
		public var alienkill:int = 800;						// GRAVITE MINIMALE POUR TUER UN ALIEN
		public var dest_ground:int = 1000;					// GRAVITE MINIMALE POUR DESTRUIRE UN SOL
		
		
		override public function create():void
		{	
			switch (FlxG.univ) {
				// UNIVERS 1
				case 1:
					switch (FlxG.level) { 
						case 1:
							map = new Map(mapfile);
							break;
						case 2:
							map = new Map(mapfile2);
							break;
						case 3:    
							map = new Map(mapfile3);
							break;
					}
					break;
				// UNIVERS 2
				case 2:
					switch (FlxG.level) { 
						case 1:
							map = new Map(mapfile);
							break;
						case 2:
							map = new Map(mapfile2);
							break;
						case 3:
							map = new Map(mapfile3);
							break;
					}
					break;
			}
			// SON ARRIERE PLAN
			if (sound == null) {
				sound = new FlxSound();
				sound.loadEmbedded(Sfx_BG2, true, true);
				sound.play();
			}
		}

		override public function update():void {
			// ON VERIFIE LE CHARGEMENT DE LA MAP
			if (map.loaded) {
				player = map.player;
				super.update();
				
				// MENU PAUSE
				if ((FlxG.keys.justPressed("ESCAPE")) || (FlxG.keys.justPressed("P"))) {
					player.pause = true;
					this.setSubState(pause, onMenuClosed);
				}
				
				// DEV : RESTART ET DEPASSEMENT (à supprimer plus tard)
				if ((FlxG.keys.pressed("BACKSPACE")) || (!player.onScreen(FlxG.camera))) {
					sound.destroy();
					FlxG.score = -map.id;
					FlxG.resetState();
				}
				
				// COLLISIONS
				FlxG.overlap(player, map.ens, alien_coll);
				FlxG.overlap(player, map.item, getTube);
				FlxG.overlap(player, map.piques, die_motherfucker);
				FlxG.collide(player, map.destructible, check_ground);
				
				// POUBELLE JOUEUR
				//FlxG.collide(player, map.DustbinBieber, player.dustbin_pushed);
				
				
				if (!FlxG.collide(player, map.tile, player.tiles_coll))
					player.floating = true;
				else {
					player.floating = false;
				}
				// UPDATE PAUSE SCREEN
				if (player.pause) {
					pause.inPause();
				}
			}
		}

		// GESTION PIQUES
		public function die_motherfucker(obj1:FlxObject, obj2:FlxObject):void {
			player.x = player.checkpoint.x;
			player.y = player.checkpoint.y;
		}
		
		// GESTION RECUP TUBE VERT
		public function getTube(obj1:FlxObject, obj2:FlxObject):void {
			obj2.kill();
			obj2.destroy();
			FlxG.score += (obj2 as TubeVert).loot;
			FlxG.state.add(new Loot(player,(obj2 as TubeVert).loot));
		}

		
		// GESTION SOL DESTRUCTIBLE
		public function check_ground(obj1:FlxObject, obj2:FlxObject):void {
			if (obj2 != null){ 
				player.velocity.y = player.cur_velocity.y;
				player.velocity.x = player.cur_velocity.x;
			}
			if (player.gravity > dest_ground)
				obj2.kill();
		}
		
		// GESTION Collision alien
		public function alien_coll(obj1:FlxObject, obj2:FlxObject):void {
			var from:int = 1; // 0 => haut, 1 => partout ailleurs
			if (player.y <= obj2.y)
				from = 0;
			if (FlxCollision.pixelPerfectCheck((obj1 as FlxSprite), (obj2 as FlxSprite))) {
				// TUE L'alien
				if ((player.gravity > alienkill) && (from == 0)) {
					obj2.kill();
					FlxG.state.add(new Loot(player,(obj2 as Alien).loot));
				}
				// REBONDS
				else if (from == 0) {
					player.velocity.y = - player.velocity.x * 9 / 10;
				}
				// MEURT
				else {
					player.x = player.checkpoint.x;
					player.y = player.checkpoint.y;
				}
			}
		}

		// FIN DU MENU PAUSE
		private function onMenuClosed(state:FlxSubState, result:String):void
		{
			// RETOUR AU MENU
			if (result == PauseMenu.QUIT_GAME)
			{
				sound.destroy();
				FlxG.switchState(new UnivChooser()); 
			}
			// REDEMARRE LE NIVEAU
			else if (result == PauseMenu.RESTART)
			{
				sound.destroy();
				FlxG.score = -map.id;
				FlxG.resetState();
			}
			// RETOUR AU JEU
			else if (result == PauseMenu.RESUME_GAME) {
				player.velocity.x = player.cur_velocity.x;
				player.velocity.y = player.cur_velocity.y;
				player.angularspeed = player.cur_angularspeed;
				player.pause = false;
				player.set_old = true;
			}
		}
	}

}