package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxSound;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Destructible_ground extends FlxSprite 
	{
        [Embed(source = '../assets/gfx/gameplay/sol_destructible_animv3.png')] public var ImgDesSol:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'SolDestructible_EnDestruction.wav')] public var SfxCrepite:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'SolDestructible_Destruction.wav')] public var SfxDestrSol:Class;
		public var destruction:Boolean = false;
		public var soundCrepite:FlxSound = new FlxSound();
		public var soundDestrSol:FlxSound = new FlxSound();
		public var rolled:Boolean = false;
		
		public function Destructible_ground(xpos:int, ypos:int) 
		{	

			soundCrepite.loadEmbedded(SfxCrepite);
			soundDestrSol.loadEmbedded(SfxDestrSol);
			super(xpos, ypos);
			immovable = true;
			loadGraphic(ImgDesSol, true, false, 200, 205);
			addAnimation("destruction",  [1, 2, 3, 4, 5, 6, 7], 15, false);
			addAnimationCallback(destroyed);
			height = 25;
		}
		
		override public function update():void {
			if ((rolled == true) && (!onScreen(FlxG.camera))) {
					soundCrepite.stop();
					soundCrepite.kill();
			}
		}
		private function destroyed(animationName:String, frameNumber:uint, frameIndex:uint):void {  
			if (frameNumber == 6)
				kill();
		}
	}

}