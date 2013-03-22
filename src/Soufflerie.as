package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	
	/**
	 * Soufflerie
	 * @author ...
	 */
	public class Soufflerie extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/soufflerie.png')] protected var ImgSoufflerie:Class;
		[Embed(source = "../assets/sfx/gameplay/Soufflerie_idle.mp3")] 		public var SfxIdle:Class;
		[Embed(source = "../assets/sfx/gameplay/Soufflerie_in.mp3")] 		public var SfxIn:Class;
		
		public var soundIdle:FlxSound 		= new FlxSound();
		public var soundIn:FlxSound 		= new FlxSound();
		
		public var gravity:int = 100;								// GRAVITY MODIFIER
		public var applied:Boolean = false;
		public var boost:int = 200;
		
		public function Soufflerie(xpos:int, ypos:int, orient:int) 
		{
			super(xpos, ypos, ImgSoufflerie);
			soundIdle.loadEmbedded(SfxIn);
			soundIn.loadEmbedded(SfxIn);
			immovable = true;
			angle = orient;
			if ((angle == 90) || (angle == -90))
				x += frameWidth / 2;
		}
	
		override public function update():void {
			
			if (onScreen(FlxG.camera))
			{
				soundIdle.play();
			}
			
			// HORIZONTAUX _
			if (onScreen(FlxG.camera) && (angle == 90) || (angle == -90)) {
				// ENTRE DANS L'ATTRACTION
				if ((FlxG.player.x + FlxG.player.frameWidth >= x) && (FlxG.player.x < x + frameWidth) && (applied == false)) {
					soundIn.play();
					FlxG.player.gravity = gravity  - FlxG.player.y;
					applied = true;
					if (angle == -90)
						FlxG.player.gravity = -FlxG.player.gravity;
				}
				// SORT DE L'ATTRACTION
				else if ((FlxG.player.x > x + frameWidth) && (applied == true)) {
					FlxG.player.gravity = gravity + FlxG.player.y;
					applied = false;
				}
			}
			// VERTICAUX |
			else {
				// BOOST ==>
				if ((angle == 0) && ((FlxG.player.y + FlxG.player.frameHeight >= y) && (FlxG.player.y <= y + frameHeight) && (onScreen(FlxG.camera)) && (FlxG.player.x >= x))
					&& (applied == false)) {
					FlxG.player.maxVelocity.x += boost;
					FlxG.player.velocity.x += boost;
				}
				// FAIRE <==
			}
		}
	}

}