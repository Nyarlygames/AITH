package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Piques extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/piques.png')] protected var ImgPique:Class;
		
		public function Piques(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgPique);
			y -= frameHeight;
			immovable = true;
		}
		
	}

}