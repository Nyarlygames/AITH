package  
{
	import flash.utils.Timer;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.FlxPoint;
	import org.flixel.plugin.photonstorm.FlxControl;
	import org.flixel.plugin.photonstorm.FlxControlHandler;
	import org.flixel.FlxObject;
	import org.flixel.plugin.photonstorm.FlxScrollZone;
	
	/**
	 * Niveau
	 * @author ...
	 */
	public class Play extends FlxState 
	{
		
		public var player:Player;
		public var map:Map;
		public var background:Background = new Background();
		public var speed:int = 0;
		
		public function Play(lvl:Map) 
		{	 
			if (FlxG.getPlugin(FlxScrollZone) == null)
			{
				FlxG.addPlugin(new FlxScrollZone);
			}
			super.update();
			map = lvl;
			speed = lvl.speed;
			add(background);
			add(background.sol);
			player = new Player(50,FlxG.height - (FlxG.height - background.sol.y) - background.sol.frameHeight);
			for each (var item:FlxSprite in map.ens.members) {
				if (item != null){
					item.y = background.sol.y - item.frameHeight;
				}
			}
			add(map.ens);
			add(map.obs);
			add(player.roues);
			add(player);
		}
		
		override public function update():void {
			super.update();
			FlxG.collide(player.roues, background.sol);
			FlxG.collide(player, player.roues);
			
			if (player.pos == 700) {
				for each (var ob:Jump in map.obs.members) {
					if (ob != null){
						player.followPath(ob.my_path);
					}
				}
			}
			
			for each (var item:FlxSprite in map.ens.members) {
				if (item != null){
				//	FlxG.collide(player.roues, item);
				//	FlxG.collide(player, item);
				}
			}
		}
				
	}

}