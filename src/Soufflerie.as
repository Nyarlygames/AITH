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
		
		public var soundIdle:FlxSound 	= new FlxSound();
		public var soundIn:FlxSound 	= new FlxSound();
		public var gravityup:int 		= 1000;				// Puissance du souffle en Y
		public var speedSouffle:int 	= 3000;				// Puissance du souffle en X
		public var speedBasSouffle:int 	= 10000;			// Puissance du souffle en -X
		public var emitter:FlxEmitter;						// MOTEUR
		public var applied:Boolean		= false;
		public var boost:int			= 200;
		public var souffle:FlxSprite;
		//   0 -> Haut
		//   90 -> Droite
		//   180 -> Bas
		// - 90 -> Gauche
		
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
			
			if (angle == 0)
			{
				this.angle = 0;
				// Emitter
				emitter = new FlxEmitter(this.x + frameWidth / 2, this.y, 10);
				for (var i:int = 0; i < 10; i++) 
				{
					var v:FlxParticle = new FlxParticle();
					v.loadGraphic(ImgPartSouffle);
					emitter.add(v);
				}
				emitter.gravity = -200;
				emitter.setYSpeed( -5, -400);
				emitter.start(false, 0.8, 0.05, 0);
			}
			if (angle == 90)
			{
				this.angle = 0;
			}
			if (angle == 180)
			{
				// Emitter
				emitter = new FlxEmitter(this.x + frameWidth / 2, this.y + frameWidth, 10);
				for (var g:int = 0; g < 10; g++) 
				{
					var u:FlxParticle = new FlxParticle();
					u.loadGraphic(ImgPartSouffle);
					emitter.add(u);
				}
				emitter.gravity = -200;
				emitter.setYSpeed( 10, 400);
				emitter.start(false, 0.8, 0.05, 0);
			}
			if (angle == -90)
			{
				this.angle = -90;
				// Emitter
				emitter = new FlxEmitter(this.x, this.y + frameWidth / 2, 10);
				for (var l:int = 0; l < 10; l++) 
				{
					var d:FlxParticle = new FlxParticle();
					d.loadGraphic(ImgPartSouffle);
					emitter.add(d);
				}
				emitter.gravity = -200;
				emitter.setXSpeed( -10, -400);
				emitter.start(false, 0.8, 0.05, 0);
			}
			FlxG.state.add(emitter);
		}
	
		override public function update():void {
			
			if (onScreen(FlxG.camera))
			{
				//soundIdle.play();
			}
			FlxG.overlap(emitter, FlxG.map.destructible, souffle_sol);
			FlxG.collide(emitter, FlxG.map.tile, souffle_sol);
			
			if (FlxG.player != null)
			{
				if (FlxG.overlap(FlxG.player, emitter) && angle == 0 ) 
				{
					FlxG.player.velocity.y -= gravityup * FlxG.elapsed;
				}
				else if (FlxG.overlap(FlxG.player, emitter) && angle == 90 ) 
				{
					FlxG.player.velocity.x -= speedSouffle * FlxG.elapsed;
				}
				else if (FlxG.overlap(FlxG.player, emitter) && angle == 180 ) 
				{
					FlxG.player.velocity.y += speedBasSouffle * FlxG.elapsed;
				}
				else if (FlxG.overlap(FlxG.player, emitter) && angle == -90 ) 
				{
					if ( FlxG.player.velocity.x > FlxG.player.minspeed - speedSouffle * FlxG.elapsed)
					{
						FlxG.player.velocity.x -= speedSouffle * FlxG.elapsed;
					}
				}
			}
		}

		public function souffle_sol(obj1:FlxSprite, obj2:FlxObject):void 
		{
			obj1.kill();
		}
	}

}