package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Destructible_ground extends FlxSprite 
	{
        [Embed(source = '../assets/gfx/gameplay/sol_destructible_animv3.png')] public var ImgDesSol:Class;
		public var destruction:Boolean = false;
		
		public function Destructible_ground(xpos:int, ypos:int) 
		{	
			super(xpos, ypos);
			immovable = true;
			loadGraphic(ImgDesSol, true, false, 200, 205);
			addAnimation("destruction",  [1, 2, 3, 4, 5, 6, 7], 15, false);
			addAnimationCallback(destroyed);
		}
		
		private function destroyed(animationName:String, frameNumber:uint, frameIndex:uint):void {  
			if (frameNumber == 6)
				kill();
		}
	}

}