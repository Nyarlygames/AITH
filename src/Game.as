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
		public var play:Play;/* = new Play();*/
		
		public function Game() 
		{
			super.update();
			/*keyboard = new KeyEvent(play);
			add(keyboard);
			add(play);*/
		}
		
	}

}