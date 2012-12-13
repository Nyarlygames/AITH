package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Jump extends FlxSprite 
	{
		
		public var reg:ImgRegistry = new ImgRegistry();
		
		public function Jump(x:int, y:int, index:int, init:int) 
		{
			super(x, y, reg.assets[index - 1]);
			elasticity = 1;
			immovable = true;
			velocity.x = init;
		}
		
	}

}