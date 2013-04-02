package  
{
	import org.flixel.FlxRect;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxTimer;
	
	/**
	 * Tourelle
	 * @author ...
	 */
	public class Tourelle extends FlxSprite
	{
		[Embed(source = '../assets/gfx/gameplay/overboard_tourelle.png')] protected var ImgTourelle:Class;
		[Embed(source = '../assets/gfx/gameplay/flamme.png')] protected var ImgFlamme:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Laser_On.wav')] public var SfxLaserOn:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Laser_Off.wav')] public var SfxLaserOff:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Laser.wav')] public var SfxLaser:Class;
		public var rate:int = 1500;							// CADENCE DE TIR
		public var maxtir:int = 200;						// MAXIMUM DE TIR
		public var speed:int = 300;							// VITESSE DE TIR
		public var gravity:int = 1000;						// GRAVITE DE TIR
		public var flammes:FlxSprite;
		public var timer:FlxTimer = new FlxTimer();
		public var laseroff:FlxSound = new FlxSound;
		public var laseron:FlxSound = new FlxSound;
		public var laser:FlxSound = new FlxSound;
		
		
		/* flammes 40      20 - 60
		 * overboard 80      40 */
		
		public function Tourelle(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgTourelle);
			if (flammes == null) {
				flammes = new FlxSprite(x + 20, y + frameHeight);
				flammes.loadGraphic(ImgFlamme, true, false, 40, 160);
				flammes.addAnimation("flammes",  [0, 1, 2, 3, 4, 2, 3, 4, 3, 2 , 1, 0], 10, false);
				flammes.addAnimation("dead",  [5], 1, false);
				FlxG.state.add(flammes);
				timer.start(3, 0, activate_burst);
			}
			loadGraphic(ImgTourelle, true, false, 80, 40);
			addAnimation("default",  [0, 1, 2], 10, true);
			
			/* Pré-écriture de l'anim de flamme, à réutiliser.
				this.loadGraphic(ImgFlamme, true, false, 40, 80);
				this.addAnimation("burn",  [0, 1, 2,3,4,5], 5, true);
			*/
			play("default");
			flammes.addAnimationCallback(firingmahlaser);
			// Gestion de la flamme
			laser.loadEmbedded(SfxLaser, false, false);
			laseroff.loadEmbedded(SfxLaserOff, false, false);
			laseron.loadEmbedded(SfxLaserOn, false, false)
			laser.volume = 0.8;
		}
		
		override public function update():void 
		{
			if (FlxCollision.pixelPerfectCheck(FlxG.player, flammes)) {
				FlxG.player.die_motherfucker(0);
			}
		}
		
		private function firingmahlaser(animationName:String, frameNumber:uint, frameIndex:uint):void 
		{  			
			/*if (onScreen(FlxG.camera)) {
				if ((animationName == "flammes") && (frameNumber > 2)) {
					/*laseroff.stop();
					laseron.play();
				}
			}*/
	
		}		
		
		public function activate_burst(timer:FlxTimer):void {
			if ((flammes != null)){
				flammes.play("flammes");
				if (onScreen(FlxG.camera)) {
					laser.play();
				}
			}
		}
	}
}