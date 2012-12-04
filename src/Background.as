package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxSound;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Background extends FlxSprite 
	{
		public var sound:FlxSound;
			
		
		 [Embed(source = '../assets/gfx/background.png')] public var ImgBackground:Class;
		public function Background() 
		{
			super(0, 0, ImgBackground);
			sound = new FlxSound();
			sound.loadStream("../assets/sfx/musiques/Shinshuu_Plains_I.mp3", true, true);
			sound.play();
			
		}
		
	}

}