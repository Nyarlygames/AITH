package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	import org.flixel.FlxPath;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AlienTireur extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/alien_vert.png')] protected var ImgAlien:Class;
		public var loot:int = 0;
		public var pathnodes:Array = new Array();
		public var my_path:FlxPath;
		public var length:int = 40;							// DISTANCE DE DEPLACEMENT
		
		public function AlienTireur(xpos:int, ypos:int, count:int) 
		{
			super(xpos, ypos, ImgAlien);
			pathnodes.push(new FlxPoint(x, y-length));
			pathnodes.push(new FlxPoint(x, y+length));
			my_path = new FlxPath(pathnodes);
			y -= frameHeight;
			loot = count;
			elasticity = 1;
			immovable = true;
			followPath(my_path,  100, PATH_LOOP_FORWARD);
		}
		
	}

}