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
		public var loot:int = 0;
		
		public function Alien(xpos:int, ypos:int, count:int, init:int) 
		{
			super(xpos, ypos, ImgAlien);
			y -= frameHeight;
			loot = count;
			velocity.x = init;
		}
		
	}

}