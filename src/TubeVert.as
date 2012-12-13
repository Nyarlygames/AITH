package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TubeVert extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/tubevert.png')] protected var ImgTube:Class;
		
		public function TubeVert(xpos:int, ypos:int, init:int) 
		{
			super(xpos, ypos, ImgTube);
			y -= frameHeight;
			velocity.x = init;
		}
		
	}

}