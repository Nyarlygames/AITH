package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * Alien horizontal
	 * @author ...
	 */
	public class AlienHorizontal extends Alien 
	{
		
		[Embed(source = '../assets/gfx/alien_horizontal.png')] protected var ImgAlienHor:Class;
		public var speed:int = 200;							// VITESSE DE DEPLACEMENT
		
		public function AlienHorizontal(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAlienHor);
		}
		
		override public function update():void {
			if (onScreen(FlxG.camera)) {
				velocity.x = -speed;
			}
		}
	}
}