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
		[Embed(source = '../assets/gfx/gameplay/point_d_exclamation.png')] protected var ImgIncomming:Class;
		//[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Rebond.mp3")] public var SfxRebond:Class;
		//[Embed(source = "../assets/sfx/gameplay/AlienImmobile_Mort.mp3")] public var SfxMort:Class;
		
		
		public var soundRebond:FlxSound = new FlxSound();
		public var soundMort:FlxSound = new FlxSound();
		public var speed:int = 200;							// VITESSE DE DEPLACEMENT
		public var incomming:FlxSprite = null;
		public var killed:Boolean = false;
		
		public function AlienHorizontal(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAlienHor);
			//soundRebond.loadEmbedded(SfxRebond);
			//soundMort.loadEmbedded(SfxMort);
			
			//Animations du joueur
		/*	this.loadGraphic(ImgAlienHor, true, false, 80, 80);
			this.addAnimation("bounce",  [0,1], 5, true);
			this.addAnimation("idle", 	[4,5], 5, true);
			this.addAnimation("die",  [8,9,10], 5, true);*/
			
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
				incomming.kill();
				incomming.destroy();
			}
			if ((FlxG.player.x >= x - 1500) && (incomming == null)){
				incomming = new FlxSprite(800, y);
				incomming.loadGraphic(ImgIncomming, true, false, 60, 60);
				incomming.y -= frameHeight + incomming.frameHeight + 30;
				incomming.x -= incomming.frameWidth;
				incomming.addAnimation("incomming", [0, 1, 2, 3], 10, true);
				incomming.play("incomming");
				incomming.scrollFactor = new FlxPoint(0, 0);
				FlxG.state.add(incomming);
			}
		}
		
		private function killing(animationName:String, frameNumber:uint, frameIndex:uint):void {  
			if ((animationName == "mort") && (frameNumber == 3))
				kill();
		}	
	}
}