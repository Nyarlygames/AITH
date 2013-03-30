package  
{
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Tav
	 */
	public class UserSave 
	{
		public var univUnlock:Boolean = false//  Is Univ2 Unlock ?
		public var scoreStars:int	 =  0;  // Actual score of star
		public static var starsNeed:int	 	 =  4;  // Number of stars needed for universe 2
		public var maxStars:int	 	 =  18;  // Maximum of stars avaliable
		public var level1:Array = new Array(0, 0, 0);
		public var level2:Array = new Array(0, 0, 0);
		public var level3:Array = new Array(0, 0, 0);
		public var level4:Array = new Array(0, 0, 0);
		public var level5:Array = new Array(0, 0, 0);
		public var level6:Array = new Array(0, 0, 0);
		
		public function UserSave() 
		{
		}
		
		public function calcStars():void
		{
			scoreStars = level1[0] + level1[1] + level1[2] + level2[0] + level2[1] + level2[2] + level3[0] + level3[1] + level3[2];
			
			if (scoreStars >= starsNeed)
				univUnlock = true;
		}
	}
}