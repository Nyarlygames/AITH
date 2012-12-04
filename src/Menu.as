package
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import flash.system.System;
	 
	/**
	 * Menu
	 * @author 
	 */
	public class Menu extends FlxState
	{
		
		override public function create():void
		{
			
			FlxG.bgColor = 0xaa519CCA;
			var title:FlxText = new FlxText(FlxG.width / 2 - 100, FlxG.height / 2 - 200, 200, "Aliens In The Hood");
			title.setFormat(null, 16, 0x044071);
			add(title);
			var notice:FlxText = new FlxText(FlxG.width / 2 - 200, FlxG.height / 2, 500, "Appuyez sur ESCPACE pour commencer.");
			notice.setFormat(null, 16, 0x044071);
			add(notice);
		}
		
		/**
		 * Update the state
		 */
		override public function update():void
		{
			super.update();
			
			// Démarre le jeu
			if (FlxG.keys.pressed("SPACE")) {
				FlxG.switchState(new Game());
			}
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
		}
	}
}
