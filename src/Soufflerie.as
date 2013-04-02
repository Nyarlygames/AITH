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
		[Embed(source = '../assets/gfx/gameplay/soufflerie_anim_souffle.png')] 			protected var ImgSouffle:Class;
		[Embed(source = '../assets/gfx/gameplay/soufflePart.png')] 		protected var ImgPartSouffle:Class;
		
		//[Embed(source = "../assets/sfx/gameplay/Soufflerie_idle.mp3")] 		public var SfxIdle:Class;
		//[Embed(source = "../assets/sfx/gameplay/Soufflerie_in.mp3")] 		public var SfxIn:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Soufflerie_In.wav')] public var SfxIn:Class;
		
		public var soundIdle:FlxSound 	= new FlxSound();
		public var soundIn:FlxSound 	= new FlxSound();
		public var gravityup:int 		= 1000;				// Puissance du souffle en Y
		public var speedSouffle:int 	= 1000;				// Puissance du souffle en X
		public var speedBasSouffle:int 	= 1000;			// Puissance du souffle en -X
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
			
			soundIdle.loadEmbedded(SfxIn, false, true);
			soundIn.loadEmbedded(SfxIn, false, true);
			
			immovable = true;
			angle = orient;
			
			/*if ((angle == 90) || (angle == -90))
				x += frameWidth / 2;*/
				
			this.loadGraphic(ImgSoufflerie, true, false, 80, 40);
			this.addAnimation("default", [0, 1, 2, 3], 12, true);
			this.play("default");
				
			
			souffle = new FlxSprite(xpos, ypos, ImgSouffle);
			souffle.loadGraphic(ImgSouffle, true, false, 80, 200);
			souffle.addAnimation("default", [0, 1, 2, 3], 12, true);
			souffle.y -= souffle.frameHeight;
			souffle.play("default");
			souffle.angle = orient;
			switch (orient) {
				//BAS
				case 180:
					souffle.y += souffle.frameHeight;
					break;
				// DROITE
				case 90:
					width = frameHeight;
					height = frameWidth;
					offset.x = frameHeight /2;
					offset.y = - frameHeight / 2;
					souffle.x += frameHeight;
					souffle.width = souffle.frameHeight;
					souffle.y += souffle.frameWidth + frameHeight + frameWidth;
					souffle.height = souffle.frameWidth;
					souffle.offset.x = -souffle.frameWidth * 3 / 4;
					souffle.offset.y = souffle.frameWidth * 3 / 4;
					break;
				// GAUCHE
				case -90:
					width = frameHeight;
					height = frameWidth;
					offset.x = frameHeight /2;
					offset.y = - frameHeight /2;
					souffle.x -= souffle.frameWidth + frameWidth + frameHeight;
					souffle.width = souffle.frameHeight;
					souffle.y += souffle.frameWidth + frameHeight + frameWidth;
					souffle.height = souffle.frameWidth;
					souffle.offset.x = -souffle.frameWidth * 3 / 4;
					souffle.offset.y = souffle.frameWidth * 3 / 4;
					break;
			}
			FlxG.state.add(souffle);
			soundIdle.volume = 0.6;
		}
	
		override public function update():void {
			
			if (!onScreen(FlxG.camera))
			{
				soundIdle.stop();
			}
			
			if ((FlxG.player != null) && (onScreen(FlxG.camera)) && (!FlxG.overlap(souffle, FlxG.map.destructible, stopsouffle)))
			{
				souffle.visible = true;
				// HAUT
				if (FlxG.overlap(FlxG.player, souffle) && angle == 0 ) 
				{
					FlxG.player.souffled = true;
					soundIn.play();
					FlxG.player.velocity.y -= speedSouffle * FlxG.elapsed;
				}
				// DROITE
				else if (angle == 90 && !FlxG.overlap(FlxG.player, souffle, boost_player)) 
				{
					FlxG.player.souffled = true;
					FlxG.player.maxVelocity.x = FlxG.player.init_speed;
				}
				//BAS
				else if (FlxG.overlap(FlxG.player, souffle) && angle == 180 ) 
				{
					FlxG.player.souffled = true;
					soundIn.play();
					FlxG.player.velocity.y += speedBasSouffle * FlxG.elapsed;
				}
				
				else if (FlxG.overlap(FlxG.player, souffle) && angle == -90 )
				{
					if ( FlxG.player.velocity.x > FlxG.player.minspeed - speedSouffle * FlxG.elapsed)
					{
						FlxG.player.souffled = true;
						soundIn.play();
						FlxG.player.velocity.x -= speedSouffle * FlxG.elapsed;
					}
				}
				else {
					soundIn.stop();
				}
			}
			if (!FlxG.overlap(FlxG.player, souffle))
				soundIn.stop();
		}
		public function boost_player(obj1:FlxSprite, obj2:FlxObject):void 
		{
			FlxG.player.maxVelocity.x = 500;
			FlxG.player.velocity.x += gravityup * FlxG.elapsed;
			soundIn.play();
		}
		
		public function stopsouffle(obj1:FlxSprite, obj2:FlxObject):void 
		{
			souffle.visible = false;
		}
	}

}