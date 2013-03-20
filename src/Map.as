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
		public var tremplins:FlxGroup = new FlxGroup();										// TREMPLINS
		public var boss:FlxGroup = new FlxGroup();											// VAGUES
		public var souffleries:FlxGroup = new FlxGroup();									// SOUFFLERIES
		public var soucoupes:FlxGroup = new FlxGroup();										// SOUCOUPES
		public var triggers:FlxGroup = new FlxGroup();										// TRIGGERS
		public var checkpoints:FlxGroup = new FlxGroup();									// CHECKPOINTS
		public var id:int = 0;																// NIVEAU
		public var DustbinBieber:FlxGroup = new FlxGroup();									// POUBELLES
        public var tile:FlxTilemapExt = new FlxTilemapExt();								// TILES
        public var near:FlxTilemap = new FlxTilemap();										// NEAR
        public var clouds:FlxTilemap = new FlxTilemap();									// NEAR
        public var middle:FlxTilemap = new FlxTilemap();									// MIDDLE
        public var far:FlxTilemap = new FlxTilemap();										// FAR
        public var fond:FlxTilemap = new FlxTilemap();										// FOND
		public var loaded:Boolean = false;													// MAP CHARGEE?
		public var player:Player;															// JIMI
		public var cam:Cam;																	// CAMERA
		public var offsety:int = 200;														// DEPASSEMENT VERTICAL AUTORISE
        [Embed(source = '../assets/gfx/misc/aith_tiles.png')] public var MapTiles:Class;
        [Embed(source = '../assets/level/exterieur/background_exterieur_middle.png')] public var BgMiddle:Class;
        [Embed(source = '../assets/level/exterieur/background_exterieur_near.png')] public var BgNear:Class;
        [Embed(source = '../assets/level/exterieur/background_exterieur_far.png')] public var BgFar:Class;
        [Embed(source = '../assets/level/exterieur/background_exterieur_clouds.png')] public var BgClouds:Class;
        [Embed(source = '../assets/level/exterieur/fond.png')] public var BgFond:Class;
        [Embed(source = '../assets/gfx/gameplay/sol_destructible.png')] public var ImgDesSol:Class;
        [Embed(source = '../assets/gfx/misc/back_fail.png')] public var BgFail:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_rouge_80.png')] public var Tremplin80_rouge:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_jaune_80.png')] public var Tremplin80_jaune:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_bleu_80.png')] public var Tremplin80_bleu:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_rouge_120.png')] public var Tremplin120_rouge:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_rouge_120.png')] public var Tremplin120_jaune:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_bleu_120.png')] public var Tremplin120_bleu:Class;
		public var background:Background;
		public var largeur:int = 30000;														// LARGEUR DE LA MAP
		public var mapfile:Class = null;
		
		/**
		 * FORMAT TXT
		 * 
		 * LEVEL
		 * MAP.TMX
		 * 
		 */
		
		public function Map(map:Class) 
		{
			mapfile = map;
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
			
				// RECUPERATION DES TILES CSV
				var csv:String = tmx.getLayer('Sol').toCsv(tmx.getTileSet('aith_tiles'));
				var csv3:String = tmx.getLayer('Back_fond').toCsv(tmx.getTileSet('fond'));
				// TODO CALQUES D'OBJETS
				fond.loadMap(csv3, BgFond, 40, 40);
				tile.loadMap(csv, MapTiles, 40, 40);
				FlxG.state.add(fond);
				FlxG.state.add(tile);
				FlxG.tilemap = tile;
			// PARSING DES OBJETS
			var group:TmxObjectGroup = tmx.getObjectGroup('Gameplay');
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
					case "Troika":
						shootemup.add (new ShootemUp(object.x, object.y));
						break;
					case "Boss":
						boss.add (new Boss_dino(object.x, object.y));
						break;
					case "Checkpoints":
						checkpoints.add (new Checkpoints(object.x, object.y));
						break;
					case "Trigger":
						triggers.add(new Trigger(object.x, object.y));
						break;
					case "Piques":
						if (object.custom != null)
							piques.add (new Piques(object.x, object.y, object.custom["orientation"]));
						else
							piques.add (new Piques(object.x, object.y, "haut"));
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
					case "Tremplin80":
						var tremplin80:FlxSprite = new FlxSprite(object.x, object.y);
						if (object.custom != null) {
							switch (object.custom["color"]) {
								case "1":
									tremplin80.loadGraphic(Tremplin80_bleu);
									break;
								case "2":
									tremplin80.loadGraphic(Tremplin80_jaune);
									break;
								case "3":
									tremplin80.loadGraphic(Tremplin80_rouge);
									break;
							}
						}
						tremplin80.immovable = true;
						tremplin80.y -= tremplin80.frameHeight;
						tremplins.add(tremplin80);
						break;
					case "Tremplin120":
						var tremplin120:FlxSprite = new FlxSprite(object.x, object.y);
						if (object.custom != null) {
							switch (object.custom["color"]) {
								case "1":
									tremplin80.loadGraphic(Tremplin120_bleu);
									break;
								case "2":
									tremplin80.loadGraphic(Tremplin120_jaune);
									break;
								case "3":
									tremplin80.loadGraphic(Tremplin120_rouge);
									break;
							}
						}
						tremplin120.y -= tremplin120.frameHeight;
						tremplin120.immovable = true;
						tremplins.add(tremplin120);
						break;
				}
			}
			FlxG.state.add(item);
			FlxG.state.add(destructible);
			FlxG.state.add(tremplins);
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
			player = new Player(50, 700 - 40);
			FlxG.player = player;
			cam = new Cam(player);
			FlxG.state.add(player);
			FlxG.state.add(cam);
			FlxG.worldBounds = new FlxRect(0, 0, largeur, 600 + offsety);
			FlxG.camera.setBounds(0, 0, largeur, 600 + offsety);
			FlxG.camera.follow(cam);
		}
		
		// RECHARGE OBJETS POUR CHECKPOINTS
		public function reload_map():void {
			var fileContent:String = new mapfile();
			var lignes:Array = fileContent.split('\n'); 
			if (lignes != null) {
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE,onTmxReLoaded);
				loader.load(new	URLRequest(lignes[2]));
			}
		}
		
		// RESET ASCENCEUR ET AUTRES CONNERIES A FAIRE
		public function onTmxReLoaded(e:Event):void {
			var xml:XML = new XML(e.target.data);
			var tmx:TmxMap = new TmxMap(xml);
			var group:TmxObjectGroup = tmx.getObjectGroup('Gameplay');
			
			shootemup.clear();
			ascenceurs.clear();
			/*item.clear();
			ens.clear();
			DustbinBieber.clear();
			destructible.clear();*/
			
			for each(var object:TmxObject in group.objects) {
				switch(object.type) {
					case "Ascenceur":
						ascenceurs.add (new Ascenceur(object.x, object.y));
						break;
					case "Troika":
						shootemup.add (new ShootemUp(object.x, object.y));
						break;
						case "Tube":
						item.add (new TubeVert(object.x, object.y, 1,0));
						break;
				/*	case "GrosTube":
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
					case "Poubelles":
						DustbinBieber.add (new Poubelle(object.x, object.y));
						break;
					case "Des_sol":
						var ground:FlxSprite = new FlxSprite(object.x, object.y, ImgDesSol);
						ground.immovable = true;
						destructible.add(ground);
						break;*/
				}
			}
		}
	}

}