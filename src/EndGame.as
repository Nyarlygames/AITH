package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * EndGame
	 * @author ...
	 */
	public class EndGame extends FlxState 
	{
		[Embed(source = '../assets/gfx/ui/endGame.png')] protected var ImgGG:Class;
		public var gg:FlxSprite;
		
		public function EndGame() 
		{
			gg = new FlxSprite(0, 0, ImgGG);
			add(gg);
		}
	
		override public function update():void {
		}
	}

}