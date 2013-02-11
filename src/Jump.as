package  
{
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Jump extends FlxSprite 
	{
		
		public var reg:ImgRegistry = new ImgRegistry();
		public var pathnodes:Array = new Array();
		public var my_path:FlxPath;
		
		public function Jump(x:int, y:int, index:int, init:int) 
		{
			super(x, y, reg.assets[index - 1]);
			pathnodes.push(new FlxPoint(x+120, y));
			pathnodes.push(new FlxPoint(x+310, y));
			pathnodes.push(new FlxPoint(x+420, y+40));
			my_path = new FlxPath(pathnodes);
			elasticity = 1;
			immovable = true;
			velocity.x = init;
		}
		
	}

}