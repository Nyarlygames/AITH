package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * EndGame
	 * @author ...
	 */
	public class UnlockUniv2 extends FlxState 
	{
		[Embed(source = '../assets/gfx/ui/get-univ2.png')] protected var ImgGG:Class;
		public var gg:FlxSprite;
		
		public function UnlockUniv2() 
		{
			gg = new FlxSprite(0, 0, ImgGG);
			add(gg);
		}
	
		override public function update():void {
			if (FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) {
				FlxG.switchState(new UnivChooser);
			}
		}
	}

}