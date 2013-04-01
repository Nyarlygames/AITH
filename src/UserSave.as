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
		public var starsNeed:int	 =  4;  // Number of stars needed for universe 2
		public var maxStars:int	 	 =  18;  // Maximum of stars avaliable
		public var level1:Array = new Array(0, 0, 0);
		public var level2:Array = new Array(0, 0, 0);
		public var level3:Array = new Array(0, 0, 0);
		public var level4:Array = new Array(0, 0, 0);
		public var level5:Array = new Array(0, 0, 0);
		public var level6:Array = new Array(0, 0, 0);
		public var scoreuniv1:int = 0;
		public var scoreuniv2:int = 0;
		public var score1:int = 0;
		public var score2:int = 0;
		public var score3:int = 0;
		public var score4:int = 0;
		public var score5:int = 0;
		public var score6:int = 0;
		
		public function UserSave() 
		{
		}
		
		
		public function calcStars_levels():void
		{
			score1 = level1[0] + level1[1] + level1[2];
			score2 = level2[0] + level2[1] + level2[2];
			score3 = level3[0] + level3[1] + level3[2];
			score4 = level4[0] + level4[1] + level4[2];
			score5 = level5[0] + level5[1] + level5[2];
			score6 = level6[0] + level6[1] + level6[2];
		}
		
		public function calcStars_univ():void
		{
			scoreuniv1 = level1[0] + level1[1] + level1[2] + level2[0] + level2[1] + level2[2] + level3[0] + level3[1] + level3[2];
			scoreuniv2 = level4[0] + level4[1] + level4[2] + level5[0] + level5[1] + level5[2] + level6[0] + level6[1] + level6[2];
		}
		
		public function calcStars():void
		{
			scoreStars = level1[0] + level1[1] + level1[2] + level2[0] + level2[1] + level2[2] + level3[0] + level3[1] + level3[2]
						+ level4[0] + level4[1] + level4[2] + level5[0] + level5[1] + level5[2] + level6[0] + level6[1] + level6[2];
			
			if (scoreStars >= starsNeed)
				univUnlock = true;
		}
	}
}