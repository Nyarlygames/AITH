package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * User interface
	 * @author ...
	 */
	public class UI extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/gameplay/petit_tube.png')] protected var ImgTube:Class;
		[Embed(source = '../assets/gfx/ui/choix-tiles.png')] 	 	protected var ImgChoixTexte:Class;
		[Embed(source = '../assets/gfx/ui/tube-count.png')] 	 	protected var ImgCountTube:Class;
		
		[Embed(source = '../assets/fonts/Urban_slick.ttf',	fontFamily = "slick", embedAsCFF = "false")] protected var	Font:Class;
		
		public var tube_count:FlxText;
		public static var choixTiles:FlxSprite;
		public static var backCount:FlxSprite;
		
		public function UI() 
		{
			super(20, 10, ImgCountTube);
			scrollFactor = new FlxPoint(0, 0);
			tube_count = new FlxText(frameWidth, 200, 200, "0");
			tube_count.setFormat("onedalism", 22, 0x044071);
			FlxG.state.add(tube_count);
			tube_count.scrollFactor = new FlxPoint(0, 0);
			
			/*	Texte des menus */
			choixTiles = new FlxSprite(447, 50, ImgChoixTexte);
			choixTiles.loadGraphic(ImgChoixTexte, true, false, 447, 50);
			choixTiles.addAnimation("univers", [0], 10, true);
			choixTiles.addAnimation("niveaux", [1], 10, true);
			choixTiles.addAnimation("score", [2], 10, true);
			/*	Texte des menus */
		}
		
		override public function update():void 
		{
			//if ((tube_count != null) && (tube_count.text != null))
			//tube_count.text = FlxG.score.toString();
		}
		
	}

}