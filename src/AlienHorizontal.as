package  
{
	import org.flixel.FlxPoint;
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
		[Embed(source = '../assets/gfx/gameplay/Samerelatilemobile.png')] protected var ImgIdle:Class;
		//[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Rebond.mp3")] public var SfxRebond:Class;
		//[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Mort.mp3")] public var SfxMort:Class;
		
		
		public var soundRebond:FlxSound = new FlxSound();
		public var soundMort:FlxSound = new FlxSound();
		public var speed:int = 200;							// VITESSE DE DEPLACEMENT
		public var incomming:FlxSprite;
		
		public function AlienHorizontal(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAlienHor);
			//soundRebond.loadEmbedded(SfxRebond);
			//soundMort.loadEmbedded(SfxMort);
			
			loadGraphic(ImgIdle, true, false, 120, 110);
			addAnimation("idle", [0, 1, 2], 10, true);
			addAnimation("rebonds", [4, 5, 6, 7], 10, false);
			addAnimation("mort", [8, 9, 10, 11], 10, false);
			addAnimationCallback(killing);
			play("idle");
		}
		
		override public function update():void {
			if (onScreen(FlxG.camera)) {
				velocity.x = -speed;
			}
			if ((FlxG.player.x >= x - 1000) && (incomming == null)){
				incomming = new IndicateurAlien(this);
			}
		}
		
		private function killing(animationName:String, frameNumber:uint, frameIndex:uint):void {  
			if ((animationName == "mort") && (frameNumber == 3))
				kill();
		}	
	}
}