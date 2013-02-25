package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * Ascenceur
	 * @author ...
	 */
	public class ShootemUp extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/gameplay/troika.png')] protected var ImgShootemUp:Class;
		public var speed:int = 100;						// VITESSE DEPLACEMENT ASCENCEUR
		public var blocked:Boolean = false;				// JOUEUR BLOQUE?
		public var unlock:Boolean = false;				// JOUEUR BLOQUE?
		
		public function ShootemUp(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgShootemUp);
			immovable = true;
		}
		
		override public function update():void {
			// BLOQUE LE JOUEUR
			if ((FlxG.player != null) && (x <= FlxG.player.x) && (FlxG.overlap(FlxG.player, this)) && (unlock == false)) {
				blocked = true;
			}
			FlxG.collide(FlxG.player, this, up_and_down);
		}
		
		
		// GESTIONS DU DEPLACEMENT SUR ASCENCEUR
		public function up_and_down(obj1:FlxObject, obj2:FlxObject):void {
			if (blocked == true) {
				FlxG.player.x = x;
				FlxG.player.velocity.x = 0;
				FlxG.player.velocity.y = 0;
				
				// DEPLACEMENT BLOQUE
				if (FlxG.player.gravity > 800) {
					y += speed * FlxG.elapsed;
					FlxG.player.y += speed * FlxG.elapsed;
				}
				else {
					y -= speed * FlxG.elapsed;
					FlxG.player.y -= speed * FlxG.elapsed;
				}
				// GESTIONS COLLISIONS TRIGGERS/ASCENCEURS
				for each (var item:Trigger in FlxG.map.triggers.members) {
					if ((item != null) && (item.x == this.x + 80) && (item.y == Math.round(this.y))) {
						unlock = true;
						y = item.y;
						delock(item);
					}
				}
			}
		}
		
		// DEBLOQUE ASCENCEUR
		public function delock(trig:Trigger):void {
			blocked = false;
			FlxG.player.velocity.x = FlxG.player.init_speed;
		}
		
	}

}