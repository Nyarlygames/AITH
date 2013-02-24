package  
{
	import org.flixel.FlxObject;
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
		[Embed(source = '../assets/gfx/halo.png')] protected var ImgHalo:Class;
		public var gravity:int = 100;								// GRAVITY MODIFIER
		public var applied:Boolean = false;
		public var halo:FlxSprite;
		
		
		public function Soucoupe(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgSoucoupe);
			halo = new FlxSprite(xpos, ypos + frameHeight, ImgHalo);
			FlxG.state.add(halo);
			immovable = true;
		}
	
		override public function update():void {
			if (FlxG.player != null)
				if (!FlxG.overlap(FlxG.player, halo, getup) && (applied == true)) {
					FlxG.player.gravity = gravity + FlxG.player.y;
					applied = false;
				}

		}
		
		public function getup(obj1:FlxObject, obj2:FlxObject):void {
			// HORIZONTAUX _
			if (applied == false) {
				FlxG.player.gravity = gravity - FlxG.player.y;
				applied = true;
			}
		}
	}

}