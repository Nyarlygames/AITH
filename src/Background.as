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
			
		
		 [Embed(source = '../assets/gfx/background.png')] public var ImgBackground:Class;
		public function Background() 
		{
			super(0, FlxG.height, ImgBackground);
			y -= frameHeight;
			immovable = true;
			FlxScrollZone.add(this, new Rectangle(0, 0, this.width, this.height), -3, 0);
			/*sound = new FlxSound();
			sound.loadStream("../assets/sfx/musiques/Shinshuu_Plains_I.mp3", true, true);
			sound.play();*/
			
		}
		
	}

}