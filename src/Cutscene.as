package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import flash.display.MovieClip;
	import flash.media.SoundMixer;
	import flash.events.Event;
	import org.flixel.FlxTimer;
	
	/**
	 * 
	 * @author
	 */
	public class Cutscene extends FlxState
	{		
		[Embed(source = '../assets/gfx/cine/1.png')] 		protected var ImgIntro1:Class;
		[Embed(source = '../assets/gfx/cine/2.png')] 		protected var ImgIntro2:Class;
		[Embed(source = '../assets/gfx/cine/3.png')] 		protected var ImgIntro3:Class;
		[Embed(source = '../assets/gfx/cine/4.png')] 		protected var ImgIntro4:Class;
		[Embed(source = '../assets/gfx/cine/5.png')] 		protected var ImgIntro5:Class;
		[Embed(source = '../assets/gfx/cine/6.png')] 		protected var ImgIntro6:Class;

		public var intro1:FlxSprite;
		public var intro2:FlxSprite;
		public var intro3:FlxSprite;
		public var intro4:FlxSprite;
		public var intro5:FlxSprite;
		public var intro6:FlxSprite;
		public var currentframe:int = 1;
		public var timer:FlxTimer = new FlxTimer();
		
		override public function create():void
		{
			intro1 = new FlxSprite(0, 0, ImgIntro1);
			intro2 = new FlxSprite(0, 0, ImgIntro2);
			intro3 = new FlxSprite(0, 0, ImgIntro3);
			intro4 = new FlxSprite(0, 0, ImgIntro4);
			intro5 = new FlxSprite(0, 0, ImgIntro5);
			intro6 = new FlxSprite(0, 0, ImgIntro6);
			timer.start(3, 0, switch_page);
			
			FlxG.state.add(intro6);
			FlxG.state.add(intro5);
			FlxG.state.add(intro4);
			FlxG.state.add(intro3);
			FlxG.state.add(intro2);
			FlxG.state.add(intro1);
			trace(currentframe);
		}
		
		override public function update():void {
			if (FlxG.keys.justReleased("ENTER") || FlxG.keys.justReleased("SPACE") || FlxG.keys.justReleased("ESCAPE") || FlxG.mouse.justPressed()) {
				switch_page(timer);
			}
		}
		
		public function switch_page(timer:FlxTimer):void {
			timer.stop();
			timer.start(3, 0, switch_page);
				switch (currentframe) {
					case 1:
						remove(intro1);
						break;
					case 2:
						remove(intro2);
						break;
					case 3:
						remove(intro3);
						break;
					case 4:
						remove(intro4);
						break;
					case 5:
						remove(intro5);
						break;
					case 6:
						FlxG.switchState(new UnivChooser);
						break;
				}
				currentframe++;
		}
		
	} 
}