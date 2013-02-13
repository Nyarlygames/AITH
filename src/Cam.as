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
			super(0, 300);
			player = joueur;
		}
		
		override public function update():void 
		{
			// CAM SUIT LE JOUEUR
			x = player.x + 350;
			
			// DEPASSEMENT VERTICAL
			if (player.y - player.frameHeight/2 <= 300)
				y = player.y + 290;
			else y = 300;
		}
		
		
	}

}