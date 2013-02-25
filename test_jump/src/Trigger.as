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
		public function Trigger(xpos:int, ypos:int) 
		{
			super(xpos, ypos);
			immovable = true;
			visible = false;
		}
	}

}