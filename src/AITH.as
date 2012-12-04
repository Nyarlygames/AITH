package  
{
	import org.flixel.FlxGame;

	[SWF(width = "800", height = "600", backgroundColor = "#000000")]
	 [Frame(factoryClass="Preloader")]
	
	/**
	 * Starting point of the game application
	 * @author 
	 */
	public class AITH extends FlxGame
	{
		public function AITH()
		{
			//Function to call to create the game at a specified screen size and display the first state (MenuState)
			super(800, 600, Menu);
		}
		
	}

}