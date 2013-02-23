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
		
		public function Poubelle(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgDustbinBieber);
			y -= frameHeight -40;
		}
		
	}

}