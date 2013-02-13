package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxRect;
	
	/**
	 * Joueur (jimi)
	 * @author ...
	 */
	public class Player extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/player.png')] protected var ImgPlayer:Class;
		[Embed(source = '../assets/gfx/vit.png')] protected var ImgV:Class;
		[Embed(source = '../assets/gfx/grav.png')] protected var ImgG:Class;
		public var g:FlxSprite;
		public var v:FlxSprite;
		public var init_speed:int = 200;  		// VITESSE DE BASE (max vitesse)
		public var speedup:int = 150;	  		// ACCELERATION
		public var speeddown:int = 150;   		// DECELERATION
		public var speedjumpdown:int = 70;		// DESCENTE AUTOMATIQUYE DURANT LE SAUT
		public var minspeed:int = 50;			// VITESSE MIN
		public var mingravity:int = 5;			// GRAVITE MIN
		public var maxgravity:int = 5000;		// GRAVITY MAX
		public var gravityup:int = 1200;		// AUGMENTATION GRAVITE
		public var gravitydown:int = 1200;		// REDUCTION GRAVITE
		public var cur_velocity:FlxPoint;		// STOCKAGE VITESSE ET GRAVITE COURANTE (pour contrer les collide)
		public var gravity:int = 300;			// GRAVITE
		
		public var floating:Boolean = false;	// LE JOUEUR FLOTTE?
		public var jumping:Boolean = false;		// LE JOUEUR SAUTE?
		public var pause:Boolean = false;		// LE JEU EST EN PAUSE?
		public var set_old:Boolean = true;		// LES VALEURS DE VITESSE/GRAVITE ONT ETE STOCKEES AU DEBUT DE LA PAUSE?
		
		public var checkpoint:FlxPoint = new FlxPoint(50, FlxG.height - 40);
		
		public function Player(xPos:int, yPos:int) 
		{
			super(xPos, yPos, ImgPlayer);
			y -= frameHeight;
			maxVelocity.y = maxgravity;
			maxVelocity.x = init_speed;
			facing = RIGHT;
			velocity.y = mingravity;
			gravity = mingravity;
			velocity.x = init_speed;
			cur_velocity = new FlxPoint(init_speed, mingravity);
			
			g = new FlxSprite(FlxG.width / 2, 0, ImgG);
			g.scrollFactor.x = g.scrollFactor.y = 0;
			g.scale.x = 0.1;
			v = new FlxSprite(FlxG.width/2, 20, ImgV);
			v.scrollFactor.x = v.scrollFactor.y = 0;
		}
		
		override public function update():void 
		{
			// SI PAUSE ON GARDE LES VALEURS DE VITESSE ET GRAVITE
			if ((pause) && (set_old == true)) {
				cur_velocity.x = velocity.x;
				cur_velocity.y = gravity;
				// ET ON BLOQUE JIMI
				velocity.x = 0;
				velocity.y = 0;
				set_old = false;
			}
			else if (!pause) {
				// SI ON APPUIE SUR HAUT
				if (FlxG.keys.pressed("UP") && (gravity < maxgravity)) {
					if (velocity.x > minspeed)
						velocity.x -= speeddown * FlxG.elapsed;
					gravity += gravityup * FlxG.elapsed;
				}
				// SI ON APPUIE SUR RIEN
				else if (!FlxG.keys.any() && (gravity > mingravity)) {
					velocity.x += speedup * FlxG.elapsed;
					gravity -= gravitydown * FlxG.elapsed;
				}
				// RETOMBE AUTOMATIQUEMENT LORS D'UN SAUT
				if ((jumping) || (floating)) {
					velocity.y += (speedjumpdown * FlxG.elapsed) + (gravity * FlxG.elapsed);
				}
					
				// SAUVEGUARDE LA VITESSE POUR LES COLLISIONS
				cur_velocity.x = velocity.x;
				cur_velocity.y = gravity;
					
				// Affichage vitesse/gravité
				g.scale.x = gravity /1000;
				v.scale.x = velocity.x / 100;
			}

		}
		
		
	}

}