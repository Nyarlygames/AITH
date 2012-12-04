package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Dragons extends FlxSprite 
	{
		
		public var sound:FlxSound;
		 [Embed(source = '../assets/gfx/dragons.png')] public var ImgDragons:Class;
		 
		public function Dragons(x:int, y:int) 
		{
			super(x, y, ImgDragons);
		}
		
		
	}

}