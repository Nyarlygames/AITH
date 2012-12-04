package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * écran gauche
	 * @author ...
	 */
	
	public class Gauche extends FlxSprite
	{
		
		public function Gauche(Img:Class)
		{
			super(0, FlxG.height, Img);
			y -= frameHeight;
			immovable = true;
			velocity.x = 0;
			velocity.y = 0;
		}
	}

}