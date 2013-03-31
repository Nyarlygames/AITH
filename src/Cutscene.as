package
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import flash.display.MovieClip;
	import flash.media.SoundMixer;
	import flash.events.Event;
	
	/**
	 * 
	 * @author
	 */
	public class Cutscene extends FlxState
	{		
		[Embed(source = '../assets/gfx/gameplay/ascenceur_down.png')] 		protected var ImgAscenceurDown:Class;
		
		override public function create():void
		{
		}
		
		private function next(e:Event):void
		{
			frameLength--;
			if (frameLength <= 0)
			{
				movie.removeEventListener(Event.EXIT_FRAME, next);
				SoundMixer.stopAll();
				FlxG.stage.removeChild(movie);
				//Enter the next FlxState to switch to
				FlxG.switchState(new Menu());
			}			
		}
		
		override public function update():void {
			if (FlxG.keys.justReleased("ENTER") || FlxG.keys.justReleased("SPACE") || FlxG.keys.justReleased("ESCAPE")) {
					
			}
		}
	} 
}