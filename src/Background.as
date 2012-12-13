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
		
		 [Embed(source = '../assets/gfx/bg.png')] public var ImgBackground:Class;
		 [Embed(source = '../assets/gfx/sol.png')] public var ImgSol:Class;
		public function Background() 
		{
			super(0, FlxG.height, ImgBackground);
			y -= frameHeight;
			sol = new FlxSprite(0, FlxG.height - 50, ImgSol);
			
			sol.makeGraphic(FlxG.width, 10, 0xaaFFFFFF, true);
			sol.y -= sol.frameHeight;
			sol.immovable = true;
			FlxScrollZone.add(this, new Rectangle(0, 0, this.width, this.height), -1, 0);
			/*sound = new FlxSound();
			sound.loadStream("../assets/sfx/musiques/Shinshuu_Plains_I.mp3", true, true);
			sound.play();*/
			
		}
		
	}

}