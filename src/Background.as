package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxSound;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxScrollZone;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Background extends FlxSprite 
	{
		public var sound:FlxSound;
		public var sol:FlxSprite;
		
		 [Embed(source = '../assets/gfx/aithlvl1.png')] public var ImgBackground:Class;
		public function Background() 
		{
			super(0, FlxG.height, ImgBackground);
			y -= frameHeight;
			/*sound = new FlxSound();
			sound.loadStream("../assets/sfx/musiques/Shinshuu_Plains_I.mp3", true, true);
			sound.play();*/
			
		}
		
	}

}