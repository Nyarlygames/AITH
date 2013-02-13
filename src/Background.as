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
		 [Embed(source = '../assets/gfx/aithlvl1.png')] public var ImgBackground2:Class;
		public function Background(level:int) 
		{
			// CHANGE L ARRIERE PLAN SUIVANT LE NIVEAU
			super(0, FlxG.height);
			switch (level) {
				case 1:
					loadGraphic(ImgBackground2);
					break;
				case 2:
					loadGraphic(ImgBackground);
					break;
				case 3:
					loadGraphic(ImgBackground2);
					break;
			}
			y -= frameHeight;
		}
		
	}

}