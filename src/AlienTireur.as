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
		[Embed(source = '../assets/gfx/gameplay/overboard_tourelle.png')] protected var ImgTourelle:Class;
		[Embed(source = '../assets/gfx/gameplay/flamme_tourelle.png')] protected var ImgFlamme:Class;
		[Embed(source = '../assets/gfx/gameplay/tir_alien.png')] public var ImgShoot:Class;
		public var rate:int = 1500;							// CADENCE DE TIR
		public var maxtir:int = 200;						// MAXIMUM DE TIR
		public var speed:int = 300;							// VITESSE DE TIR
		public var gravity:int = 1000;						// GRAVITE DE TIR
		public var shoot:FlxWeapon;
		
		public function AlienTireur(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgTourelle);
			
			this.loadGraphic(ImgTourelle, true, false, 80, 40);
			this.addAnimation("default",  [0, 1, 2], 5, true);
			
			/* Pré-écriture de l'anim de flamme, à réutiliser.
				this.loadGraphic(ImgFlamme, true, false, 40, 80);
				this.addAnimation("burn",  [0, 1, 2,3,4,5], 5, true);
			*/
			
			// Gestion de la flamme
			/*
				shoot.makeAnimatedBullet(
				shoot = new FlxWeapon("shoot", this, "x", "y");
				shoot.makeImageBullet(maxtir, ImgShoot, frameWidth/2, frameHeight/2);
				shoot.setFireRate(rate);
				shoot.setBulletSpeed(speed);
				shoot.setBulletBounds(new FlxRect(x - 800, y, x, y + 600));
				shoot.setBulletGravity(0, gravity);
				FlxG.state.add(shoot.group);
			*/
		}
		
		override public function update():void 
		{
			shoot.fireFromAngle(90);
			shoot.fire();
			play("default");
			if (onScreen(FlxG.camera)) 
			{
				shoot.fireFromAngle(FlxWeapon.BULLET_DOWN);
			}
			if (FlxG.overlap(shoot.group, FlxG.player))
				FlxG.player.die_motherfucker();
		}
	}
}