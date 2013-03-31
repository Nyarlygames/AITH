package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * Piques
	 * @author ...
	 */
	public class Piques extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/piques.png')] protected var ImgPique:Class;
		
		public function Piques(xpos:int, ypos:int, dir:String) 
		{
			super(xpos, ypos, ImgPique);
			immovable = true;
			switch (dir) {
				case "bas":
					angle = 180;
					x += 5;
					width = frameWidth - 5;
					offset.x = 5;
					break;
				case "gauche":
					angle = -90;
					break;
				case "droite":
					angle = 90;
					break;
				case "haut":
					y += 5;
					height = frameHeight - 5;
					offset.y = 5;
			}
		}
		
	}

}