package  
{
	import flash.utils.Timer;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTimer;
	
	/**
	 * Niveau
	 * @author ...
	 */
	public class Play extends FlxState 
	{
		[Embed(source = '../assets/gfx/gauche.png')] public var ImgGauche:Class;
		public var timer:Counter = new Counter();
		public var gauche:Gauche;
		public var player:Player;
		public var choices:Choix;
		public var cursor:Cursor = new Cursor();
		public var droite:Droite;
		public var transition:FlxTimer;
		public var select:FlxSprite;
		public var isMoving:Boolean = false;
		public var background:Background = new Background();
		public var dragons:FlxGroup = new FlxGroup();
		public var dragon:Dragons = new Dragons(FlxG.width / 2 - 100, FlxG.height / 2);
		
		public function Play() 
		{
			add(background);
			gauche = new Gauche(ImgGauche);
			add(timer);
			add(timer.timer);
			droite =  new Droite(cursor);
			choices = new Choix(droite);
			add(droite.bg);
			add(droite);
			add(gauche);
			player = new Player(0,FlxG.height - gauche.height, gauche, droite);
			add(player);
			add(choices.choice);
			dragons.add(dragon);
			add(dragons);
			add(cursor);
			select = new FlxSprite(FlxG.width / 2, 0).makeGraphic(choices.choice.frameWidth, (choices.choice.frameHeight + 10)/4 , 0xaa16BE0E, true);
			add(select);
		}
		
		
		override public function update():void {
			
			super.update();
			
			isMoving = false;
			
			if ((timer.delay.secondsRemaining == -1) && (timer.count < 10)) {
				timer.count++;
				timer.delay.reset(10000 - timer.count * 1000);
				select.makeGraphic(80, 60, 0xaa16BE0E, true);
			}
			else if ((timer.delay.secondsRemaining == 0) && (isMoving == false))  {
				movescreen();
				transition = new FlxTimer();
				transition.time = 1;
				transition.start();
				select.makeGraphic(80, 60, 0xaaA42882, true); 
				isMoving = true;
			}
			if (droite.hasMoved == true) {
				player.gauche = new Gauche(droite.getImg(cursor.pos));
 				gauche.exists = false;
				gauche.destroy();
				gauche = player.gauche;
				remove(droite);
				droite.destroy();
				droite = new Droite(cursor);
				droite.hasMoved = false;
				add(gauche);
				add(droite);
			}
			
			if (FlxCollision.pixelPerfectCheck(player, dragon)) {
				dragon.on_hit();
			}
			/*if ((isMoving == false) && (transition != null)) {
				gauche.exists = false;
			}*/
		}
		
		public function movescreen():void {
			var reset:FlxPoint = new FlxPoint();
			var leave:FlxPoint = new FlxPoint();
			var speed:int = 100;
			reset.x = 0;
			reset.y = FlxG.height - droite.frameHeight/2;
			leave.x = -gauche.frameWidth;
			leave.y = FlxG.height - gauche.frameHeight /2;
			FlxVelocity.moveTowardsPoint(droite, reset, 0, 2000);
			FlxVelocity.moveTowardsPoint(dragon, reset, 0, 2000);
			FlxVelocity.moveTowardsPoint(gauche, leave, 0, 2000);
		}
		
		
	}

}