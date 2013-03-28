package  
{
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxTimer;
	
	/**
	 * Tourelle
	 * @author ...
	 */
	public class Tourelle extends FlxSprite
	{
		[Embed(source = '../assets/gfx/gameplay/overboard_tourelle.png')] protected var ImgTourelle:Class;
		[Embed(source = '../assets/gfx/gameplay/flamme_tourelle.png')] protected var ImgFlamme:Class;
		public var rate:int = 1500;							// CADENCE DE TIR
		public var maxtir:int = 200;						// MAXIMUM DE TIR
		public var speed:int = 300;							// VITESSE DE TIR
		public var gravity:int = 1000;						// GRAVITE DE TIR
		public var flammes:FlxSprite;
		public var timer:FlxTimer = new FlxTimer();
		
		
		/* flammes 40      20 - 60
		 * overboard 80      40
		 */
		
		public function Tourelle(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgTourelle);
			
			flammes = new FlxSprite(x + 20, y + frameHeight);
			flammes.loadGraphic(ImgFlamme, true, false, 40, 80);
			flammes.addAnimation("flammes",  [0, 1, 2, 3, 4], 5, false);
			loadGraphic(ImgTourelle, true, false, 80, 40);
			addAnimation("default",  [0, 1, 2], 10, true);!
			timer.start(3, 0, activate_burst);
			
			/* Pré-écriture de l'anim de flamme, à réutiliser.
				this.loadGraphic(ImgFlamme, true, false, 40, 80);
				this.addAnimation("burn",  [0, 1, 2,3,4,5], 5, true);
			*/
			play("default");
			FlxG.state.add(flammes);
			// Gestion de la flamme
		}
		
		override public function update():void 
		{
			if (FlxCollision.pixelPerfectCheck(FlxG.player, flammes))
				FlxG.player.die_motherfucker(0);
		}
		
		public function activate_burst(timer:FlxTimer):void{
			flammes.play("flammes");
		}
	}
}