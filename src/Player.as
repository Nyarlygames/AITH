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
		
		[Embed(source = '../assets/gfx/player2.png')] protected var ImgPlayer:Class;
		[Embed(source = '../assets/gfx/roue.png')] protected var ImgRoue:Class;
		[Embed(source = '../assets/gfx/vit.png')] protected var ImgV:Class;
		[Embed(source = '../assets/gfx/grav.png')] protected var ImgG:Class;
		public var roues:FlxGroup = new FlxGroup;
		public var roue:FlxSprite;
		public var g:FlxSprite;
		public var v:FlxSprite;
		public var speed:int = 20;
		public var gravity:int = 5000;
		
		public function Player(xPos:int, yPos:int) 
		{
			super(xPos, yPos, ImgPlayer);
			y -= frameHeight;			
			drag.x = 600;
			maxVelocity.x = 100;
			acceleration.x = speed;
			acceleration.y = 400;
			maxVelocity.y = 400;
			drag.y = 600;
			facing = RIGHT;
			width = 60;
			height = 80;
			
			
			g = new FlxSprite(0, 0, ImgG);
			g.scrollFactor.x = g.scrollFactor.y = 0;
			v = new FlxSprite(0, 20, ImgV);
			v.scrollFactor.x = v.scrollFactor.y = 0;

			
			roues.add(roue = new FlxSprite(this.x, this.y + frameHeight, ImgRoue)); 
			roue.x += roue.frameWidth-15;
			roue.y -= roue.frameHeight -5;
			roue.drag.x = 600;
			roue.maxVelocity.x = 100;
			roue.acceleration.x = speed;
			roue.acceleration.y = 400;
			roue.maxVelocity.y = 400;
			roue.drag.y = 600;
			roue.facing = RIGHT;			
			
			roues.add(roue = new FlxSprite(this.x + frameWidth, this.y + frameHeight, ImgRoue)); 
			roue.x -= roue.frameWidth + 5;
			roue.y -= roue.frameHeight -5;
			roue.drag.x = 600;
			roue.maxVelocity.x = 100;
			roue.acceleration.x = speed;
			roue.acceleration.y = 400;
			roue.maxVelocity.y = 400;
			roue.drag.y = 600;
			roue.facing = RIGHT;			
		}
		
		override public function update():void 
		{
			
			for each (var wheel:FlxSprite in roues.members) {
				wheel.angle += 10;
				wheel.acceleration.x = 0;
				wheel.acceleration.x += wheel.drag.x;	
			}
			acceleration.x = 0;
			acceleration.x += drag.x;
			
			if (angle >= -45 && angle < 0) {
				angularVelocity = 10;
			}
		}
		
		
	}

}