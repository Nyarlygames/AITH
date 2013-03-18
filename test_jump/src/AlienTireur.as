package  
{
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.FlxG;
	
	/**
	 * Alien tireur
	 * @author ...
	 */
	public class AlienTireur extends Alien
	{
		[Embed(source = '../assets/gfx/gameplay/alien_tireur.png')] protected var ImgAlienTir:Class;
		[Embed(source = '../assets/gfx/gameplay/tir.png')] public var ImgShoot:Class;
		public var rate:int = 1500;							// CADENCE DE TIR
		public var maxtir:int = 200;						// MAXIMUM DE TIR
		public var speed:int = 300;							// VITESSE DE TIR
		public var gravity:int = 1000;						// GRAVITE DE TIR
		public var shoot:FlxWeapon;
		
		public function AlienTireur(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAlienTir);
			shoot = new FlxWeapon("shoot", this, "x", "y");
			shoot.makeImageBullet(maxtir, ImgShoot, frameWidth/2, frameHeight/2);
			shoot.setFireRate(rate);
			shoot.setBulletSpeed(speed);
			shoot.setBulletBounds(new FlxRect(x - 800, y, x, y + 600));
			shoot.setBulletGravity(0, gravity);
			FlxG.state.add(shoot.group);
		}
		
		override public function update():void {
			if (onScreen(FlxG.camera)) {
				shoot.fireFromAngle(FlxWeapon.BULLET_LEFT);
			}
		}
	}
}