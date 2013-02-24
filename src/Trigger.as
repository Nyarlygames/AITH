package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * Trigger
	 * @author ...
	 */
	public class Trigger extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/trigger.png')] protected var ImgTrigger:Class;
		public function Trigger(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgTrigger);
			immovable = true;
		}
	}

}