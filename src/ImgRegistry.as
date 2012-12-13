package  
{

	import org.flixel.FlxObject;

	/**
	 * ...
	 * @author ...
	 */
	public class ImgRegistry extends FlxObject 
	{
		
		
		[Embed(source = '../assets/gfx/ld1.png')] public var ImgJump1:Class;
		public var assets:Array = new Array();
		
		public function ImgRegistry() 
		{
			assets.push(ImgJump1);
		}
	}

}