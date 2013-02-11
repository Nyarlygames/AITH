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
			super(400, 400);
			player = joueur;
		}
		
		override public function update():void 
		{
			x = player.x + 350;
			if (player.y <= 400) y = player.y - player.frameHeight;
			else y = 400;
		}
		
		
	}

}