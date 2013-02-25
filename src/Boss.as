package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.FlxRect;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Boss extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/gameplay/boss_exterieur.png')] protected var ImgBoss:Class;
		[Embed(source = '../assets/gfx/gameplay/tir_boss.png')] public var ImgShoot:Class;
		public var rate:int = 20;							// CADENCE DE TIR
		public var maxtir:int = 500;						// MAXIMUM DE TIR
		public var speed:int = 20;							// VITESSE DE TIR
		public var shoot:FlxWeapon;
		public var pv:FlxBar;								// BARRE DE PV DU BOSS
		
		public function Boss(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgBoss);
			elasticity = 1;
			immovable = true;
			health = 100;
			pv = new FlxBar(0 , 00, FlxBar.FILL_LEFT_TO_RIGHT, 800, 20, this, "health");
			pv.scrollFactor = new FlxPoint(0, 0);
			shoot = new FlxWeapon("shoot", this, "x", "y");
			shoot.makeImageBullet(maxtir, ImgShoot, -50, frameHeight/2);
			shoot.setFireRate(rate);
			shoot.setBulletSpeed(speed);
		//	shoot.setBulletBounds(new FlxRect(x -600, y-600, x+frameWidth, y + 600));
			shoot.setBulletBounds(new FlxRect(x - 800, y, x, y + 600));
			FlxG.state.add(shoot.group);
			FlxG.state.add(this);
			FlxG.state.add(pv);
		}
		
		override public function update():void {
			shoot.fireFromAngle(FlxWeapon.BULLET_LEFT);

			// TOUCHE JOUEUR
			/*if (FlxG.overlap(shoot.group, FlxG.player))
				FlxG.player.die_motherfucker();*/
		}
	}

}