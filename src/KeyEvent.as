package  
{
	import flash.system.System;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
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
			if ((FlxG.keys.pressed("UP")) && (play.player.y + play.player.frameHeight == play.background.y)) {
				jump = new FlxDelay(1000);
				jump.start();
				play.player.acceleration.y = -50;
			}
			if ((jump != null) && (jump.hasExpired == true)) {
				play.player.acceleration.y = +50;
			}
		}
		
	}

}