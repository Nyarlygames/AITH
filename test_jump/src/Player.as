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
                    public var init_speed:int = 250;                // VITESSE DE BASE (max vitesse)
                    public var speedup:int = 150;                   // ACCELERATION
                    public var speeddown:int = 150;                 // DECELERATION
                    public var speedjumpdown:int = 110;             // DESCENTE AUTOMATIQUYE DURANT LE SAUT
                    public var minspeed:int = 50;                   // VITESSE MIN
                    public var mingravity:int = 30;                 // GRAVITE MIN
                    public var maxgravity:int = 5000;               // GRAVITY MAX
                    public var gravityup:int = 1200;                // AUGMENTATION GRAVITE
                    public var gravitydown:int = 1200;              // REDUCTION GRAVITE
                    public var cur_velocity:FlxPoint;               // STOCKAGE VITESSE ET GRAVITE COURANTE (pour contrer les collide)
                    public var gravity:int = 300;                   // GRAVITE
     
                    public var floating:Boolean = false;    // LE JOUEUR FLOTTE?
                    public var jumping:Boolean = false;             // LE JOUEUR SAUTE?
                    public var pause:Boolean = false;               // LE JEU EST EN PAUSE?
                    public var set_old:Boolean = true;              // LES VALEURS DE VITESSE/GRAVITE ONT ETE STOCKEES AU DEBUT DE LA PAUSE?
                    public var lasttile:int = 0;                   
                    public var angularspeed:int = 135;              // VITESSE DE ROTATION
                    public var cur_angularspeed:int = 135;  // VITESSE DE ROTATION0
                    public var pushing:Boolean = false;             // ENTRAIN DE POUSSER UNE POUBELLE?
                    public var push:Poubelle = null;                // POUBELLE POUSSEE
                    public var emitter:FlxEmitter;                  // MOTEUR
                    public var checkpoint:FlxPoint = new FlxPoint(50, 700 - 40);
                   
                   
                    //      ------------------------------------------------ CONSTANTES DE TEST ----------------
                    public var accumulateur:int = 0;
                    public var palier_accumulateur:int = -3430;
                    public var test_gravity:int = 2050;
                   
                    public function Player(xPos:int, yPos:int)
                    {
                            super(xPos, yPos, ImgPlayer);
                            maxVelocity.y = maxgravity;
                            maxVelocity.x = init_speed;
                            facing = RIGHT;
                            acceleration.y = mingravity;
                            gravity = mingravity;
                            velocity.x = init_speed;
                            cur_velocity = new FlxPoint(init_speed, mingravity);
                            cur_angularspeed = angularspeed;                       
                           
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
                           
                            g = new FlxSprite(FlxG.width / 2, 0, ImgG);
                            g.scrollFactor.x = g.scrollFactor.y = 0;
                            g.scale.x = 0.1;
                            v = new FlxSprite(FlxG.width/2, 20, ImgV);
                            v.scrollFactor.x = v.scrollFactor.y = 0;
                    }
                   
                    override public function update():void
                    {
                            emitter.x = x;
                            emitter.y = y + frameHeight;
                            if (!pause) {
                                    // JOUEUR ENTRAIN DE SAUTER
                                    if ((jumping) || (floating)) {
                                            acceleration.y += test_gravity * FlxG.elapsed;
                                    }
                            }
                    }
                   
                    // GESTIONS DES COLLISIONS DE TILES
                    public function tiles_coll(obj1:FlxObject, obj2:FlxObject):void {
                           
                            // TILE COURANTE DE COLLISION
                            var current_tile:uint = (obj2 as FlxTilemap).getTile(Math.floor(x / 40) +2, Math.round(y / 40) +1);
                            // SUR LE TREMPLIN ON AUGMENTE L'ACCUMULATEUR
                            if ((current_tile == 1) || (current_tile == 4))
                                    accumulateur += palier_accumulateur * FlxG.elapsed;
                                   
                            // DERNIERE TILE DU TREMPLIN
                            if ((current_tile == 4) && (jumping == false)) {
                                    lasttile = 4;
                            }
                            // SORTIT DU TREMPLIN
                            else if ((lasttile == 4) && (current_tile == 0)) {
                                    acceleration.y += accumulateur;
                                    jumping = true;
                                    lasttile = 0;
                            }
                            // RAZ DE L'ACCUMULATEUR AU RETOUR AU SOL
                            else if ((jumping) && (acceleration.y > 0)) {
                                    jumping = false;
                                    accumulateur = 0;
                                    angle = 0;
                            }
                           
                           
                            // ROTATION JIMMY TREMPLIN
                            if (((current_tile == 1) || (current_tile == 4)))
                            {
                            angularVelocity = -angularspeed;
                            }
                            else if (angle < -50)
                                    angularVelocity = 0;
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
                   
                    // MORT
                    public function die_motherfucker():void {
                            x = checkpoint.x;
                            y = checkpoint.y;
                            velocity.x = init_speed;
                            velocity.y = mingravity;
                            gravity = mingravity;
                    }
            }
     
    }