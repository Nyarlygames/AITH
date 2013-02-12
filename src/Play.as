package  
{
	import flash.media.Camera;
	import flash.utils.Timer;
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;
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
	import flash.events.Event;
	import org.flixel.system.FlxTile;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	import flash.system.System;
	
	/**
	 * Niveau
	 * @author ...
	 */
	public class Play extends FlxState 
	{
		[Embed(source = "../maps/map01.txt", mimeType = "application/octet-stream")] public var mapfile:Class;

		public var player:Player;
		public var cam:Cam;
		public var map:Map;
		public var background:Background = new Background();
		public var speed:int = 0;
		public var lasttile:int = 0;
		
		override public function create():void
		{	 
			if (FlxG.getPlugin(FlxScrollZone) == null)
			{
				FlxG.addPlugin(new FlxScrollZone);
			}
			
			add(background);
			player = new Player(50, FlxG.height - 40);
			cam = new Cam(player);
			/*for each (var item:FlxSprite in map.ens.members) {
				if (item != null){
					item.y = background.sol.y - item.frameHeight;
				}
			}*/
			add(player);
			map = new Map(mapfile);
			speed = map.speed;

			//add(map.item);
			add(player.g);
			add(player.v);
			add(cam);
			FlxG.worldBounds = new FlxRect(0, 0, 5000, 600 + 1000);
			FlxG.camera.setBounds(0, -1000, 5000, 600 + 1000);
			FlxG.camera.follow(cam);
		}

		override public function update():void {
			super.update();
			
			
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
			
			//FlxG.collide(player, map.ens);
			FlxG.overlap(player, map.item, getTube);
			FlxG.overlap(player, map.destructible, check_ground);
			if (!FlxG.collide(player, map.tile, tiles_coll)) {
				lasttile = 0;
			}
		}

		public function getTube(obj1:FlxObject, obj2:FlxObject):void {
			FlxG.score += 10;
			obj2.kill();
			obj2.destroy();
		}
		
		public function check_ground(obj1:FlxObject, obj2:FlxObject):void {
			/*for each(var object:TmxObject in map.destructible.members) {
				if (object.custom["plaque"] == (obj2 as TmxObject).custom["plaque"]) {
					(object as FlxObject).kill();
				}
			}*/
			/*for each (var item:FlxSprite in map.ens.members) {
				if (item != null){
					item.y = background.sol.y - item.frameHeight;
				}
			}*/
			/*for (var i:int = 0; i < map.links.length; i++) {
				if (map.links[i] == "1")
					map.destructible.members[i].kill();
			}*/
			if (player.acceleration.y > 500)
				obj2.kill();
		}

		public function tiles_coll(obj1:FlxObject, obj2:FlxObject):void {
			//(obj2 as FlxTilemapExt).getTile
			var mytile:uint = (obj2 as FlxTilemapExt).getTile( Math.floor((player.x + 60) / 40),  Math.round((player.y + 80) / 40));
			/*if (mytile == FlxTilemapExt.SLOPE_FLOOR_LEFT && player.angle >= -45) {
				player.angularVelocity = -50;
				FlxG.log("LEFT");

			}
			else if (mytile == FlxTilemapExt.SLOPE_FLOOR_RIGHT) {
				player.angularVelocity = 50;
			}
			else {
				if (player.angle > 0) {
					//player.angle = 0;
					player.angularVelocity = 10;
					FlxG.log("test");
				}
			}*/
			if ((lasttile == 1) && (mytile != 1)) {
				player.velocity.y = -(player.velocity.x);
			}
			lasttile = mytile;
		//	trace(Math.round((player.y + 80) / 40) * 40 +Math.floor((player.x + 60) / 40));
		}

	}

}