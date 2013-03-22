package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	
	/**
	 * Alien horizontal
	 * @author ...
	 */
	public class AlienHorizontal extends Alien 
	{
		
		[Embed(source = '../assets/gfx/gameplay/alien_horizontal.png')] protected var ImgAlienHor:Class;
		//[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Rebond.mp3")] public var SfxRebond:Class;
		//[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Mort.mp3")] public var SfxMort:Class;
		
		
		public var soundRebond:FlxSound = new FlxSound();
		public var soundMort:FlxSound = new FlxSound();
		public var speed:int = 200;							// VITESSE DE DEPLACEMENT
		
		public function AlienHorizontal(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAlienHor);
			//soundRebond.loadEmbedded(SfxRebond);
			//soundMort.loadEmbedded(SfxMort);
			
			//Animations du joueur
			this.loadGraphic(ImgAlienHor, true, false, 80, 80);
			this.addAnimation("bounce",  [0,1], 5, true);
			this.addAnimation("idle", 	[4,5], 5, true);
			this.addAnimation("die",  [8,9,10], 5, true);
		}
		
		override public function update():void {
			if (onScreen(FlxG.camera)) {
				velocity.x = -speed;
			}
		}
	}
}