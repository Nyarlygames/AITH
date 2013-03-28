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
		[Embed(source = '../assets/gfx/gameplay/Idle_Alien_Immobile.png')] protected var ImgIdle:Class;
		[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Rebond.mp3")] public var SfxRebond:Class;
		//[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Mort.mp3")] public var SfxMort:Class;
		
		public var soundRebond:FlxSound = new FlxSound();
		public var soundMort:FlxSound = new FlxSound();
		
		public function AlienNormal(xpos:int, ypos:int) 
		{
			super(xpos, ypos, null);
			soundRebond.loadEmbedded(SfxRebond);
			loadGraphic(ImgIdle, true, false, 160, 180);
			addAnimation("idle", [3, 2, 1, 0], 10, true);
			play("idle");
			//soundMort.loadEmbedded(SfxMort);
		}
		
	}

}