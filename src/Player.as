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
		// LA MUSIQUE ET LE SON MOTEUR SONT DESACTIVFES POUR PAUL.
		[Embed(source = '../assets/gfx/gameplay/jimi_tile.png')]	 	 protected var ImgPlayer:Class;
		[Embed(source = '../assets/gfx/misc/particle.png')] 			 protected var ImgParticle:Class;
		[Embed(source = '../assets/gfx/ui/jauge.png')] 					 protected var ImgJauge:Class;
		[Embed(source = "../assets/sfx/gameplay/moteur/JimiMoteur_Vitesse1.mp3")] public var Sfx_Vitesse1:Class;
		[Embed(source = "../assets/sfx/gameplay/moteur/JimiMoteur_Vitesse2.mp3")] public var Sfx_Vitesse2:Class;
		[Embed(source = "../assets/sfx/gameplay/moteur/JimiMoteur_Vitesse3.mp3")] public var Sfx_Vitesse3:Class;
		
		[Embed(source = '../assets/gfx/gameplay/tir_player.png')] public var ImgShoot:Class;
		
		public var vitesse1:FlxSound = new FlxSound();
		public var vitesse2:FlxSound = new FlxSound();
		public var vitesse3:FlxSound = new FlxSound();
		public var jauge:FlxSprite;
		public var init_speed:int = 360;  		// VITESSE DE BASE (max vitesse)
		public var mingravity:int = -250;               // GRAVITE MIN
		public var maxgravity:int = 50000;              // GRAVITY MAX
		public const const_gravity:int = 300;			public var accumulateur:int = 0;
		public var palier_accumulateur:int = -100000;
		public var gravity:int = 0;
		public var gravity_increment:int = 35000;
		public var gravity_decrement:int = 20000;
		public var on_tremplin:Boolean = false;
		public var on_ascenseur:Boolean = false;
		public var acceleration_speed:int = 150;   
		public var maxgravity_test:int = 2000;
		
		public var volumespeed:Number = 0.02;	// BAISSE SON MOTEUR
		
		public var jumping:Boolean = false;		// LE JOUEUR SAUTE?
		public var pause:Boolean = false;		// LE JEU EST EN PAUSE?
		public var set_old:Boolean = true;		// LES VALEURS DE VITESSE/GRAVITE ONT ETE STOCKEES AU DEBUT DE LA PAUSE?
		public var angularspeed:int = 150;		// VITESSE DE ROTATION
		public var cur_angularspeed:int = 150;	// VITESSE DE ROTATION0
		public var pushing:Boolean = false;		// ENTRAIN DE POUSSER UNE POUBELLE?
		public var push:Poubelle = null;		// POUBELLE POUSSEE
		public var emitter:FlxEmitter;			// MOTEUR
		public var checkpoint:FlxPoint = new FlxPoint(50, 700 - 40);
		
		public function Player(xPos:int, yPos:int) 
		{
			super(xPos, yPos, ImgPlayer);
					
			maxVelocity.y = maxgravity_test;
			maxVelocity.x = init_speed;
			facing = RIGHT;
			acceleration.x = acceleration_speed;
			cur_angularspeed = angularspeed;
			
			width = 60;
			height = 70;
			offset.x = 10;
			vitesse1.loadEmbedded(Sfx_Vitesse1, true, true);
			vitesse2.loadEmbedded(Sfx_Vitesse2, true, true);
			vitesse3.loadEmbedded(Sfx_Vitesse3, true, true);
			vitesse1.volume = 0;
			vitesse2.volume = 0;
			vitesse3.volume = 1;
			//vitesse3.play();
			//vitesse2.play();
			//vitesse1.play();
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
			
			jauge = new FlxSprite(x, y - frameHeight - 40);
			jauge.loadGraphic(ImgJauge, true, false, 120, 40);
			jauge.addAnimation("jauge", [0, 1, 2, 3, 4,5,6,7,8,9,10,11], 12, true);
			jauge.frame = 0;
			jauge.scrollFactor = new FlxPoint(0, 0);
			FlxG.state.add(jauge);
			
			//Animations du joueur
			this.loadGraphic(ImgPlayer, true, false, 80, 80);
			this.addAnimation("slowSpeed",  [0,1], 5, true);
			this.addAnimation("midSpeed", 	[4,5], 5, true);
			this.addAnimation("fastSpeed",  [8,9,10], 5, true);
		}
		
		override public function update():void 
		{
			play ("midSpeed");
			jauge.y = y - 240;
			emitter.x = x;
			emitter.y = y + frameHeight;
			jauge.frame = gravity / 150;
			if (angle < -45)
			{
				angularVelocity = 0;
			}
			
			if ((acceleration.y > mingravity && acceleration.y < maxgravity)){
				if (FlxG.keys.pressed("SPACE")) {
					if (gravity >= maxgravity) {
						gravity = maxgravity;
					} else {
						gravity += gravity_increment * FlxG.elapsed;
					}
				} else if ((velocity.y > 0) || on_ascenseur){
					if (gravity <= mingravity) {
						gravity = mingravity;
					} else {
						gravity -= gravity_decrement * FlxG.elapsed;
					}
				}
			}
			
			acceleration.y = gravity * FlxG.elapsed + const_gravity;
			
			if (FlxG.overlap(FlxG.map.tremplin_bas, this)) {
				on_tremplin = true;
			}
			if (on_tremplin == true) {
				accumulateur += palier_accumulateur * FlxG.elapsed;
				if (FlxG.overlap(FlxG.map.tremplin_haut, this)) {
						on_tremplin = false;
						acceleration.y += accumulateur;
				}
			}
			
			if (velocity.y != 0) {
				jumping = true;
			} else {
				jumping = false;
			}
		}
		
		// GESTIONS DES COLLISIONS DE TILES
		public function tiles_coll(obj1:FlxObject, obj2:FlxObject):void {
			// TILE COURANTE DE COLLISION
			var current_tile:uint = (obj2 as FlxTilemap).getTile(Math.floor(x / 40) +2, Math.round(y / 40) +1); // prochaine 
			var current_tile2:uint = (obj2 as FlxTilemap).getTile(Math.floor(x / 40) +1, Math.round(y / 40) +2);// en dessous
			
			// SUR LE TREMPLIN ON AUGMENTE L'ACCUMULATEUR
			if (((current_tile == 1) || (current_tile == 4)) && (jumping == false))
			{
				angularVelocity = -angularspeed;
				width = 60;
			}
			else if (current_tile2 == 2 && jumping == false){
				accumulateur = 0;
				angle = 0;
				gravity = mingravity;
			}
		}
		
		// GESTIONS DES COLLISIONS DE POUBELLES
		public function dustbin(obj1:FlxObject, obj2:FlxObject):void {
			if ((pushing != true) && (push == null)) {
				
				(obj2 as Poubelle).soundPushed.play();
				push = (obj2 as Poubelle);
				(push as Poubelle).player = this;
				pushing = true;
			}
		}

		
		// GESTION SON MOTEUR
		public function handle_sound():void {
			
			if (FlxG.keys.pressed("SPACE")) 
			{
				if (velocity.x > 180) 
				{
					play("fastSpeed", true);
					vitesse3.volume -= (212.5 * FlxG.elapsed) / 100;
					vitesse2.volume += (212.5 * FlxG.elapsed) / 100;
				}
				else if (velocity.x > 120) 
				{
					vitesse2.volume -= (250 * FlxG.elapsed) / 100;
					vitesse1.volume += (250 * FlxG.elapsed) / 100;
					play("midSpeed", true);
				}
				else if (velocity.x > 50) 
				{
					play("slowSpeed", true);
				}
			}
			else if (!FlxG.keys.any())
				if (velocity.x < 120) 
				{
					play("slowSpeed", true);
				}
				else if (velocity.x < 180) 
				{
					play("midSpeed", true);
					vitesse2.volume += (250 * FlxG.elapsed) / 100;
					vitesse1.volume -= (250 * FlxG.elapsed) / 100;
				}
				else if (velocity.x < 252) 
				{
					play("fastSpeed", true);
					vitesse3.volume += (212.5 * FlxG.elapsed) / 100;
					vitesse2.volume -= (212.5 * FlxG.elapsed) / 100;
				}
		}
		
		// MORT
		public function die_motherfucker():void {
			
			x = checkpoint.x;
			y = checkpoint.y;
			velocity.y = 0;
			accumulateur = 0;
			angle = 0;
			gravity = mingravity;
			if ((vitesse1 != null) && (vitesse2 != null) && (vitesse3 != null)) {
				vitesse1.volume = 0;
				vitesse2.volume = 0;
				vitesse3.volume = 1;
			}
			//FlxG.map.reload_map();
		}
	}

}