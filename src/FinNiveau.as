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
		[Embed(source = '../assets/gfx/gameplay/End_aliensship.png')] protected var ImgFinNiveau2:Class;
		[Embed(source = '../assets/gfx/gameplay/End_Hood.png')] protected var ImgFinNiveau:Class;
		[Embed(source = '../assets/gfx/gameplay/End_1_3.png')] protected var ImgFinNiveau3:Class;
		
		public function FinNiveau(xpos:int, ypos:int) 
		{
			super(xpos, ypos);
			if (FlxG.univ == 1)
				if (FlxG.level == 3)
					loadGraphic(ImgFinNiveau3);
				else
					loadGraphic(ImgFinNiveau);
			else
				loadGraphic(ImgFinNiveau2);
		}
	
		override public function update():void 
		{
			
			
				 
		}
	}
}
