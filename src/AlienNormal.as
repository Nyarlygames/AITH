package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxSound;
	
	/**
	 * Alien normaux
	 * @author ...
	 */
	public class AlienNormal extends Alien
	{
		
		[Embed(source = '../assets/gfx/gameplay/alien_normal.png')] protected var ImgAlienNormal:Class;
		[Embed(source = '../assets/gfx/gameplay/Samerelatile.png')] protected var ImgIdle:Class;
		[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Rebond.mp3")] public var SfxRebond:Class;
		//[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Mort.mp3")] public var SfxMort:Class;
		
		public var soundRebond:FlxSound = new FlxSound();
		public var soundMort:FlxSound = new FlxSound();
		public var killed:Boolean = false;
		
		public function AlienNormal(xpos:int, ypos:int) 
		{
			super(xpos, ypos, null);
			soundRebond.loadEmbedded(SfxRebond);
			loadGraphic(ImgIdle, true, false, 160, 180);
			addAnimation("idle", [3, 2, 1, 0], 10, true);
			addAnimation("mort", [4, 5, 6, 7], 10, false);
			addAnimation("rebonds", [8, 9, 10, 11], 10, false);
			addAnimationCallback(killing);
			play("idle");
			//soundMort.loadEmbedded(SfxMort);
		}
				
		private function killing(animationName:String, frameNumber:uint, frameIndex:uint):void {  
			if ((animationName == "mort") && (frameNumber == 3))
				kill();
		}		
	}

}