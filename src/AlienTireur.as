package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	
	/**
	 * Alien tireur
	 * @author ...
	 */
	public class AlienTireur extends Alien
	{
		[Embed(source = '../assets/gfx/alien_tireur.png')] protected var ImgAlienTir:Class;
		public var length:int = 40;							// DISTANCE DE DEPLACEMENT
		
		public function AlienTireur(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAlienTir);
		}
	}
}