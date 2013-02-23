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
		[Embed(source = '../assets/gfx/level/background/bg_level_1_1_1_alt1.png')] public var ImgBackground2:Class;
		[Embed(source = '../assets/gfx/solv3.png')] public var ImgSol:Class;
		 
		public function Background(level:int) 
		{
			// CHANGE L ARRIERE PLAN SUIVANT LE NIVEAU
			super(0, FlxG.height);
			switch (level) {
				case 1:
					sol = new FlxSprite(0, FlxG.height, ImgSol);
					loadGraphic(ImgBackground2);
					break;
				case 2:
					sol = new FlxSprite(0, FlxG.height, ImgSol);
					loadGraphic(ImgBackground);
					break;
				case 3:
					sol = new FlxSprite(0, FlxG.height, ImgSol);
					loadGraphic(ImgBackground2);
					break;
			}
			y -= frameHeight;
			sol.y -= sol.frameHeight;
			FlxG.state.add(this);
			FlxG.state.add(sol);
		}
		
	}

}