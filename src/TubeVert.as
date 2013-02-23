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
		[Embed(source = '../assets/gfx/grostubevert.png')] protected var ImgGrosTube:Class;
		public var loot:int = 0;
		
		public function TubeVert(xpos:int, ypos:int, point:int, id:int) 
		{
			super(xpos, ypos);
			switch (id) {
				case 0:
					loadGraphic(ImgTube);
					break;
				case 1:
					loadGraphic(ImgGrosTube);
					break;
			}
			y -= frameHeight;
			loot = point;
		}
		
	}

}