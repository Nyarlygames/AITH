package  
{
	import flash.system.System;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * Event des touches
	 * @author ...
	 */
	public class KeyEvent extends FlxObject
	{
		
		public var play:Play;
		
		public function KeyEvent(niveau:Play) 
		{
			play = niveau;
		}
		
		override public function update():void
		{
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
			if (play.isMoving == false) {
				if (FlxG.keys.justPressed("UP")  && (play.cursor.pos > 0)) {
					play.cursor.pos--;
					play.cursor.y = (play.choices.choice.frameHeight /4) * play.cursor.pos;
					play.select.y = (play.choices.choice.frameHeight /4)* play.cursor.pos;
				}
				if (FlxG.keys.justPressed("DOWN") && (play.cursor.pos < 3)) {
					play.cursor.pos++;
					play.cursor.y = (play.choices.choice.frameHeight /4) * play.cursor.pos;
					play.select.y = (play.choices.choice.frameHeight /4)* play.cursor.pos;
				}
			}
		}
		
	}

}