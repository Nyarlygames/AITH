package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	
	/**
	 * Soucoupe
	 * @author ...
	 */
	public class Soucoupe extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/soucoupe.png')] protected var ImgSoucoupe:Class;
		public var gravity:int = 100;								// GRAVITY MODIFIER
		public var applied:Boolean = false;
		public var boost:int = 200;
		
		public function Soucoupe(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgSoucoupe);
			immovable = true;
		}
	
		override public function update():void {
			
			// HORIZONTAUX _
			if (onScreen(FlxG.camera)) {
				if ((FlxG.player.x + FlxG.player.frameWidth >= x) && (FlxG.player.x < x + frameWidth) && (applied == false)) {
					FlxG.player.gravity = gravity - FlxG.player.y;
					applied = true;
				}
				else if ((FlxG.player.x > x + frameWidth) && (applied == true)) {
					FlxG.player.gravity = gravity + FlxG.player.y;
					applied = false;
				}
			}
		}
	}

}