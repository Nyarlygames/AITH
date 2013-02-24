package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import FlxTilemapExt;
	import org.flixel.FlxG;
	/**
	 * POUBELLES
	 * @author 
	 */
	public class Poubelle extends FlxSprite
	{
		[Embed(source = '../assets/gfx/DustbinBieber.png')] protected var ImgDustbinBieber:Class;
		public var poids:int = 500;									// Gravité (vitesse?) requise pour la déplacer
		public var vitesse:int = 250;								// Vitesse produite sur le joueur (?) NYI
		public var cur_tile:int = 0;								// Type tile courante
		public var player:Player = null;
		
		public function Poubelle(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgDustbinBieber);
			y -= frameHeight -40;
		}
		
		override public function update():void {
			if (player != null) {
				// POUBELLE RIEN
				if ((FlxG.tilemap.getTile(Math.floor(player.push.x / 40) +2, Math.round(player.push.y / 40) +1)) == 0) {
					player.push.x = player.x + player.push.frameWidth;
					player.push.y = player.y;
					player.push.velocity.x = player.velocity.x;
				}
				//ARRET POUBELLE
				else {
					player.push.velocity.x = 0;
					player.velocity.x = 0;
					player.push.immovable = true;
					if (player.gravity > 500) {
						player.pushing = false;
					}
				}
				if (player.pushing == false) {
					kill();
					destroy();
					FlxG.state.remove(this);
					FlxG.player.velocity.x = FlxG.player.init_speed;
				}
			}	
		}
	}

}