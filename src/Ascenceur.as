package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSound;
	
	/**
	 * Ascenceur
	 * @author ...
	 */
	public class Ascenceur extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/ascenceur.png')] 			protected var ImgAscenceur:Class;
		[Embed(source = '../assets/gfx/gameplay/ascenceur_down.png')] 		protected var ImgAscenceurDown:Class;
		[Embed(source = '../assets/gfx/gameplay/ascenceur_up.png')]			 protected var ImgAscenceurUp:Class;
		/*[Embed(source = "../assets/sfx/gameplay/Ascenseur_Activation.mp3")] 		public var SfxActivation:Class;
		[Embed(source = "../assets/sfx/gameplay/Ascenseur_ChangeDirection.mp3")] 	public var SfxChangeWay:Class;
		[Embed(source = "../assets/sfx/gameplay/Ascenseur_End.mp3")] 				public var SfxEnd:Class;
		[Embed(source = "../assets/sfx/gameplay/Ascenseur_Move.mp3")] 				public var SfxMoves:Class;*/
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'Ascenseur.wav')] public var SfxAscenseur:Class;
		[Embed(source = '../assets/sfx/sonsaith.swf', symbol = 'JimiMoteur_Arret.wav')] public var SfxMoteur:Class;
		
		public var soundActivation1:FlxSound = new FlxSound();
		public var soundActivation2:FlxSound = new FlxSound();
		public var soundChangeWay:FlxSound 	= new FlxSound();
		public var soundEnd:FlxSound 		= new FlxSound();
		public var soundMoves:FlxSound 		= new FlxSound();
		
		public var speed:int = 125;						// VITESSE DEPLACEMENT ASCENCEUR
		public var blocked:Boolean = false;				// JOUEUR BLOQUE?
		public var unlock:Boolean = false;				// JOUEUR BLOQUE?
		
		
		public function Ascenceur(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgAscenceur);
			soundActivation1.loadEmbedded(SfxAscenseur, true, false);
			soundActivation2.loadEmbedded(SfxAscenseur, true, false);
			/*soundChangeWay.loadEmbedded(SfxChangeWay);
			soundEnd.loadEmbedded(SfxEnd);*/
			soundMoves.loadEmbedded(SfxMoteur);
			immovable = true;
		}
		
		override public function update():void {
			// BLOQUE LE JOUEUR
			if ((FlxG.player != null) && (x <= FlxG.player.x) && (FlxG.overlap(FlxG.player, this)) && (unlock == false))
			{
				blocked = true;
				FlxG.player.on_ascenseur = true;
				FlxG.player.angle = 0;
			}
			FlxG.collide(FlxG.player, this, up_and_down);
		}
		
		
		// GESTIONS DU DEPLACEMENT SUR ASCENCEUR
		public function up_and_down(obj1:FlxObject, obj2:FlxObject):void {
			if (blocked == true) {
				FlxG.player.x = x + FlxG.player.offset.x;
				FlxG.player.velocity.x = 0;
				FlxG.player.velocity.y = 0;
				
				soundMoves.play();
				FlxG.player.vitesse1.volume = 0;
				FlxG.player.vitesse2.volume = 0;
				FlxG.player.vitesse3.volume = 0;
				// DEPLACEMENT BLOQUE
				if (FlxG.keys.pressed("SPACE")) 
				{
					soundActivation2.stop();
					soundActivation2.kill();
					soundActivation1.revive();
					soundActivation1.play();
					/*soundMoves.revive();
					soundMoves.play();*/
					y += speed * FlxG.elapsed;
					loadGraphic(ImgAscenceurDown);
					FlxG.player.y += speed * FlxG.elapsed;
				}
				else 
				{
					soundActivation1.stop();
					soundActivation1.kill();
					soundActivation2.revive();
					soundActivation2.play();
					/*soundActivation.revive();
					soundActivation.play();
					soundMoves.kill();*/
					y -= speed * FlxG.elapsed;
					loadGraphic(ImgAscenceurUp);
					FlxG.player.y -= speed * FlxG.elapsed;
				}
				// GESTIONS COLLISIONS TRIGGERS/ASCENCEURS
				for each (var item:Trigger in FlxG.map.triggers.members) 
				{
					if ((item != null) && (item.x == this.x + 80) && (item.y == Math.round(this.y))) 
					{
						unlock = true;
						y = item.y;
						delock(item);
					}
				}
			}
			if (!onScreen(FlxG.camera) || (blocked == false) )
				if (soundMoves != null) {
					soundActivation1.stop();
					soundActivation1.kill();
					soundActivation1.destroy();
					soundActivation2.stop();
					soundActivation2.kill();
					soundActivation2.destroy();
					soundMoves.stop();
					soundMoves.kill();
					soundMoves.destroy();
				}
		}
		
		// DEBLOQUE ASCENCEUR
		public function delock(trig:Trigger):void 
		{
			/*soundMoves.stop();
			soundActivation.stop();
			soundChangeWay.stop();
			soundEnd.play();*/
			if (soundActivation1 != null) {
				soundActivation1.stop();
				soundActivation1.kill();
			}
			if (soundActivation2 != null) {
				soundActivation2.stop();
				soundActivation2.kill();
			}
			if (soundMoves != null) {
				soundMoves.stop();
				soundMoves.kill();
			}
			blocked = false;
			FlxG.player.velocity.x = FlxG.player.init_speed;
			FlxG.player.vitesse3.volume = 1;
		}
		
	}

}