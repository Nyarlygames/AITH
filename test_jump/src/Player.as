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
	   
		/**
		 * Joueur (jimi)
		 * @author ...
		 */
		public class Player extends FlxSprite
		{
			   
			[Embed(source = '../assets/gfx/gameplay/player.png')] protected var ImgPlayer:Class;
			[Embed(source = '../assets/gfx/misc/particle.png')] protected var ImgParticle:Class;
			[Embed(source = '../assets/gfx/ui/jauge_vitesse.png')] protected var ImgV:Class;
			[Embed(source = '../assets/gfx/ui/jauge_gravite.png')] protected var ImgG:Class;
			public var g:FlxSprite;
			public var v:FlxSprite;
			public var init_speed:int = 250;                // VITESSE DE BASE (max vitesse)é
			
			public var mingravity:int = -1200;                 // GRAVITE MIN
			public var maxgravity:int = 2000;               // GRAVITY MAX

			public var cur_velocity:FlxPoint;               // STOCKAGE VITESSE ET GRAVITE COURANTE (pour contrer les collide)
			public var gravity:int = 300;                   // GRAVITE
			public var jumping:Boolean = false;             // LE JOUEUR SAUTE?
			public var pause:Boolean = false;               // LE JEU EST EN PAUSE?
			public var set_old:Boolean = true;              // LES VALEURS DE VITESSE/GRAVITE ONT ETE STOCKEES AU DEBUT DE LA PAUSE?
			public var angularspeed:int = 200;              // VITESSE DE ROTATION
			public var cur_angularspeed:int = 135;  		// VITESSE DE ROTATION ACTUELLE
		   
		   
			//      ------------------------------------------------ CONSTANTES DE TEST ----------------
			public var accumulateur:int = 0;
			public var palier_accumulateur:int = -6800;
			public var test_gravity:int = 0;
			public var gravity_increment:int = 1200;
			public var gravity_decrement:int = 700;
			public var maxgravity_test:int = 2000;
			public var minVelocity:int = 50;                // VITESSE MIN
			public var acceleration_speed:int = 50;                // VITESSE MIN
			public var speed:int = 50;
			public var on_tremplin:Boolean = false;
		   
			public function Player(xPos:int, yPos:int)
			{
					super(xPos, yPos, ImgPlayer);
					maxVelocity.y = maxgravity_test;
					maxVelocity.x = init_speed;
					facing = RIGHT;
					acceleration.x = acceleration_speed;
					cur_angularspeed = angularspeed;
					
					width = 75;
					height = 75;
					offset.x = 2.5;
					offset.y = 2.5;
			}
		   
			override public function update():void
			{					
					if (angle < -45)
					{
						angularVelocity = 0;
					}
					
					if (jumping && (acceleration.y > mingravity && acceleration.y < maxgravity)){
						if (FlxG.keys.pressed("SPACE")) {
							trace("WEIGHT UP");
							if (test_gravity >= 2000) {
								test_gravity = 2000;
							} else {
								test_gravity += gravity_increment * FlxG.elapsed;
							}
						} else if (velocity.y > 0) {
							trace("WEIGHT DOWN");
							if (test_gravity <= -200) {
								test_gravity = -200;
							} else {
								test_gravity -= gravity_decrement * FlxG.elapsed;
							}
						}
						test_gravity += 250 * FlxG.elapsed;
						
						//Gravity
						
						//acceleration.y = 200 * FlxG.elapsed;
						trace("GRAVITY : " + test_gravity);
					}
					
					acceleration.y = test_gravity * FlxG.elapsed;
					trace("ACCELERATION : " + acceleration.y);
					
					if (FlxG.overlap(FlxG.map.tremplin_bas, this)) {
						on_tremplin = true;
						trace("bas");
					}
					if (on_tremplin == true) {
						accumulateur += palier_accumulateur * FlxG.elapsed;
						if (FlxG.overlap(FlxG.map.tremplin_haut, this)) {
								trace("haut");
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
				// RAZ DE L'ACCUMULATEUR AU RETOUR AU SOL
				if (jumping && (current_tile2 == 2 || current_tile2 == 3)){
					accumulateur = 0;
					angle = 0;
				}
					// SUR LE TREMPLIN ON AUGMENTE L'ACCUMULATEUR
					if (((current_tile == 1) || (current_tile == 4)) && (jumping == false))
					{
						angularVelocity = -angularspeed;
						width = 60;
					}
						   

			}
		}
 
}
