package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxObject;
	
	/**
	 * Camera
	 * @author ...
	 */
	public class Cam extends FlxObject 
	{
		

		public var speed:int = 20;
		public var player:Player;
		
		public function Cam(joueur:Player) 
		{
			super(0, 500);
			player = joueur;
		}
		
		override public function update():void 
		{
			// CAM SUIT LE JOUEUR
			x = player.x + 350;
		}
		
		
	}

}