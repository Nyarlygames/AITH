package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	/**
	 * EndGame
	 * @author ...
	 */
	public class EndGame extends FlxState 
	{
		
		public function EndGame() 
		{
			trace("OLOLZ FIN", FlxG.usersave.scoreStars);
		}
	
		override public function update():void {
		}
	}

}