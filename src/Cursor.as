package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Cursor extends FlxSprite 
	{
		
		 [Embed(source = '../assets/gfx/cibleur.png')] public var ImgCursor:Class;
		 public var pos:int = 0;
		 
		public function Cursor() 
		{
				super(FlxG.width / 2 + 80, 0, ImgCursor);
		}
		
	}

}