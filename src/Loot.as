package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	import org.flixel.FlxG;
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic
	import org.flixel.FlxPoint;
	
	/**
	 * Loot tube vert
	 * @author ...
	 */
	public class Loot extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/gameplay/petit_tube.png')] protected var ImgTube:Class;
		[Embed(source = '../assets/gfx/gameplay/gros_tube.png')] protected var ImgGrosTube:Class;
		[Embed(source = '../assets/fonts/phillysansps.otf',	fontFamily = "philly", embedAsCFF = "false")] protected var	Font:Class;
		public var loot:int = 0;
		public var up:int = 0;
		public var timer:FlxTimer = new FlxTimer();
		public var player:Player;
		
		public function Loot(joueur:Player, value:int) 
		{
			player = joueur;
			super(50, player.y - 200);
			y -= frameHeight;
			loot = value;
			player.checkscore += loot;
			if (loot == 5)
				loadGraphic(ImgGrosTube);
			else
				loadGraphic(ImgTube);
			scrollFactor = new FlxPoint(0, 0);
			TweenMax.to(this, 2, { x: 20 ,alpha : 0, y : 10 , ease:Elastic.easeOut, onComplete : kill }  );
		}
		
		override public function update():void 
		{
		}
	}

}