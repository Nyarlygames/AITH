package  
{
	import flash.utils.Timer;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.FlxPoint;
	import org.flixel.plugin.photonstorm.FlxControl;
	import org.flixel.plugin.photonstorm.FlxControlHandler;
	import org.flixel.FlxObject;
	import org.flixel.plugin.photonstorm.FlxScrollZone;
	
	/**
	 * Niveau
	 * @author ...
	 */
	public class Play extends FlxState 
	{
		
		public var player:Player;
		public var background:Background = new Background();
		
		public function Play() 
		{	 
			if (FlxG.getPlugin(FlxScrollZone) == null)
			{
				FlxG.addPlugin(new FlxScrollZone);
			}
			super.update();
			add(background);
			player = new Player(200,FlxG.height - background.frameHeight);
			add(player);
		}
		
		override public function update():void {
			super.update();
			FlxG.collide(player, background);
		}
				
	}

}