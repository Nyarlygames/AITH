package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	import org.flixel.FlxEmitter;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	
	/**
	 * Soufflerie
	 * @author ...
	 */
	public class FinNiveau extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/souffle.png')] protected var ImgFinNiveau:Class;
		
		public function FinNiveau(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgFinNiveau);
		}
	
		override public function update():void 
		{
			
			
				 
		}
	}
}
