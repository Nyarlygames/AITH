package  
{
	import flash.system.System;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxScrollZone;
	import org.flixel.FlxSprite;
	
	/**
	 * Event des touches
	 * @author ...
	 */
	public class KeyEvent extends FlxObject
	{
		
		public var play:Play;
		public var jump:FlxDelay;
		
		public function KeyEvent(niveau:Play) 
		{
			play = niveau;
		}
		
		override public function update():void
		{
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
			if (FlxG.keys.pressed("SPACE")) {
				/*play.player.roues.members[0].maxVelocity.x = 2 * play.player.speed;
				play.player.roues.members[1].maxVelocity.x = 2 * play.player.speed;*/
				play.player.maxVelocity.x = 2 * play.player.speed;
				play.player.acceleration.y = 5000;
				/*	RALENTISSEMENT
				 * 	for each (var item:FlxSprite in play.map.ens.members)
						item.velocity.x = -75;
					play.player.acceleration.x = -30;*/
			}
			
			
			if (FlxG.keys.pressed("UP")) {
				if (play.player.g.scale.x <= 1)
					play.player.g.scale.x += FlxG.elapsed;
				if (play.player.v.scale.x >= 0) {
					play.player.v.scale.x -= FlxG.elapsed;
				}
			}
			else {
				if (play.player.g.scale.x >= 0 )
					play.player.g.scale.x -= FlxG.elapsed;
				if (play.player.v.scale.x <= 1)
				play.player.v.scale.x += FlxG.elapsed;
			}
			
			/*if ((FlxG.keys.pressed("SHIFT")) && (play.player.y + play.player.frameHeight == play.background.y)) {
				jump = new FlxDelay(1000);
				jump.start();
				play.player.acceleration.y = -50;
			}*/
			/*if ((jump != null) && (jump.hasExpired == true)) {
				play.player.acceleration.y = 50;
				jump = null;
			}*/
		}
		
	}

}