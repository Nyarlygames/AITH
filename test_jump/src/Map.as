package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import net.pixelpracht.tmx.TmxMap;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	import net.pixelpracht.tmx.TmxPropertySet;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	
	/**
	 * Maps
	 * @author ...
	 */
	public class Map 
	{
		
		public var ens:FlxGroup = new FlxGroup();											// ALIENS
		public var item:FlxGroup = new FlxGroup();											// TUBES VERTS
		public var piques:FlxGroup = new FlxGroup();										// PIQUES
		public var destructible:FlxGroup = new FlxGroup();									// SOLS DESTRUCTIBLES
		public var ascenceurs:FlxGroup = new FlxGroup();									// ASCENCEURS
		public var shootemup:FlxGroup = new FlxGroup();										// SHOOTEMUP
		public var boss:FlxGroup = new FlxGroup();											// VAGUES
		public var souffleries:FlxGroup = new FlxGroup();									// SOUFFLERIES
		public var soucoupes:FlxGroup = new FlxGroup();										// SOUCOUPES
		public var triggers:FlxGroup = new FlxGroup();										// TRIGGERS
		public var checkpoints:FlxGroup = new FlxGroup();									// CHECKPOINTS
		public var id:int = 0;																// NIVEAU
		public var DustbinBieber:FlxGroup = new FlxGroup();									// POUBELLES
        public var tile:FlxTilemapExt = new FlxTilemapExt();								// TILES
		public var loaded:Boolean = false;													// MAP CHARGEE?
		public var player:Player;															// JIMI
		public var cam:Cam;																	// CAMERA
		public var offsety:int = 200;														// DEPASSEMENT VERTICAL AUTORISE
        [Embed(source = '../assets/gfx/misc/aith_tiles.png')] public var MapTiles:Class;
        [Embed(source = '../assets/gfx/gameplay/destructible.png')] public var ImgDesSol:Class;
		public var background:Background;
		public var largeur:int = 30000;														// LARGEUR DE LA MAP
		
		/**
		 * FORMAT TXT
		 * 
		 * LEVEL
		 * MAP.TMX
		 * 
		 */
		
		public function Map(map:Class) 
		{
			// PARCOURS LE .TXT
			var fileContent:String = new map();
			var lignes:Array = fileContent.split('\n'); 
			if (lignes != null) {
				id = lignes[0];
				largeur = lignes[1];
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE,onTmxLoaded);
				loader.load(new	URLRequest(lignes[2]));
			}
			FlxG.map = this;
		}
		
		// PARCOURS LE TMX
		public function onTmxLoaded(e:Event):void {
			
			var xml:XML = new XML(e.target.data);
			var tmx:TmxMap = new TmxMap(xml);
			
			// TEMPORAIRE EN ATTENDANT LE VRAI SOL
			if ((id == 1) || (id == 3)){
				background = new Background(id);
				// RECUPERATION DES TILES CSV
				var csv:String = tmx.getLayer('Tile').toCsv(tmx.getTileSet('aith_tiles'));
				tile.loadMap(csv, MapTiles, 40, 40);
				FlxG.state.add(tile);
				FlxG.tilemap = tile;
			}
			else {
				// RECUPERATION DES TILES CSV
				var csv2:String = tmx.getLayer('Tile').toCsv(tmx.getTileSet('aith_tiles'));
				tile.loadMap(csv2, MapTiles, 40, 40);
				FlxG.state.add(tile);
				FlxG.tilemap = tile;
				background = new Background(id);
			}
			
			
			// PARSING DES OBJETS
			var group:TmxObjectGroup = tmx.getObjectGroup('Objs');
			for each(var object:TmxObject in group.objects) {
				switch(object.type) {
					case "Tube":
						item.add (new TubeVert(object.x, object.y, 1,0));
						break;
					case "GrosTube":
						item.add (new TubeVert(object.x, object.y, 5,1));
						break;
					case "Alien":
						ens.add (new AlienNormal(object.x, object.y));
						break;
					case "AlienVert":
						ens.add (new AlienVert(object.x, object.y));
						break;
					case "AlienTireur":
						ens.add (new AlienTireur(object.x, object.y));
						break;
					case "AlienHorizontal":
						ens.add (new AlienHorizontal(object.x, object.y));
						break;
					case "Ascenceur":
						ascenceurs.add (new Ascenceur(object.x, object.y));
						break;
					case "ShootemUp":
						shootemup.add (new ShootemUp(object.x, object.y));
						break;
					case "Boss":
						boss.add (new Boss(object.x, object.y));
						break;
					case "Checkpoints":
						checkpoints.add (new Checkpoints(object.x, object.y));
						break;
					case "Trigger":
						triggers.add(new Trigger(object.x, object.y));
						break;
					case "Piques":
						piques.add (new Piques(object.x, object.y));
						break;
					case "Poubelles":
						DustbinBieber.add (new Poubelle(object.x, object.y));
						break;
					case "Soucoupe":
						soucoupes.add (new Soucoupe(object.x, object.y));
						break;
					case "Soufflerie":
						if (object.custom != null)
							souffleries.add (new Soufflerie(object.x, object.y, object.custom["angle"]));
						else
							souffleries.add (new Soufflerie(object.x, object.y, 90));
						break;
					case "Des_sol":
						var ground:FlxSprite = new FlxSprite(object.x, object.y, ImgDesSol);
						ground.immovable = true;
						destructible.add(ground);
						break;
				}
			}
			FlxG.state.add(item);
			FlxG.state.add(destructible);
			FlxG.state.add(ascenceurs);
			FlxG.state.add(triggers);
			FlxG.state.add(piques);
			FlxG.state.add(DustbinBieber);
			FlxG.state.add(shootemup);
			FlxG.state.add(souffleries);
			FlxG.state.add(soucoupes);
			FlxG.state.add(ens);
			FlxG.state.add(checkpoints);
			// CHARGEMENT FINIT
			loaded = true;
			// AJOUT PLAYER ET CAM
			player = new Player(50, 800 - 40);
			FlxG.player = player;
			cam = new Cam(player);
			FlxG.state.add(player);
			FlxG.state.add(player.g);
			FlxG.state.add(player.v);
			FlxG.state.add(cam);
			FlxG.worldBounds = new FlxRect(0, 0, largeur, 600 + offsety);
			FlxG.camera.setBounds(0, 0, largeur, 600 + offsety);
			FlxG.camera.follow(cam);
		}
	}

}