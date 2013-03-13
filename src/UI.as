package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * User interface
	 * @author ...
	 */
	public class UI extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/gameplay/petit_tube.png')] protected var ImgTube:Class;
		[Embed(source = '../assets/fonts/Urban_slick.ttf',	fontFamily = "slick", embedAsCFF = "false")] protected var	Font:Class;
		public var tube_count:FlxText;
		
		public function UI() 
		{
			super(0, 0, ImgTube);
			scrollFactor = new FlxPoint(0, 0);
			tube_count = new FlxText(frameWidth, 200, 200, "0");
			tube_count.setFormat("onedalism", 22, 0x044071);
			FlxG.state.add(tube_count);
			tube_count.scrollFactor = new FlxPoint(0, 0);
		}
		
		override public function update():void {
		//	if ((tube_count != null) && (tube_count.text != null))
		//		tube_count.text = ""+FlxG.score;
		}
		
	}

}