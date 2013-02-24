package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	
	/**
	 * Soufflerie
	 * @author ...
	 */
	public class Soufflerie extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/soufflerie.png')] protected var ImgSoufflerie:Class;
		public var gravity:int = 500;
		public var applied:Boolean = false;
		
		public function Soufflerie(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgSoufflerie);
			y -= frameHeight;
			immovable = true;
		}
	
		override public function update():void {
			if ((FlxG.player.x + FlxG.player.frameWidth >= x) && (FlxG.player.x < x + frameWidth) && (applied == false)) {
				trace("b : ", FlxG.player.gravity, FlxVelocity.distanceBetween(FlxG.player, this));
				FlxG.player.gravity = gravity  - FlxVelocity.distanceBetween(FlxG.player, this);
				applied = true;
				trace("a : ", FlxG.player.gravity);
			}
			else if ((FlxG.player.x > x + frameWidth) && (applied == true)) {
				trace("b2 : ", FlxG.player.gravity, FlxVelocity.distanceBetween(FlxG.player, this));
				FlxG.player.gravity = gravity - FlxVelocity.distanceBetween(FlxG.player, this);
				applied = false;
				trace("a2 : ", FlxG.player.gravity);
			}
		}
	}

}