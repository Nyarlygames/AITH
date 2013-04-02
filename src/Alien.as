package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxSound;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Alien extends FlxSprite 
	{
		public var loot:int = 1;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Alien_Mort1.wav')] public var SfxAlienMort1:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Alien_Mort2.wav')] public var SfxAlienMort2:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Alien_Mort3.wav')] public var SfxAlienMort3:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Alien_rebond1.wav')] public var SfxRebond1:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Alien_rebond2.wav')] public var SfxRebond2:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Alien_rebond3.wav')] public var SfxRebond3:Class;
		public var alienrebond1:FlxSound = new FlxSound();
		public var alienrebond2:FlxSound = new FlxSound();
		public var alienrebond3:FlxSound = new FlxSound();
		public var alienkillsfx1:FlxSound = new FlxSound();
		public var alienkillsfx2:FlxSound = new FlxSound();
		public var alienkillsfx3:FlxSound = new FlxSound();
		public var alienrebond:FlxSound = new FlxSound();
		public var alienkillsfx:FlxSound = new FlxSound();
		public var killed:Boolean = false;
		
		
		public function Alien(xpos:int, ypos:int, img:Class) 
		{
			super(xpos, ypos, img);
			alienkillsfx1.loadEmbedded(SfxAlienMort1);
			alienkillsfx2.loadEmbedded(SfxAlienMort2);
			alienkillsfx3.loadEmbedded(SfxAlienMort3);
			alienrebond1.loadEmbedded(SfxRebond1);
			alienrebond2.loadEmbedded(SfxRebond2);
			alienrebond3.loadEmbedded(SfxRebond3);
			alienkillsfx1.volume = 1;
			alienkillsfx2.volume = 1;
			alienkillsfx3.volume = 1;
			alienkillsfx.volume = 1;
			alienrebond.volume = 0.7;
			alienrebond1.volume = 0.7;
			alienrebond2.volume = 0.7;
			alienrebond3.volume = 0.7;
			elasticity = 1;
			immovable = true;
		}
		
	}

}