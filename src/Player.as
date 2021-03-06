package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxRect;
	import org.flixel.FlxObject;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSound;
	import com.greensock.*;
	import com.greensock.easing.*;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.FlxSubState;
	
	/**
	 * Joueur (jimi)
	 * @author ...
	 */
	public class Player extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/jimi_tile.png')]	 	 protected var ImgPlayer:Class;
		[Embed(source = '../assets/gfx/gameplay/Jimi_mortv2.png')]	 	 protected var ImgMort:Class;
		[Embed(source = '../assets/gfx/misc/particle.png')] 			 protected var ImgParticle:Class;
		[Embed(source = '../assets/gfx/misc/alienPart.png')] 			 protected var ImgParticleAlien:Class;
		[Embed(source = '../assets/gfx/ui/jauge.png')] 					 protected var ImgJauge:Class;
		[Embed(source = "../assets/sfx/gameplay/CheckPoint_Revive.mp3")] public var sfxRevive:Class;
		/*[Embed(source = "../assets/sfx/gameplay/moteur/JimiMoteur_Vitesse1.mp3")] public var Sfx_Vitesse1:Class;
		[Embed(source = "../assets/sfx/gameplay/moteur/JimiMoteur_Vitesse2.mp3")] public var Sfx_Vitesse2:Class;
		[Embed(source = "../assets/sfx/gameplay/moteur/JimiMoteur_Vitesse3.mp3")] public var Sfx_Vitesse3:Class;*/
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'JimiMoteur_Vitesse1.wav')] public var Sfx_Vitesse1:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'JimiMoteur_Vitesse2.wav')] public var Sfx_Vitesse2:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'JimiMoteur_Vitesse3.wav')] public var Sfx_Vitesse3:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Jimi_Mort_Normal1.wav')] public var SfxMort1:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Jimi_Mort_Normal2.wav')] public var SfxMort2:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Jimi_Mort_Normal3.wav')] public var SfxMort3:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Jimi_Mort_OutScreen1.wav')] public var SfxMortOutScreen1:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Jimi_Mort_OutScreen2.wav')] public var SfxMortOutScreen2:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Jimi_Mort_OutScreen3.wav')] public var SfxMortOutScreen3:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Jimi_Atterrissage1.wav')] public var SfxAtterissage1:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Jimi_Atterrissage2.wav')] public var SfxAtterissage2:Class;
		
		[Embed(source = '../assets/gfx/gameplay/tir_player.png')] public var ImgShoot:Class;
		
		public var soundRevive:FlxSound = new FlxSound();
		public var vitesse1:FlxSound = new FlxSound();
		public var vitesse2:FlxSound = new FlxSound();
		public var vitesse3:FlxSound = new FlxSound();
		
		public var jauge:FlxSprite;
		public var init_speed:int 				= 350;  		// VITESSE DE BASE (max vitesse)
		public var mingravity:int 				= -250;         // GRAVITE MIN
		public var maxgravity:int 				= 50000;        // GRAVITY MAX
		public var minspeed:int 				= 70;
		public var speeddown:int				= 250;
		public const const_gravity:int			= 300;			
		public var accumulateur:int 			= 0;
		public var palier_accumulateur:int 		= -85000;
		public var max_palier:int 				= -100000;
		public var gravity:int 					= 0;
		public var gravity_increment:int 		= 35000;
		public var gravity_decrement:int 		= 20000;
		public var on_tremplin:Boolean 			= false;
		public var on_ascenseur:Boolean 		= false;
		public var acceleration_speed:int		= 150;   
		public var maxgravity_test:int 			= 2000;
		public var checkscore:int				= 0;		// SCORE DEPUIS LE DERNIER CHECKPOINT
		public var volumespeed:Number			= 0.02;		// BAISSE SON MOTEUR
		public var from:int						= 0;		// WHERE DID HE DIE
		
		public var jumping:Boolean 				= false;	// LE JOUEUR SAUTE?
		public var pause:Boolean 				= false;	// LE JEU EST EN PAUSE?
		public var dead:Boolean 				= false;	// JIMI EST MORT ? OMGWTF!
		public var old_acceleration:FlxPoint	= new FlxPoint(0, 0);	// OLD ACCELERATION
		public var old_velocity:FlxPoint		= new FlxPoint(0, 0);	// OLD VELOCITY
		public var old_accu:FlxPoint			= new FlxPoint(0, 0);	// OLD ACCUMULATEUR
		public var old_gravity:int				= 0;					// OLD GRAVITY
		public var old_angle:int				= 0;					// OLD ANGLE
		public var old_angularspeed:int			= 0;				// OLD ANGLE
		public var angularspeed:int 			= 150;		// VITESSE DE ROTATION
		public var pushing:Boolean 				= false;	// ENTRAIN DE POUSSER UNE POUBELLE?
		public var push:Poubelle				= null;		// POUBELLE POUSSEE
		public var emitter:FlxEmitter;			
		public var emitterAlien:FlxEmitter;		// MOTEUR
		public var checkpoint:FlxPoint 			= new FlxPoint(50, 700 - 40);
		public var steamPart:FlxParticle;
		public var deadscore:int				= 0;
		public var endLvl:Boolean				= false;
		public var death:DeathScreen;
		public var falled:Boolean = false;
		public var souffled:Boolean = false;
		public var played:Boolean = true;
		public var atterissage1:FlxSound = new FlxSound();
		public var atterissage2:FlxSound = new FlxSound();
		public var muted:Boolean = false;
		
		public function Player(xPos:int, yPos:int) 
		{
			super(xPos, yPos, ImgPlayer);
			FlxG.score = 0;
			
			soundRevive.loadEmbedded(sfxRevive);
			soundRevive.volume = 0.3;
			palier_accumulateur = max_palier;
			maxVelocity.y = maxgravity_test;
			maxVelocity.x = init_speed;
			facing = RIGHT;
			acceleration.x = acceleration_speed;
			velocity.x = init_speed;
			vitesse1.loadEmbedded(Sfx_Vitesse1, true, true);
			vitesse2.loadEmbedded(Sfx_Vitesse2, true, true);
			vitesse3.loadEmbedded(Sfx_Vitesse3, true, true);
			atterissage1.loadEmbedded(SfxAtterissage1, false, true);
			atterissage2.loadEmbedded(SfxAtterissage2, false, true);
			atterissage1.volume = 0.8;
			atterissage2.volume = 0.8;
			vitesse1.volume = 0;
			vitesse2.volume = 0;
			vitesse3.volume = 0;
			vitesse3.play();
			vitesse2.play();
			vitesse1.play();
			
			// Classic particles
			emitter = new FlxEmitter(xPos, yPos, 10);
			for (var i:int = 0; i < 10; i++) 
			{
				steamPart = new FlxParticle();
				steamPart.loadGraphic(ImgParticle);
				steamPart.alpha = 0.4;
				emitter.add(steamPart);
			}
			emitter.y += frameHeight;
			emitter.gravity = -200;
			emitter.setXSpeed(-10, -2);
			emitter.start(false, 0.8, 0.05, 0);
			FlxG.state.add(emitter);
			
			// Particle using alien grav
			emitterAlien = new FlxEmitter(xPos, yPos, 10);
			for(var g:int = 0; g < 10; g++) {
				steamPart = new FlxParticle();
				steamPart.loadGraphic(ImgParticleAlien);
				steamPart.alpha = 0.4;
				emitterAlien.add(steamPart);
			}
			emitterAlien.y += frameHeight;
			emitterAlien.gravity = -200;
			emitterAlien.setXSpeed( -10, -2);
			emitterAlien.start(false, 0.8,0.05, 0);
			FlxG.state.add(emitterAlien);
			
			//emitter.kill();
			//emitterAlien.kill();
			
			jauge = new FlxSprite(x, y - frameHeight - 40);
			jauge.loadGraphic(ImgJauge, true, false, 120, 40);
			jauge.addAnimation("jauge", [0, 1, 2, 3, 4,5,6,7,8,9,10,11], 12, true);
			jauge.frame = 0;
			jauge.scrollFactor = new FlxPoint(0, 0);
			FlxG.state.add(jauge);
			
			//Animations du joueur
			this.loadGraphic(ImgPlayer, true, false, 80, 80);
			this.addAnimation("slowSpeed", [0,1], 5, true);
			this.addAnimation("midSpeed", [6,7], 15, true);
			this.addAnimation("fastSpeed", [12,13,14], 30, true);
			this.addAnimation("souffle", [18,19,20], 30, false);
			this.addAnimation("retombe", [24, 25, 26, 27, 28], 30, false);
			addAnimationCallback(anims);
			width = 80;
			height = 60;
			offset.y = 20;
		}
		
		override public function update():void 
		{
			if ((!pause) && (!dead) && (!endLvl)) {
				handle_sound();
				
				if (velocity.x > 260) 
				{
					play("fastSpeed");
				}
				else if (velocity.x > 160) 
				{
					play("midSpeed");
				}
				else if (velocity.x >= -10) 
				{
					play("slowSpeed");
				}
				
				
				//play ("midSpeed");
				jauge.y = y - 270;
				jauge.frame = (palier_accumulateur + 10000) / 7500 + 12; 
				
				if (angle == 0) {
					emitter.y = y + frameHeight - 35;
					emitter.x = x ;
					emitterAlien.y = y + frameHeight - 35;
					emitterAlien.x = x;
				}
				else {
					emitter.x = x + 20;
					emitter.y = y + frameHeight - 30;
					emitterAlien.x = x + 20;
					emitterAlien.y = y + frameHeight - 30;
				}
				if (angle <= -45)
				{
					angularVelocity = 0;
				}
				
				if (FlxG.keys.pressed("SPACE"))
				{
					emitterAlien.on = true;
					emitter.on = false;
				}
				else if (!FlxG.keys.any())
				{
					emitterAlien.on = false;
					emitter.on = true;
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
				if (FlxG.keys.pressed("SPACE") && (velocity.x > minspeed)) {
					velocity.x -= speeddown * FlxG.elapsed;
					if (palier_accumulateur + 1000 <= -10000)
						palier_accumulateur += 1000;
				}
				else if (!FlxG.keys.any()) {
					if ((palier_accumulateur - 1000) >= max_palier) {
						palier_accumulateur -= 1000;
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
						offset.y = 20;
						width = 80;
					}
				}
				
				if (velocity.y != 0) {
					jumping = true;
					played = false;
				} else {
					jumping = false;
				}
				
				if (velocity.x <= (minspeed - speeddown * FlxG.elapsed)) {
					velocity.x = init_speed;
				}
				if (acceleration.x != acceleration_speed)
					acceleration.x = acceleration_speed;
			}
		}
		private function anims(animationName:String, frameNumber:uint, frameIndex:uint):void 
		{  	
			if (animationName == "souffle" ) {
			}
			/*else if (animationName == "retombe") {
			}*/
		}
		// GESTIONS DES COLLISIONS DE TILES
		public function tiles_coll(obj1:FlxObject, obj2:FlxObject):void {
			// TILE COURANTE DE COLLISION
			var current_tile:uint = (obj2 as FlxTilemap).getTile(Math.floor(x / 40) +2, Math.round(y / 40) +1); // prochaine 
			var current_tile2:uint = (obj2 as FlxTilemap).getTile(Math.floor(x / 40) +1, Math.round(y / 40) +1);// en dessous
			
			// SUR LE TREMPLIN ON AUGMENTE L'ACCUMULATEUR
			if (((current_tile == 1) || (current_tile == 4)) && (jumping == false))
			{
				angularVelocity = -angularspeed;
				offset.y = 20;
				width = 60;
				/* TODO
				 * ANGLE QUAND ON TOUCHE MAIS JUMP = TRUE
				 */
			}
			else if (current_tile2 == 2 && jumping == false){
				if (on_tremplin == false)
					angle = 0;
				if (played == false) {
					played = true;
					var chance:int = Math.ceil(Math.random() * 2);
					switch(chance) {
						case 1:
							atterissage1.play();
							break;
						case 2:
							atterissage2.play();
							break;
					}
				}
				accumulateur = 0;
				gravity = mingravity;
			}
			else {
				// WHAT'S THERE ?
			}
		}
		
		// GESTIONS DES COLLISIONS DE POUBELLES
		public function dustbin(obj1:FlxObject, obj2:FlxObject):void {
			if ((pushing != true) && (push == null)) {
				velocity.x = 110;
				(obj2 as Poubelle).soundPushed.play();
				push = (obj2 as Poubelle);
				(push as Poubelle).player = this;
				pushing = true;
			}
			else if (obj2.y > obj1.y) {	
				obj1.y = obj2.y - frameHeight + offset.y;
			}
		}

		
		// GESTION SON MOTEUR
		public function handle_sound():void {
			if (FlxG.keys.pressed("SPACE")) 
			{
				if (velocity.x > 260) 
				{
					vitesse3.volume -= (111 * FlxG.elapsed) / 100;
					vitesse2.volume += (111 * FlxG.elapsed) / 100;
				}
				else if (velocity.x > 160) 
				{
					vitesse2.volume -= (100 * FlxG.elapsed) / 100;
					vitesse1.volume += (100 * FlxG.elapsed) / 100;
				}
				else if (velocity.x >= 0) 
				{
				}
			}
			else if (!FlxG.keys.any())
			{
				if (velocity.x < 160) 
				{
				}
				else if (velocity.x < 250) 
				{
					vitesse2.volume += (167 * FlxG.elapsed) / 100;
					vitesse1.volume -= (167 * FlxG.elapsed) / 100;
				}
				else if (velocity.x < 370) 
				{
					vitesse3.volume += (150 * FlxG.elapsed) / 100;
					vitesse2.volume -= (150 * FlxG.elapsed) / 100;
				}
			}
		}
		
		public function stopPlayer():void // ARRETE LE DEPLACEMENT DU JOUEUR
		{
			old_gravity = gravity;
			old_accu.x = accumulateur;
			old_accu.y = palier_accumulateur;
			old_acceleration.x = acceleration.x;
			old_acceleration.y = acceleration.y;
			old_velocity.x = velocity.x;
			old_velocity.y = velocity.y;
			old_angle = angle;
			old_angularspeed = angularVelocity;
			velocity.x = 0;
			velocity.y = 0;
			acceleration.x = 0;
			acceleration.y = 0;
			gravity = 0;
			palier_accumulateur = 0;
			accumulateur = 0;
			angularVelocity = 0;
		}
		
		public function die_motherfucker(where:int):void { // MORT : TUE LE JOUEUR ET LE FAIS REVIVRE
			if (death == null)
			{
				if (where == 1) {
					var chance:int = Math.ceil(Math.random() * 3);
					switch(chance) {
						case 1:
							FlxG.play(SfxMortOutScreen1, 1, false, true);
							break;
						case 2:
							FlxG.play(SfxMortOutScreen2, 1, false, true);
							break;
						case 3:
							FlxG.play(SfxMortOutScreen3, 1, false, true);
							break;
					}
				}
				else{
					var chance2:int = Math.ceil(Math.random() * 3);
					switch(chance2) {
						case 1:
							FlxG.play(SfxMort1, 1, false, true);
							break;
						case 2:
							FlxG.play(SfxMort2, 1, false, true);
							break;
						case 3:
							FlxG.play(SfxMort3, 1, false, true);
							break;
					}
				}
				deadscore += 1;
				TweenMax.to(this, 1.5, { alpha:0, ease:Linear.easeOut }  );
				TweenMax.to(jauge, 1.5, { alpha:0, ease:Linear.easeOut }  );
				dead = true;
				stopPlayer();
				from = where;
				death = new DeathScreen();
				FlxG.state.setSubState(death, onDeathClosed);
				loadGraphic(ImgMort, true, false, 160, 160);
				addAnimation("mortmortmort",  [0, 1, 2, 3, 4, 5, 6, 7, 8], 17, false);
				offset.x = 80;
				offset.y = 100;
				play("mortmortmort");
			}
		}
		
		// FIN DU MONDE
		public function onDeathClosed(state:FlxSubState, result:String):void
		{
			// RETRY
			if (result == DeathScreen.RETRY) {
				loadGraphic(ImgPlayer, true, false, 80, 80);
				this.addAnimation("slowSpeed", [0,1], 5, true);
				this.addAnimation("midSpeed", [6,7], 15, true);
				this.addAnimation("fastSpeed", [12,13,14], 30, true);
				this.addAnimation("souffle", [18,19,20], 30, false);
				this.addAnimation("retombe", [24, 25, 26, 27, 28], 30, false);
				width = 80;
				height = 60;
				offset.y = 20;
				offset.x = 0;
				TweenMax.to(this, 1, { alpha:1, ease:Linear.easeOut });
				TweenMax.to(jauge, 1, { alpha:1, ease:Linear.easeOut });
				accumulateur = 0;
				soundRevive.play();
				velocity.y = 0;
				palier_accumulateur = max_palier;
				gravity = mingravity;
				x = checkpoint.x;
				if (from == 1) {
					y = checkpoint.y - 10;
				}
				else
					y = checkpoint.y;
				FlxG.map.cam.x = x + 350;
				FlxG.score -= checkscore;
				checkscore = 0;
				velocity.x = init_speed;
				angle = 0;
				if ((vitesse1 != null) && (vitesse2 != null) && (vitesse3 != null) && (muted == false)) {
					vitesse1.volume = 0;
					vitesse2.volume = 0;
					vitesse3.volume = 1;
				}
				emitter.clear();
				emitterAlien.clear();
				for (var i:int = 0; i < 10; i++) 
				{
					steamPart = new FlxParticle();
					steamPart.loadGraphic(ImgParticle);
					steamPart.alpha = 0.4;
					emitter.add(steamPart);
				}
				for(var g:int = 0; g < 10; g++) {
					steamPart = new FlxParticle();
					steamPart.loadGraphic(ImgParticleAlien);
					steamPart.alpha = 0.4;
					emitterAlien.add(steamPart);
				}
				FlxG.map.reload_map();
				death.kill();
				death.destroy();
				death = null;
			}
			// RETOUR MENU
			else if (result == DeathScreen.QUIT_GAME) {
				if ((FlxG.state as Play).sound != null)
					(FlxG.state as Play).sound.destroy();
				vitesse1.destroy();
				vitesse2.destroy();
				vitesse3.destroy();
				FlxG.map.reload_map();
				FlxG.switchState(new UnivChooser());
			}
			else if (result == DeathScreen.RESTART) {
				if ((FlxG.state as Play).sound != null)
					(FlxG.state as Play).sound.destroy();
				vitesse1.destroy();
				vitesse2.destroy();
				vitesse3.destroy();
				FlxG.score = -(FlxG.state as Play).map.id;
				FlxG.map.reload_map();
				FlxG.resetState();
			}
		}
	}

}