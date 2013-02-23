package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Alien extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/alien.png')] protected var ImgAlien:Class;
		public var loot:int = 1;
		
		public function Alien(xpos:int, ypos:int, img:Class) 
		{
			super(xpos, ypos, img);
			y -= frameHeight;
			elasticity = 1;
			immovable = true;
		}
		
	}

}