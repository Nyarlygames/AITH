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
		[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Rebond.mp3")] public var SfxRebond:Class;
		//[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Mort.mp3")] public var SfxMort:Class;
		
		public var soundRebond:FlxSound = new FlxSound();
		public var soundMort:FlxSound = new FlxSound();
		
		public function AlienNormal(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAlienNormal);
			soundRebond.loadEmbedded(SfxRebond);
			//soundMort.loadEmbedded(SfxMort);
		}
		
	}

}