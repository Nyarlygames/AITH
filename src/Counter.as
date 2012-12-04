package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	/**
	 * Compteur du temps
	 * @author ...
	 */
	public class Counter extends FlxSprite
	{
		 [Embed(source = '../assets/gfx/chronobar.png')] public var ImgCounter:Class;
		 public var delay:FlxDelay = new FlxDelay(10000);
		 public var count:int = 0;
		 public var timer:FlxText;
		
		public function Counter()
		{
			super(FlxG.width/2, 0, ImgCounter);
			x -= frameWidth;
			delay.start();
			timer = new FlxText(FlxG.width / 2, 0, 30, delay.secondsRemaining.toString());
			timer.x -= this.frameWidth / 2 + timer.frameWidth / 2;
			timer.y += this.frameHeight / 2 - timer.frameHeight /2;
			timer.setFormat(null, 16, 0x044071);
		}
		
		override public function update():void {
			timer.text = delay.secondsRemaining.toString();
		}
		
	}

}