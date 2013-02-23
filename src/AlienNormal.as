package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * Alien normaux
	 * @author ...
	 */
	public class AlienNormal extends Alien
	{
		
		[Embed(source = '../assets/gfx/alien.png')] protected var ImgAlienNormal:Class;
		
		public function AlienNormal(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAlienNormal);
		}
		
	}

}