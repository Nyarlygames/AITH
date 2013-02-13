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
		[Embed(source = "../maps/map01.txt", mimeType = "application/octet-stream")] public var mapfile:Class;
		[Embed(source = "../maps/map02.txt", mimeType = "application/octet-stream")] public var mapfile2:Class;
		[Embed(source = "../maps/map03.txt", mimeType = "application/octet-stream")] public var mapfile3:Class;
		[Embed(source="../assets/sfx/gori_instru.mp3")] public  var Sfx_BG:Class;
		[Embed(source="../assets/sfx/binding.mp3")] public  var Sfx_BG2:Class;

		public var player:Player;
		public var map:Map;
		public var background:Background;
		public var lasttile:int = 0;
		public var pause:PauseMenu = new PauseMenu();
		public var sound:FlxSound;
		public var alienkill:int = 800;						// GRAVITE MINIMALE POUR TUER UN ALIEN
		
		override public function create():void
		{	
			switch (FlxG.score) { // Score = - Level à la création
				case -1:
					map = new Map(mapfile);
					break;
				case -2:
					map = new Map(mapfile2);
					break;
				case -3:
					map = new Map(mapfile3);
					break;
			}	
			background = new Background(map.id);
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
				
				// DEV : RESTART (à supprimer plus tard)
				if (FlxG.keys.pressed("BACKSPACE")) {
					sound.destroy();
					FlxG.score = -map.id;
					FlxG.resetState();
				}
				
				// COLLISIONS
				FlxG.overlap(player, map.ens, alien_coll);
				FlxG.overlap(player, map.item, getTube);
				FlxG.collide(player, map.destructible, check_ground);
				if (!FlxG.collide(player, map.tile, tiles_coll))
					player.floating = true;
				else
					player.floating = false;
				// UPDATE PAUSE SCREEN
				if (player.pause) {
					pause.inPause();
				}
			}
		}

		
		// GESTION RECUP TUBE VERT
		public function getTube(obj1:FlxObject, obj2:FlxObject):void {
			FlxG.score += 10;
			obj2.kill();
			obj2.destroy();
		}
		
		// GESTION SOL DESTRUCTIBLE
		public function check_ground(obj1:FlxObject, obj2:FlxObject):void {
			if (obj2 != null){ 
				player.velocity.y = player.cur_velocity.y; // réapplique la gravité (obligatoire a chaque collide)
				player.velocity.x = player.cur_velocity.x;
			}
			if (player.gravity > 2000)
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

		// GESTIONS DES COLLISIONS DE TILES
		public function tiles_coll(obj1:FlxObject, obj2:FlxObject):void {
			
			// GET LA TILE COURANTE
			var mytile:uint = (obj2 as FlxTilemap).getTile(Math.floor(player.x / 40) +2, Math.round(player.y/40) +2);

			// HAUT DU TREMPLIN
			if ((mytile == 4) && (player.jumping == false)) {
				lasttile = 4;
				player.velocity.y = player.cur_velocity.y;
				player.velocity.x = player.cur_velocity.x;
			}
			// SAUTE (élan)
			else if ((lasttile == 4) && (mytile == 0)) { // SOUCIS DE CALCUL D'UNE TILE, LOGIQUE BONNE
				player.velocity.y = -(player.cur_velocity.x); // ELAN EN FONCTION DE VITESSE (à modifier ?)
				player.jumping = true;
				lasttile = 0;
			}
			// RETOUR AU SOL
			else if ((player.jumping) && (lasttile == 0) && (mytile != 0)) {
				player.jumping = false;
				player.velocity.x = player.maxVelocity.x;
			}
			// ROULE SUR LE SOL
			else if ((!player.pause) && (!player.jumping)) {
				player.velocity.x = player.cur_velocity.x;
			}
			// COLLISION EN L'AIR
			else if ((!player.pause) && (player.jumping)) {
				player.velocity.x = player.cur_velocity.x;
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
			// REDEMARRE LE NIVEAU (pas encore d'option dans PauseMenu)
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
				player.pause = false;
				player.set_old = true;
			}
		}
	}

}