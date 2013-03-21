package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxRect;
	import org.flixel.FlxObject;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSound;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	
	/**
	 * Joueur (jimi)
	 * @author ...
	 */
	public class Player extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/gameplay/player.png')] protected var ImgPlayer:Class;
		[Embed(source = '../assets/gfx/misc/particle.png')] protected var ImgParticle:Class;
		[Embed(source = '../assets/gfx/ui/jauge.png')] protected var ImgJauge:Class;
		[Embed(source = "../assets/sfx/gameplay/moteur/JimiMoteur_Vitesse1.mp3")] public var Sfx_Vitesse1:Class;
		[Embed(source = "../assets/sfx/gameplay/moteur/JimiMoteur_Vitesse2.mp3")] public var Sfx_Vitesse2:Class;
		[Embed(source = "../assets/sfx/gameplay/moteur/JimiMoteur_Vitesse3.mp3")] public var Sfx_Vitesse3:Class;
		
		[Embed(source = '../assets/gfx/gameplay/tir_player.png')] public var ImgShoot:Class;
		public var rate:int = 1000;							// CADENCE DE TIR
		public var maxtir:int = 500;						// MAXIMUM DE TIR
		public var speed:int = 200;							// VITESSE DE TIR
		public var damage:int = 1;							// DEGATS TIRS
		public var shoot:FlxWeapon;
		
		public var vitesse1:FlxSound = new FlxSound();
		public var vitesse2:FlxSound = new FlxSound();
		public var vitesse3:FlxSound = new FlxSound();
		public var jauge:FlxSprite;
		public var init_speed:int = 360;  		// VITESSE DE BASE (max vitesse)
		public var speedup:int = 150;	  		// ACCELERATION
		public var speeddown:int = 150;   		// DECELERATION
		public var speedjumpdown:int = 110;		// DESCENTE AUTOMATIQUYE DURANT LE SAUT
		public var minspeed:int = 50;			// VITESSE MIN
		public var mingravity:int = 5;			// GRAVITE MIN
		public var maxgravity:int = 1800;		// GRAVITY MAX
		public var gravityup:int = 1200;		// AUGMENTATION GRAVITE
		public var gravitydown:int = 1200;		// REDUCTION GRAVITE
		public var cur_velocity:FlxPoint;		// STOCKAGE VITESSE ET GRAVITE COURANTE (pour contrer les collide)
		public var gravity:int = 300;			// GRAVITE
		
		public var volumespeed:Number = 0.02;	// BAISSE SON MOTEUR
		
		public var floating:Boolean = false;	// LE JOUEUR FLOTTE?
		public var jumping:Boolean = false;		// LE JOUEUR SAUTE?
		public var pause:Boolean = false;		// LE JEU EST EN PAUSE?
		public var stup:Boolean = false;		// PHASE SHOOT'THEM UP?
		public var set_old:Boolean = true;		// LES VALEURS DE VITESSE/GRAVITE ONT ETE STOCKEES AU DEBUT DE LA PAUSE?
		public var lasttile:int = 0;			
		public var angularspeed:int = 150;		// VITESSE DE ROTATION
		public var cur_angularspeed:int = 150;	// VITESSE DE ROTATION0
		public var pushing:Boolean = false;		// ENTRAIN DE POUSSER UNE POUBELLE?
		public var push:Poubelle = null;		// POUBELLE POUSSEE
		public var emitter:FlxEmitter;			// MOTEUR
		public var checkpoint:FlxPoint = new FlxPoint(50, 700 - 40);
		
		public function Player(xPos:int, yPos:int) 
		{
			super(xPos, yPos, ImgPlayer);
			maxVelocity.y = maxgravity;
			maxVelocity.x = init_speed;
			facing = RIGHT;
			velocity.y = mingravity;
			gravity = mingravity;
			velocity.x = init_speed;
			cur_velocity = new FlxPoint(init_speed, mingravity);
			cur_angularspeed = angularspeed;
			vitesse1.loadEmbedded(Sfx_Vitesse1, true, true);
			vitesse2.loadEmbedded(Sfx_Vitesse2, true, true);
			vitesse3.loadEmbedded(Sfx_Vitesse3, true, true);
			vitesse1.volume = 0;
			vitesse2.volume = 0;
			vitesse3.volume = 1;
			vitesse3.play();
			vitesse2.play();
			vitesse1.play();
			emitter = new FlxEmitter(xPos, yPos, 5);
			for(var i:int = 0; i < 10; i++) {
				var p:FlxParticle = new FlxParticle();
				p.loadGraphic(ImgParticle);
				emitter.add(p);
			}
			emitter.y += frameHeight;
			emitter.gravity = 10;
			emitter.setXSpeed(-10, -2);
			emitter.start(false, 0.4, 0.05, 0);
			FlxG.state.add(emitter);
			
			
			shoot = new FlxWeapon("shoot", this, "x", "y");
			shoot.makeImageBullet(maxtir, ImgShoot, frameWidth, frameHeight/2);
			shoot.setFireRate(rate);
			shoot.setBulletSpeed(speed);
			shoot.setBulletBounds(new FlxRect(0, 0, 800, 800));
			FlxG.state.add(shoot.group);
			
			
			jauge = new FlxSprite(x, y - frameHeight - 40);
			jauge.loadGraphic(ImgJauge, true, false, 120, 40);
			jauge.addAnimation("jauge", [0, 1, 2, 3, 4,5,6,7,8,9,10,11], 12, true);
			jauge.frame = 0;
			jauge.scrollFactor = new FlxPoint(0, 0);
			FlxG.state.add(jauge);
			
			width  -= (width  * 0,1);
			height -= (height * 0,1);
		}
		
		override public function update():void 
		{
			jauge.y = y - 240;
			emitter.x = x;
			emitter.y = y + frameHeight;
			jauge.frame = gravity / 150;
			// SI PAUSE ON GARDE LES VALEURS DE VITESSE ET GRAVITE
			if ((pause) && (set_old == true)) {
				cur_velocity.x = velocity.x;
				cur_velocity.y = velocity.y;
				cur_angularspeed = angularspeed;
				// ET ON BLOQUE JIMI
				angularVelocity = 0;
				velocity.x = 0;
				velocity.y = 0;
				set_old = false;
			}
			else if (pause) {
				// ET ON BLOQUE JIMI
				angularVelocity = 0;
				velocity.x = 0;
				velocity.y = 0;
			}
			else if (!pause) {
				
				// PHASE SHOOT'EM UP
				if (stup == true) {
					shoot.fireFromAngle(FlxWeapon.BULLET_RIGHT);
					health = 100;
					if (FlxG.boss1 != null)
						FlxG.collide(shoot.group, FlxG.boss1, hit_boss);
				}
				else
					handle_sound();
				
				// SI ON APPUIE SUR HAUT
				if (FlxG.keys.pressed("SPACE") && (gravity < maxgravity)) {
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
				
				// ROTATION JIMMY EN L'AIR
				if (jumping && (angle < 0))
					angle += 0.5;
				if (angle < -50)
					angularVelocity = 0;
			}
		}
		
		// GESTIONS DES COLLISIONS DE TILES
		public function tiles_coll(obj1:FlxObject, obj2:FlxObject):void {
			
			// GET LA TILE COURANTE
			var mytile:uint = (obj2 as FlxTilemap).getTile(Math.floor(x / 40) +2, Math.round(y/40) +2);
			
			// HAUT DU TREMPLIN
			if ((mytile == 4) && (jumping == false)) {
				lasttile = 4;
				velocity.y = cur_velocity.y;
				velocity.x = cur_velocity.x;
			}
			// SAUTE (élan)
			else if ((lasttile == 4) && (mytile == 0)) {
				velocity.y = -(cur_velocity.x);
				jumping = true;
				lasttile = 0;
			}
			// RETOUR AU SOL
			else if ((jumping) && (lasttile == 0) && (mytile != 0)) {
				jumping = false;
				if (velocity.x == 0)
					cur_velocity.x = minspeed;
				velocity.x = maxVelocity.x;
			}
			// ROULE SUR LE SOL
			else if ((!pause) && (!jumping)) {
				velocity.x = cur_velocity.x;
			}
			// COLLISION EN L'AIR
			else if ((!pause) && (jumping)) {
				velocity.x = cur_velocity.x;
			}
			// ROTATION JIMMY TREMPLIN
			if (((mytile == 1) || (mytile == 4))) {
				angularVelocity = -angularspeed;
				if (lasttile != 4)
					lasttile = 1;
			}
			// ROTATION JIMMY SOL
			else if ((mytile == 2) && (lasttile != 1)) {
				angle = 0;
			}
		}
		
		// GESTIONS DES COLLISIONS DE POUBELLES
		public function dustbin_pushed(obj1:FlxObject, obj2:FlxObject):void {
			if ((pushing != true) && (push == null)){
				obj2.x = x + (obj2 as Poubelle).frameWidth;
				obj2.velocity.x = velocity.x = init_speed;
				push = (obj2 as Poubelle);
				(push as Poubelle).player = this;
				pushing = true;
			}
		}
		//GESTION DESTRUCTION POUBELLE
		public function dustbin_destroyed(obj1:FlxObject, poubelle:Poubelle) : void
		{
				if (gravity > 50)
				{
					trace ("lol");
				}
			
		}
		
		// GESTION SON MOTEUR
		public function handle_sound():void {
			if (FlxG.keys.pressed("SPACE")) {
				if (velocity.x > 180) {
					vitesse3.volume -= (212.5 * FlxG.elapsed) / 100;
					vitesse2.volume += (212.5 * FlxG.elapsed) / 100;
				}
				else if (velocity.x > 120) {
					vitesse2.volume -= (250 * FlxG.elapsed) / 100;
					vitesse1.volume += (250 * FlxG.elapsed) / 100;
				}
				else if (velocity.x > 50) {
				}
			}
			else if (!FlxG.keys.any())
				if (velocity.x < 120) {
				}
				else if (velocity.x < 180) {
					vitesse2.volume += (250 * FlxG.elapsed) / 100;
					vitesse1.volume -= (250 * FlxG.elapsed) / 100;
				}
				else if (velocity.x < 252) {
					vitesse3.volume += (212.5 * FlxG.elapsed) / 100;
					vitesse2.volume -= (212.5 * FlxG.elapsed) / 100;
				}
		}
		
		// MORT
		public function die_motherfucker():void {
			//trace("LOL RESET", checkpoint.x, checkpoint.y, x, y);
			x = checkpoint.x;
			y = checkpoint.y;
			velocity.x = init_speed;
			velocity.y = mingravity;
			//trace("LOL RESET2", checkpoint.x, checkpoint.y, x, y);
			gravity = mingravity;
			if ((vitesse1 != null) && (vitesse2 != null) && (vitesse3 != null)) {
				vitesse1.volume = 0;
				vitesse2.volume = 0;
				vitesse3.volume = 1;
			}
			//trace("LOL RESET3", checkpoint.x, checkpoint.y,  x, y);
			//FlxG.map.reload_map();
		}
		
		
		// GESTION Collision alien
		public function hit_boss(obj1:FlxObject, obj2:FlxObject):void {
			obj1.kill();
			FlxG.boss1.health -= damage;
		}
	}

}