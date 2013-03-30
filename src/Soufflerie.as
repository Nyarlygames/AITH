package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	import org.flixel.FlxEmitter;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	
	/**
	 * Soufflerie
	 * @author ...
	 */
	public class Soufflerie extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/soufflerie.png')] 		protected var ImgSoufflerie:Class;
		[Embed(source = '../assets/gfx/gameplay/souffle.png')] 			protected var ImgSouffle:Class;
		[Embed(source = '../assets/gfx/gameplay/soufflePart.png')] 		protected var ImgPartSouffle:Class;
		
		[Embed(source = "../assets/sfx/gameplay/Soufflerie_idle.mp3")] 		public var SfxIdle:Class;
		[Embed(source = "../assets/sfx/gameplay/Soufflerie_in.mp3")] 		public var SfxIn:Class;
		
		public var soundIdle:FlxSound 		= new FlxSound();
		public var soundIn:FlxSound 		= new FlxSound();
		public var gravityup:int = 1000;								// GRAVITY MODIFIER
		public var emitter:FlxEmitter;						// MOTEUR
		public var applied:Boolean = false;
		public var boost:int = 200;
		public var souffle:FlxSprite;
		
		public function Soufflerie(xpos:int, ypos:int, orient:int) 
		{
			super(xpos, ypos, ImgSoufflerie);
			
			soundIdle.loadEmbedded(SfxIn);
			soundIn.loadEmbedded(SfxIn);
			
			immovable = true;
			angle = orient;
			
			/*if ((angle == 90) || (angle == -90))
				x += frameWidth / 2;*/
				
			this.loadGraphic(ImgSoufflerie, true, false, 80, 40);
			this.addAnimation("default", [0, 1, 2, 3], 12, true);
			this.play("default");
				
			/*
			souffle = new FlxSprite(xpos, ypos, ImgSouffle);
			souffle.loadGraphic(ImgSouffle, true, false, 80, 320);
			souffle.addAnimation("default", [0, 1, 2, 3], 12, true);
			souffle.y -= souffle.frameHeight;
			souffle.play("default");
			FlxG.state.add(souffle);
			*/
			
			// Emitter à paramétrer encore :)
			emitter = new FlxEmitter(this.x + frameWidth / 2, this.y, 20);
			for (var i:int = 0; i < 20; i++) 
			{
				var p:FlxParticle = new FlxParticle();
				p.loadGraphic(ImgPartSouffle);
				emitter.add(p);
			}
			emitter.gravity = -200;
			emitter.setYSpeed( -5, -400);
			emitter.start(false, 0.8,0.1, 0);
			FlxG.state.add(emitter);
		}
	
		override public function update():void {
			
			if (onScreen(FlxG.camera))
			{
				//soundIdle.play();
			}
			if (FlxG.player != null)
				if (FlxG.overlap(FlxG.player, emitter)) 
				{
					FlxG.player.velocity.y -= gravityup * FlxG.elapsed;
				}
				/* TODO 
				 * Gerer les différents angles de soufflerie
				 */
		}
	}

}