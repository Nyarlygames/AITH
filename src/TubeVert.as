package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * Tube vert
	 * @author ...
	 */
	public class TubeVert extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/tubevert.png')] protected var ImgTube:Class;
		public var loot:int = 0;
		
		public function TubeVert(xpos:int, ypos:int, point:int) 
		{
			super(xpos, ypos, ImgTube);
			y -= frameHeight;
			loot = point;
		}
		
	}

}