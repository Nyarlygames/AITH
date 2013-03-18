package  
{
	import adobe.utils.CustomActions;
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
		[Embed(source = '../assets/gfx/gameplay/dustbin_bieber_visible.png')] protected var ImgDustbinBieber:Class;
		public var poids:int = 500;									// Gravité (vitesse?) requise pour la déplacer
		public var vitesse:int = 250;								// Vitesse produite sur le joueur (?) NYI
		public var cur_tile:int = 0;								// Type tile courante
		public var player:Player = null;
		
		public function Poubelle(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgDustbinBieber);
			immovable = true;
		}
		
		override public function update():void {
			if ((player != null) ) {
				// POUBELLE RIEN
				if ((FlxG.tilemap.getTile(Math.floor(x / 40) +2, Math.round(y / 40) +1)) == 0) {
					velocity.x = player.velocity.x;
				}
				//ARRET POUBELLE
				else {
					velocity.x = 0;
					player.velocity.x = 0;
					if (player.gravity > 500) {
						destruction();
					}
				}
				
				// POUBELLE VIDE
				if (FlxG.tilemap.getTile(Math.floor(x / 40), Math.round(y / 40) +2) == 0) {
					y += frameHeight;
					velocity.x = 0;
				}
			}	
		}
		
		public function destruction():void {
			kill();
			destroy();
			FlxG.state.remove(this);
		}
	}

}