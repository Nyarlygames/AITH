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
		[Embed(source = '../assets/gfx/roue.png')] protected var ImgRoue:Class;
		public var roues:FlxGroup = new FlxGroup;
		public var roue:FlxSprite;
		
		public function Player(xPos:int, yPos:int) 
		{
			super(xPos, yPos, ImgPlayer);
			y -= frameHeight
			roues.add(roue = new FlxSprite(this.x, this.y + frameHeight, ImgRoue)); 
			roue.x += roue.frameWidth/2;
			roue.y -= roue.frameHeight/2;
			roues.add(roue = new FlxSprite(this.x + frameWidth, this.y + frameHeight, ImgRoue)); 
			roue.x -= roue.frameWidth + 5;
			roue.y -= roue.frameHeight/2;
			
		}
		
		override public function update():void 
		{
			for each (var roue:FlxSprite in roues.members) {
				roue.angle += 10;
			}
		}
		
		
	}

}