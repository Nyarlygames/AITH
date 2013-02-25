package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * Checkpoints
	 * @author ...
	 */
	public class Checkpoints extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/checkpoint.png')] protected var ImgCheck:Class;
		[Embed(source = '../assets/gfx/gameplay/checkpoint_validated.png')] protected var ImgCheckValid:Class;
		public var validated:Boolean = false;
		
		public function Checkpoints(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgCheck);
			y -= frameHeight;
			immovable = true;
		}
		
		override public function update():void {
			if ((FlxG.player != null) && (FlxG.player.x >= x) && (validated == false)) {
				FlxG.player.checkpoint.x = x;
				FlxG.player.checkpoint.y = y;
				loadGraphic(ImgCheckValid);
				validated = true;
			}
		}
	}

}