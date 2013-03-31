package  
{
	import adobe.utils.CustomActions;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxSound;
	import org.flixel.FlxSound;
	import FlxTilemapExt;
	import org.flixel.FlxG;
	/**
	 * POUBELLES
	 * @author 
	 */
	public class Poubelle extends FlxSprite
	{
		[Embed(source = '../assets/gfx/gameplay/dustbin_bieber_visible.png')]	protected var ImgDustbinBieber:Class;
		[Embed(source = "../assets/sfx/gameplay/Poubelle_Collision.mp3")] 		public var sfxPushed:Class;
		[Embed(source = "../assets/sfx/gameplay/Poubelle_Destruction.mp3")]		public var sfxPushing:Class;
		
		public var soundPushing:FlxSound = new FlxSound();
		public var soundPushed:FlxSound = new FlxSound();
		
		public var poids:int = 500;									// Gravité (vitesse?) requise pour la déplacer
		public var vitesse:int = 250;								// Vitesse produite sur le joueur (?) NYI
		public var cur_tile:int = 0;								// Type tile courante
		public var player:Player = null;
		
		public function Poubelle(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgDustbinBieber);
			soundPushing.loadEmbedded(sfxPushing);
			soundPushed.loadEmbedded(sfxPushed);
			immovable = false;
		}
		
		override public function update():void {
			
			if ((player != null) && (player.pushing == true)) {
				// POUBELLE RIEN
				if ((FlxG.tilemap.getTile(Math.floor(x / 40) +2, Math.round(y / 40) +1)) == 0) {
					x = player.x + player.push.frameWidth;
					velocity.x = player.velocity.x;
				}
				//	destruction();
				// POUBELLE VIDE
				if (FlxG.tilemap.getTile(Math.floor(x / 40), Math.round(y / 40) +2) == 0) {
					y += frameHeight;
					velocity.x = 0;
					FlxG.player.pushing = false;
					immovable = true;
				}
				if (FlxG.player.jauge.frame >= 5) {
					destruction();
					FlxG.player.pushing = false;
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