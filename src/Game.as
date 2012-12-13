package  
{
	import org.flixel.FlxState;
	/**
	 * Conserve tout le jeu
	 * @author ...
	 */
	public class Game extends FlxState 
	{
		public var keyboard:KeyEvent;
		public var state:int = 1;
		public var onstate:Boolean = true;
		public var map:Map;
		public var play:Play;
		[Embed(source = "../maps/map01.txt", mimeType = "application/octet-stream")] public var mapfile:Class;
		
		public function Game() 
		{
			super.update();
			map = new Map(mapfile);
			play = new Play(map);
			keyboard = new KeyEvent(play);
			add(keyboard);
			add(play);
		}
		
		override public function update():void {
			super.update();
			if ((state == 1) && (onstate == false)) {
				// Deuxieme état
				state = 2;
				onstate = true;
			}
		}
	}

}