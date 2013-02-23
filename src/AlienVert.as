package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	import org.flixel.FlxPath;
	
	/**
	 * Alien_vertical
	 * @author ...
	 */
	public class AlienVert extends Alien
	{
		
		[Embed(source = '../assets/gfx/alien_vert.png')] protected var ImgAlienVer:Class;
		
		public var pathnodes:Array = new Array();
		public var my_path:FlxPath;
		public var length:int = 40;              // DISTANCE DE DEPLACEMENT
		
		public function AlienVert(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAlienVer);
			pathnodes.push(new FlxPoint(x, y-length));
			pathnodes.push(new FlxPoint(x, y+length));
			my_path = new FlxPath(pathnodes);
			followPath(my_path,  100, PATH_LOOP_FORWARD);
		}
		
	}

}