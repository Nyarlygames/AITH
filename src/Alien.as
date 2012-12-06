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
		
		public function Alien(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAlien);
			y -= frameHeight;
		}
		
	}

}