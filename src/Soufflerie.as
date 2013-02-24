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
		public var gravity:int = 100;
		public var applied:Boolean = false;
		public var boost:int = 200;
		
		public function Soufflerie(xpos:int, ypos:int, orient:int) 
		{
			super(xpos, ypos, ImgSoufflerie);
			immovable = true;
			angle = orient;
			if ((angle == 90) || (angle == -90))
				x += frameWidth / 2;
		}
	
		override public function update():void {
			
			// HORIZONTAUX _
			if (onScreen(FlxG.camera) && (angle == 90) || (angle == -90)) {
				if ((FlxG.player.x + FlxG.player.frameWidth >= x) && (FlxG.player.x < x + frameWidth) && (applied == false)) {
					FlxG.player.gravity = gravity  - FlxG.player.y;
					applied = true;
					if (angle == -90)
						FlxG.player.gravity = -FlxG.player.gravity;
				}
				else if ((FlxG.player.x > x + frameWidth) && (applied == true)) {
					FlxG.player.gravity = gravity + FlxG.player.y;
					applied = false;
				}
			}
			// VERTICAUX |
			else {
				if ((angle == 0) && ((FlxG.player.y + FlxG.player.frameHeight >= y) && (FlxG.player.y <= y + frameHeight) && (onScreen(FlxG.camera)) && (FlxG.player.x >= x))
					&& (applied == false)) {
					FlxG.player.maxVelocity.x += boost;
					FlxG.player.velocity.x += boost;
				}
				/*if ((FlxG.player.x + FlxG.player.frameWidth >= x) && (FlxG.player.x < x + frameWidth) && (applied == false)) {
					FlxG.player.gravity = gravity  - FlxG.player.y;
					applied = true;
				}
				else if ((FlxG.player.x > x + frameWidth) && (applied == true)) {
					FlxG.player.gravity = gravity + FlxG.player.y;;
					applied = false;
				}*/
			}
		}
	}

}