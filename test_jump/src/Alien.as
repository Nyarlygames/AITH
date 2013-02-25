package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Alien extends FlxSprite 
	{
		public var loot:int = 1;
		
		public function Alien(xpos:int, ypos:int, img:Class) 
		{
			super(xpos, ypos, img);
			elasticity = 1;
			immovable = true;
		}
		
	}

}