package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	/**
	 * Joueur
	 * @author ...
	 */
	public class Player extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/player.png')] protected var ImgPlayer:Class;
		[Embed(source = '../assets/gfx/vit.png')] protected var ImgV:Class;
		[Embed(source = '../assets/gfx/grav.png')] protected var ImgG:Class;
		public var g:FlxSprite;
		public var v:FlxSprite;
		public var speedup:int = 50;
		public var speeddown:int = 25;
		public var maxspeed:int = 200;
		public var minspeed:int = 60;
		public var mingravity:int = 0;
		public var maxgravity:int = 5000;
		public var gravityup:int = 1200;
		public var gravitydown:int = 1200;
		
		public function Player(xPos:int, yPos:int) 
		{
			super(xPos, yPos, ImgPlayer);
			y -= frameHeight;			
			drag.x = 600;
			drag.y = 600;
			maxVelocity.x = maxspeed;
			acceleration.y = 24;
			maxVelocity.y = maxgravity;
			facing = RIGHT;
			width = 60;
			height = 80;
			
			g = new FlxSprite(0, 0, ImgG);
			g.scrollFactor.x = g.scrollFactor.y = 0;
			g.scale.x = 0.1;
			v = new FlxSprite(0, 20, ImgV);
			v.scrollFactor.x = v.scrollFactor.y = 0;
		}
		
		override public function update():void 
		{
			acceleration.x += drag.x;
			
			if (angle >= -45 && angle < 0) {
				angularVelocity = 10;
			}
			
			if (FlxG.keys.pressed("UP")) {
				
				if (acceleration.y < maxgravity) {
					velocity.x -= speeddown * FlxG.elapsed;
					acceleration.y += gravityup * FlxG.elapsed;
					g.scale.x += FlxG.elapsed;
					v.scale.x -= FlxG.elapsed;
				}
				
				
				/*if ((g.scale.x <= 1) && (v.scale.x >= 0)) {
					g.scale.x += FlxG.elapsed;
					v.scale.x -= FlxG.elapsed;
					acceleration.x -= speeddown * FlxG.elapsed;
					acceleration.y += gravityup * FlxG.elapsed;
				}*/
			}
			else if ((g.scale.x >= 0 ) && (v.scale.x <= 1)) {
				trace(velocity.y);
				g.scale.x -= FlxG.elapsed;
				v.scale.x += FlxG.elapsed;
				velocity.x += speedup * FlxG.elapsed;
				acceleration.y -= gravitydown * FlxG.elapsed;
				
			}
		}
		
		
	}

}