package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.FlxObject;
	
	/**
	 * Soufflerie
	 * @author ...
	 */
	public class Soufflerie extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/soufflerie.png')] protected var ImgSoufflerie:Class;
		[Embed(source = '../assets/gfx/gameplay/souffle.png')] protected var ImgSouffle:Class;
		[Embed(source = "../assets/sfx/gameplay/Soufflerie_idle.mp3")] 		public var SfxIdle:Class;
		[Embed(source = "../assets/sfx/gameplay/Soufflerie_in.mp3")] 		public var SfxIn:Class;
		
		public var soundIdle:FlxSound 		= new FlxSound();
		public var soundIn:FlxSound 		= new FlxSound();
		public var gravityup:int = 250;								// GRAVITY MODIFIER
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
			souffle = new FlxSprite(xpos, ypos, ImgSouffle);
			souffle.y -= souffle.frameHeight;
			FlxG.state.add(souffle);
		}
	
		override public function update():void {
			
			if (onScreen(FlxG.camera))
			{
				soundIdle.play();
			}
			if (FlxG.player != null)
				if (!FlxG.overlap(FlxG.player, souffle, getup) && (applied == true)) 
				{
					applied = false;
				}
				
				/* TODO 
				 * Gerer les différents angles de soufflerie
				 */
		}
		
		public function getup(obj1:FlxObject, obj2:FlxObject):void {
			// HORIZONTAUX _
			if (applied == false) {
				soundIn.play();
				FlxG.player.velocity.y = -gravityup;
				/* TODO 
				 * Gravityup en fonction de la position du joueur comparé à la soufflerie
				 */
				applied = true;
			}
		}
	}

}