package  
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
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
		
		[Embed(source = '../assets/gfx/fly.png')] protected var ImgPlayer:Class;
		public var gauche:Gauche;
		public var droite:Droite;
		public var posY:int = 0;
		
		public function Player(xPos:int, yPos:int, left:Gauche, right:Droite) 
		{
			gauche = left;
			droite = right;
			super(xPos, yPos, ImgPlayer);
			y -= frameHeight;
		}
		
		override public function update():void {
			angle = FlxVelocity.angleBetween(this, gauche);
			stickToLand();
		}
		
		public function stickToLand():void {
			var remonte:FlxPoint = new FlxPoint(0,0);
			if (FlxCollision.pixelPerfectCheck(this, gauche) == true) {
				velocity.x = 0;
				velocity.y = -100;
			}
			else {
				FlxVelocity.moveTowardsObject(this, gauche, 300);
				velocity.x = 0;
			}
		}
		
	}

}