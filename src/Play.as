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
			add(background.sol);
			player = new Player(200,FlxG.height - (FlxG.height - background.sol.y) - background.sol.frameHeight);
			add(new TubeVert(500,FlxG.height - (FlxG.height - background.sol.y) - background.sol.frameHeight/2));
			add(new Alien(600,FlxG.height - (FlxG.height - background.sol.y) - background.sol.frameHeight/2));
			add(player.roues);
			add(player);
		}
		
		override public function update():void {
			super.update();
			FlxG.collide(player.roues, background.sol);
			FlxG.collide(player, player.roues);
		}
				
	}

}