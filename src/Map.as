package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
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
		public var tourelles:FlxGroup = new FlxGroup();											// TOURELLES
		public var item:FlxGroup = new FlxGroup();											// TUBES VERTS
		public var piques:FlxGroup = new FlxGroup();										// PIQUES
		public var destructible:FlxGroup = new FlxGroup();									// SOLS DESTRUCTIBLES
		public var ascenceurs:FlxGroup = new FlxGroup();									// ASCENCEURS
		public var shootemup:FlxGroup = new FlxGroup();										// SHOOTEMUP
		public var tremplins:FlxGroup = new FlxGroup();										// TREMPLINS
		public var tremplin_haut:FlxGroup = new FlxGroup();									// HAUT
		public var tremplin_bas:FlxGroup = new FlxGroup();									// BAS
		public var boss:FlxGroup = new FlxGroup();											// VAGUES
		public var souffleries:FlxGroup = new FlxGroup();									// SOUFFLERIES
		public var soucoupes:FlxGroup = new FlxGroup();										// SOUCOUPES
		public var triggers:FlxGroup = new FlxGroup();										// FIN DE NIVEAU
		public var fin:FlxGroup = new FlxGroup();										// TRIGGERS
		public var checkpoints:FlxGroup = new FlxGroup();									// CHECKPOINTS
		public var id:int = 0;																// NIVEAU
		public var DustbinBieber:FlxGroup = new FlxGroup();									// POUBELLES
        public var tile:FlxTilemapExt = new FlxTilemapExt();								// TILES
        public var fond:FlxTilemap = new FlxTilemap();										// FOND
		public var batiments_near:FlxGroup = new FlxGroup();								// BG NEAR
		public var batiments_middle:FlxGroup = new FlxGroup();								// BG FAR
		public var batiments_far:FlxGroup = new FlxGroup();								// BG MIDDLE
		public var loaded:Boolean = false;													// MAP CHARGEE?
		public var player:Player;															// JIMI
		public var cam:Cam;																	// CAMERA
		public var offsety:int = 200;														// DEPASSEMENT VERTICAL AUTORISE
        [Embed(source = '../assets/gfx/misc/aith_tiles.png')] public var MapTiles:Class;
        [Embed(source = '../assets/level/exterieur/fond.png')] public var BgFond:Class;
        [Embed(source = '../assets/gfx/gameplay/sol_destructible.png')] public var ImgDesSol:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_near_01.png')] public var ImgNear1:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_near_02.png')] public var ImgNear2:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_near_03.png')] public var ImgNear3:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_near_04.png')] public var ImgNear4:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_near_05.png')] public var ImgNear5:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_near_06.png')] public var ImgNear6:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_near_07.png')] public var ImgNear7:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_near_08.png')] public var ImgNear8:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_near_09.png')] public var ImgNear9:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_01.png')] public var ImgMiddle1:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_02.png')] public var ImgMiddle2:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_03.png')] public var ImgMiddle3:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_04.png')] public var ImgMiddle4:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_05.png')] public var ImgMiddle5:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_06.png')] public var ImgMiddle6:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_07.png')] public var ImgMiddle7:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_08.png')] public var ImgMiddle8:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_09.png')] public var ImgMiddle9:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_10.png')] public var ImgMiddle10:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_11.png')] public var ImgMiddle11:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_12.png')] public var ImgMiddle12:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_13.png')] public var ImgMiddle13:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_14.png')] public var ImgMiddle14:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_15.png')] public var ImgMiddle15:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_16.png')] public var ImgMiddle16:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_17.png')] public var ImgMiddle17:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_middle_18.png')] public var ImgMiddle18:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_far_01.png')] public var ImgFar1:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_far_02.png')] public var ImgFar2:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_far_03.png')] public var ImgFar3:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_far_04.png')] public var ImgFar4:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_far_05.png')] public var ImgFar5:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_rouge_80.png')] public var Tremplin80_rouge:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_jaune_80.png')] public var Tremplin80_jaune:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_bleu_80.png')] public var Tremplin80_bleu:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_rouge_120.png')] public var Tremplin120_rouge:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_rouge_120.png')] public var Tremplin120_jaune:Class;
        [Embed(source = '../assets/gfx/gameplay/tremplin_bleu_120.png')] public var Tremplin120_bleu:Class;
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
			
			/* FAR */
			var group_far:TmxObjectGroup = tmx.getObjectGroup('Back_far');
			for each(var object_far:TmxObject in group_far.objects) {
				var bat_far:FlxSprite = new FlxSprite(object_far.x, object_far.y);
				switch(object_far.gid) {
					case 47 :
						bat_far.loadGraphic(ImgFar2);
						break;
					case 48 :
						bat_far.loadGraphic(ImgFar3);
						break;
					case 49 :
						bat_far.loadGraphic(ImgFar4);
						break;
					case 50 :
						bat_far.loadGraphic(ImgFar5);
						break;
				}
				bat_far.y -= bat_far.frameHeight
				bat_far.scrollFactor = new FlxPoint(0.1, 0.1);
				batiments_far.add(bat_far);
			}
			FlxG.state.add(batiments_far);
			
			/* MIDDLE */
			var group_middle:TmxObjectGroup = tmx.getObjectGroup('Back_middle');
			for each(var object_middle:TmxObject in group_middle.objects) {
				var bat_middle:FlxSprite = new FlxSprite(object_middle.x, object_middle.y);
				switch(object_middle.gid) {
					case 20 :
						bat_middle.loadGraphic(ImgMiddle2);
						break;
					case 21 :
						bat_middle.loadGraphic(ImgMiddle3);
						break;
					case 22 :
						bat_middle.loadGraphic(ImgMiddle4);
						break;
					case 23 :
						bat_middle.loadGraphic(ImgMiddle5);
						break;
					case 24 :
						bat_middle.loadGraphic(ImgMiddle6);
						break;
					case 25 :
						bat_middle.loadGraphic(ImgMiddle7);
						break;
					case 26 :
						bat_middle.loadGraphic(ImgMiddle8);
						break;
					case 27 :
						bat_middle.loadGraphic(ImgMiddle9);
						break;
					case 28 :
						bat_middle.loadGraphic(ImgMiddle10);
						break;
					case 29 :
						bat_middle.loadGraphic(ImgMiddle11);
						break;
					case 30 :
						bat_middle.loadGraphic(ImgMiddle12);
						break;
					case 31 :
						bat_middle.loadGraphic(ImgMiddle13);
						break;
					case 32 :
						bat_middle.loadGraphic(ImgMiddle14);
						break;
					case 33 :
						bat_middle.loadGraphic(ImgMiddle15);
						break;
					case 34 :
						bat_middle.loadGraphic(ImgMiddle16);
						break;
					case 35 :
						bat_middle.loadGraphic(ImgMiddle17);
						break;
					case 36 :
						bat_middle.loadGraphic(ImgMiddle18);
						break;
				}
				bat_middle.y -= bat_middle.frameHeight
				bat_middle.scrollFactor = new FlxPoint(0.5, 0.5);
				batiments_middle.add(bat_middle);
			}
			FlxG.state.add(batiments_middle);
			
			/* NEAR */
			var group_near:TmxObjectGroup = tmx.getObjectGroup('Back_near');
			for each(var object_near:TmxObject in group_near.objects) {
				var bat_near:FlxSprite = new FlxSprite(object_near.x, object_near.y);
				switch(object_near.gid) {
					case 38 :
						bat_near.loadGraphic(ImgNear2);
						break;
					case 39 :
						bat_near.loadGraphic(ImgNear3);
						break;
					case 40 :
						bat_near.loadGraphic(ImgNear4);
						break;
					case 41 :
						bat_near.loadGraphic(ImgNear5);
						break;
					case 42 :
						bat_near.loadGraphic(ImgNear6);
						break;
					case 43 :
						bat_near.loadGraphic(ImgNear7);
						break;
					case 44 :
						bat_near.loadGraphic(ImgNear8);
						break;
					case 45 :
						bat_near.loadGraphic(ImgNear9);
						break;
				}
				bat_near.y -= bat_near.frameHeight
				bat_near.scrollFactor = new FlxPoint(1, 1);
				batiments_near.add(bat_near);
			}
			FlxG.state.add(batiments_near);
			
			FlxG.state.add(tile);
			FlxG.tilemap = tile;
			
			// PARSING DES OBJETS
			var group:TmxObjectGroup = tmx.getObjectGroup('Gameplay');
			for each(var object:TmxObject in group.objects) {
				switch(object.type) {
					case "tremplin":
						if (object.custom != null) {
							var tremp:FlxSprite = new FlxSprite(object.x, object.y);
							tremp.visible = false;
							tremplin_haut.add(tremp);
						}
						else {
							var tremp_bas:FlxSprite = new FlxSprite(object.x, object.y);
							tremp_bas.visible = false;
							tremplin_bas.add(tremp_bas);
						}
						break;
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
					case "Tourelle":
						tourelles.add (new Tourelle(object.x, object.y));
						break;
					/*case "AlienTireur":
						ens.add (new AlienTireur(object.x, object.y));
						break;*/
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
					case "FinNiveau":
						fin.add (new FinNiveau(object.x, object.y));
						break;
					case "Soufflerie":
						if (object.custom != null)
							souffleries.add (new Soufflerie(object.x, object.y, object.custom["angle"]));
						else
							souffleries.add (new Soufflerie(object.x, object.y, 0));
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
			FlxG.state.add(tourelles);
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
		
		/* TODO
		 * SAUVEGUARDE DES GROUPES AU CHARGEMENT POUR EVITER DE RECHARGER
		 */
		
		// RESET ASCENCEUR ET AUTRES CONNERIES A FAIRE
		public function onTmxReLoaded(e:Event):void {
			var xml:XML = new XML(e.target.data);
			var tmx:TmxMap = new TmxMap(xml);
			var group:TmxObjectGroup = tmx.getObjectGroup('Gameplay');
			
			ascenceurs.clear();
			item.clear();
			ens.clear();
			DustbinBieber.clear();
			destructible.clear();
			tourelles.clear();
			
			for each(var object:TmxObject in group.objects) {
				switch(object.type) {
					case "Ascenceur":
						ascenceurs.add (new Ascenceur(object.x, object.y));
						break;
					case "Des_sol":
						var ground:FlxSprite = new FlxSprite(object.x, object.y, ImgDesSol);
						ground.immovable = true;
						destructible.add(ground);
						break;
					case "Alien":
						ens.add (new AlienNormal(object.x, object.y));
						break;
					case "AlienVert":
						ens.add (new AlienVert(object.x, object.y));
						break;
					case "AlienHorizontal":
						ens.add (new AlienHorizontal(object.x, object.y));
						break;
					case "Poubelles":
						DustbinBieber.add (new Poubelle(object.x, object.y));
						break;
					case "Tourelle":
						tourelles.add (new Tourelle(object.x, object.y));
						break;						
					case "Tube":
						item.add (new TubeVert(object.x, object.y, 1,0));
						break;
					case "GrosTube":
						item.add (new TubeVert(object.x, object.y, 5,1));
						break;
				}
			}
		}
	}

}