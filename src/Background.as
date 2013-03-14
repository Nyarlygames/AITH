package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxSound;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxScrollZone;
	import flash.geom.Rectangle;
	import org.flixel.FlxTilemap;
	
	/**
	 * Arriere plan
	 * @author ...
	 */
	public class Background extends FlxSprite 
	{
		public var sound:FlxSound;
		public var sol:FlxSprite;
		 
		[Embed(source = '../assets/gfx/levels/bg_lvl_1_1.png')] public var ImgBackground:Class;
		[Embed(source = '../assets/gfx/levels/bg_lvl_1_1.png')] public var ImgBackground2:Class;
		[Embed(source = '../assets/gfx/levels/sol_lvl_1_1.png')] public var ImgSol:Class;
		[Embed(source = '../assets/gfx/levels/sol_lvl_1_2.png')] public var ImgSol2:Class;
		 
		public function Background(level:int, fond:FlxTilemap, far:FlxTilemap, middle:FlxTilemap, near:FlxTilemap, clouds:FlxTilemap) 
		{
			// CHANGE L ARRIERE PLAN SUIVANT LE NIVEAU
			super(0, FlxG.height + 200);
			switch (level) {
				case 1:
					sol = new FlxSprite(0, FlxG.height + 200, ImgSol);
					loadGraphic(ImgBackground2);
					break;
				case 2:
					sol = new FlxSprite(0, FlxG.height + 200, ImgSol);
					loadGraphic(ImgBackground2);
					break;
				case 3:
					sol = new FlxSprite(0, FlxG.height + 200, ImgSol);
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