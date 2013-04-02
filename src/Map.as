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
		public var ens:FlxGroup				= new FlxGroup();								// ALIENS
		public var tourelles:FlxGroup 		= new FlxGroup();								// TOURELLES
		public var item:FlxGroup 			= new FlxGroup();								// TUBES VERTS
		public var piques:FlxGroup 			= new FlxGroup();								// PIQUES
		public var destructible:FlxGroup 	= new FlxGroup();								// SOLS DESTRUCTIBLES
		public var ascenceurs:FlxGroup 		= new FlxGroup();								// ASCENCEURS
		public var shootemup:FlxGroup 		= new FlxGroup();								// SHOOTEMUP
		public var tremplins:FlxGroup 		= new FlxGroup();								// TREMPLINS
		public var tremplin_haut:FlxGroup 	= new FlxGroup();								// HAUT
		public var tremplin_bas:FlxGroup 	= new FlxGroup();								// BAS
		public var backflip:FlxGroup 		= new FlxGroup();								// DEBUT BACKFLIP
		public var endBackflip:FlxGroup 	= new FlxGroup();								// END BACKFLIP
		public var boss:FlxGroup			= new FlxGroup();								// VAGUES
		public var souffleries:FlxGroup 	= new FlxGroup();								// SOUFFLERIES
		public var soucoupes:FlxGroup 		= new FlxGroup();								// SOUCOUPES
		public var triggers:FlxGroup		= new FlxGroup();								// FIN DE NIVEAU
		public var fin:FlxGroup 			= new FlxGroup();								// TRIGGERS ALLO QUOI?
		public var checkpoints:FlxGroup 	= new FlxGroup();								// CHECKPOINTS
		public var id:int = 0;																// NIVEAU
		public var DustbinBieber:FlxGroup 		= new FlxGroup();							// POUBELLES
        public var tile:FlxTilemapExt 			= new FlxTilemapExt();						// TILES
        public var fond:FlxTilemap 				= new FlxTilemap();							// FOND
		public var batiments_near_vaisseau:FlxGroup		= new FlxGroup();							// BG NEAR
		public var batiments_near:FlxGroup		= new FlxGroup();							// BG NEAR
		public var batiments_fond:FlxGroup		= new FlxGroup();							// BG FOND VAISSEAU
		public var clouds:FlxGroup 				= new FlxGroup();							// CLOUDS
		public var batiments_middle_vaisseau:FlxGroup	= new FlxGroup();							// BG FAR
		public var batiments_middle:FlxGroup	= new FlxGroup();							// BG FAR
		public var batiments_far_vaisseau:FlxGroup 		= new FlxGroup();							// BG MIDDLE
		public var batiments_far:FlxGroup 		= new FlxGroup();							// BG MIDDLE
		public var loaded:Boolean 				= false;									// MAP CHARGEE?
		public var finishedload:Boolean = false;											// CHARGEMENT FINIT (POUR TUTO)
		public var player:Player;															// JIMI
		public var cam:Cam;																	// CAMERA
		public var offsety:int = 200;														// DEPASSEMENT VERTICAL AUTORISE

		
		public var ens_save:FlxGroup = new FlxGroup();											// ALIENS
		public var grounds:FlxGroup = new FlxGroup();											// SOLS
		public var tourelles_save:FlxGroup = new FlxGroup();									// TOURELLES
		public var item_save:FlxGroup = new FlxGroup();											// TUBES VERTS
		public var destructible_save:FlxGroup = new FlxGroup();									// SOLS DESTRUCTIBLES
		public var ascenceurs_save:FlxGroup = new FlxGroup();									// ASCENCEURS
		public var DustbinBieber_save:FlxGroup = new FlxGroup();								// POUBELLES
        [Embed(source = '../assets/gfx/misc/aith_tiles.png')] public var MapTiles:Class;
        [Embed(source = '../assets/gfx/misc/aith_tiles_vaisseau.png')] public var MapTiles2:Class;
        [Embed(source = '../assets/level/exterieur/fond.png')] public var BgFond:Class;
        [Embed(source = '../assets/level/vaisseau/fond.png')] public var BgFond2:Class;
        [Embed(source = '../assets/gfx/gameplay/sol_destructible.png')] public var ImgDesSol:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_01.png')] public var ImgFarVaisseau1:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_02.png')] public var ImgFarVaisseau2:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_03.png')] public var ImgFarVaisseau3:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_04.png')] public var ImgFarVaisseau4:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_05.png')] public var ImgFarVaisseau5:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_06.png')] public var ImgFarVaisseau6:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_07.png')] public var ImgFarVaisseau7:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_08.png')] public var ImgFarVaisseau8:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_09.png')] public var ImgFarVaisseau9:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_10.png')] public var ImgFarVaisseau10:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-far_11.png')] public var ImgFarVaisseau11:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_01.png')] public var ImgMiddleVaisseau11:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_02.png')] public var ImgMiddleVaisseau12:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_03.png')] public var ImgMiddleVaisseau13:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_04.png')] public var ImgMiddleVaisseau14:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_05.png')] public var ImgMiddleVaisseau15:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_06.png')] public var ImgMiddleVaisseau16:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_07.png')] public var ImgMiddleVaisseau17:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_08.png')] public var ImgMiddleVaisseau18:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_09.png')] public var ImgMiddleVaisseau19:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_10.png')] public var ImgMiddleVaisseau110:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-middle_11.png')] public var ImgMiddleVaisseau111:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_01.png')] public var ImgNearVaisseau11:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_02.png')] public var ImgNearVaisseau12:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_03.png')] public var ImgNearVaisseau13:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_04.png')] public var ImgNearVaisseau14:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_05.png')] public var ImgNearVaisseau15:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_06.png')] public var ImgNearVaisseau16:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_07.png')] public var ImgNearVaisseau17:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_08.png')] public var ImgNearVaisseau18:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_09.png')] public var ImgNearVaisseau19:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_10.png')] public var ImgNearVaisseau110:Class;
        [Embed(source = '../assets/gfx/levels/vaisseau/background-near_11.png')] public var ImgNearVaisseau111:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_01.png')] public var ImgCloud1:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_02.png')] public var ImgCloud2:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_03.png')] public var ImgCloud3:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_04.png')] public var ImgCloud4:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_05.png')] public var ImgCloud5:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_06.png')] public var ImgCloud6:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_07.png')] public var ImgCloud7:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_08.png')] public var ImgCloud8:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_09.png')] public var ImgCloud9:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_10.png')] public var ImgCloud10:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_10.png')] public var ImgCloud11:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_10.png')] public var ImgCloud12:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_10.png')] public var ImgCloud13:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_10.png')] public var ImgCloud14:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_10.png')] public var ImgCloud15:Class;
        [Embed(source = '../assets/gfx/levels/background_exterieur_clouds_10.png')] public var ImgCloud16:Class;
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
		public var lootcount:int = 0;
		
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
			
			if (FlxG.univ == 1 || FlxG.univ == -1) {
				var csv:String = tmx.getLayer('Sol').toCsv(tmx.getTileSet('aith_tiles'));
				var csv3:String = tmx.getLayer('Back_fond').toCsv(tmx.getTileSet('fond'));
				fond.loadMap(csv3, BgFond, 40, 40);
				tile.loadMap(csv, MapTiles, 40, 40);
				FlxG.state.add(fond);
				
				/* Clouds */
				var group_clouds:TmxObjectGroup = tmx.getObjectGroup('Back_clouds');
				for each(var object_cloud:TmxObject in group_clouds.objects) {
					var bat_cloud:FlxSprite = new FlxSprite(object_cloud.x, object_cloud.y);
					switch(object_cloud.gid) {
						case 54 :
							bat_cloud.loadGraphic(ImgCloud2);
							break;
						case 55 :
							bat_cloud.loadGraphic(ImgCloud3);
							break;
						case 56 :
							bat_cloud.loadGraphic(ImgCloud4);
							break;
						case 57 :
							bat_cloud.loadGraphic(ImgCloud5);
							break;
						case 58 :
							bat_cloud.loadGraphic(ImgCloud6);
							break;
						case 59 :
							bat_cloud.loadGraphic(ImgCloud7);
							break;
						case 60 :
							bat_cloud.loadGraphic(ImgCloud8);
							break;
						case 61 :
							bat_cloud.loadGraphic(ImgCloud9);
							break;
						case 62 :
							bat_cloud.loadGraphic(ImgCloud10);
							break;
						case 63 :
							bat_cloud.loadGraphic(ImgCloud11);
							break;
						case 64 :
							bat_cloud.loadGraphic(ImgCloud12);
							break;
						case 65 :
							bat_cloud.loadGraphic(ImgCloud13);
							break;
						case 66 :
							bat_cloud.loadGraphic(ImgCloud14);
							break;
						case 67 :
							bat_cloud.loadGraphic(ImgCloud15);
							break;
						case 68 :
							bat_cloud.loadGraphic(ImgCloud16);
							break;
					}
					bat_cloud.y -= bat_cloud.frameHeight;
					bat_cloud.scrollFactor = new FlxPoint(0.5, 0.5);
					clouds.add(bat_cloud);
				}
				FlxG.state.add(clouds);
				
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
					bat_far.y -= bat_far.frameHeight;
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
					bat_middle.y -= bat_middle.frameHeight;
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
					bat_near.y -= bat_near.frameHeight;
					bat_near.scrollFactor = new FlxPoint(1, 1);
					batiments_near.add(bat_near);
				}
				FlxG.state.add(batiments_near);
			}
			else if (FlxG.univ == 2) { // ---------------------------------------------------UNIV 2 -------------------------------------
				var csv_vaisseau:String = tmx.getLayer('Sol').toCsv(tmx.getTileSet('aith_tiles_vaisseau'));
				tile.loadMap(csv_vaisseau, MapTiles2, 40, 40);
				
				/* FOND */
				var group_fond:TmxObjectGroup = tmx.getObjectGroup('Fond');
				for each(var object_fond:TmxObject in group_fond.objects) {
					var bat_fond:FlxSprite = new FlxSprite(object_fond.x, object_fond.y);
					switch(object_fond.gid) {
						case 43 :
							bat_fond.loadGraphic(BgFond2);
							break;
					}
					bat_fond.y -= bat_fond.frameHeight
					batiments_fond.add(bat_fond);
				}
				FlxG.state.add(batiments_fond);
				
				/* FAR */
				var group_far_vaisseau:TmxObjectGroup = tmx.getObjectGroup('Back_far');
				for each(var object_far_vaisseau:TmxObject in group_far_vaisseau.objects) {
					var bat_far_vaisseau:FlxSprite = new FlxSprite(object_far_vaisseau.x, object_far_vaisseau.y);
					switch(object_far_vaisseau.gid) {
						case 44 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau1);
							break;
						case 45 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau2);
							break;
						case 46 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau3);
							break;
						case 47 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau4);
							break;
						case 48 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau5);
							break;
						case 49 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau6);
							break;
						case 50 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau7);
							break;
						case 51 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau8);
							break;
						case 52 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau9);
							break;
						case 53 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau10);
							break;
						case 54 :
							bat_far_vaisseau.loadGraphic(ImgFarVaisseau11);
							break;
					}
					bat_far_vaisseau.y -= bat_far_vaisseau.frameHeight;
					batiments_far_vaisseau.add(bat_far_vaisseau);
				}
				FlxG.state.add(batiments_far_vaisseau);
				
				/* MIDDLE */
				var group_middle_vaisseau:TmxObjectGroup = tmx.getObjectGroup('Back_middle');
				for each(var object_middle_vaisseau:TmxObject in group_middle_vaisseau.objects) {
					var bat_middle_vaisseau:FlxSprite = new FlxSprite(object_middle_vaisseau.x, object_middle_vaisseau.y);
					switch(object_middle_vaisseau.gid) {
						case 55 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau11);
							break;
						case 56 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau12);
							break;
						case 57 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau13);
							break;
						case 58 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau14);
							break;
						case 59 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau15);
							break;
						case 60 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau16);
							break;
						case 61 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau17);
							break;
						case 62 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau18);
							break;
						case 63 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau19);
							break;
						case 64 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau111);
							break;
						case 65 :
							bat_middle_vaisseau.loadGraphic(ImgMiddleVaisseau110);
							break;
					}
					bat_middle_vaisseau.y -= bat_middle_vaisseau.frameHeight;
					batiments_middle_vaisseau.add(bat_middle_vaisseau);
				}
				FlxG.state.add(batiments_middle_vaisseau);
				
				/* NEAR */
				var group_near_vaisseau:TmxObjectGroup = tmx.getObjectGroup('Back_near');
				for each(var object_near_vaisseau:TmxObject in group_near_vaisseau.objects) {
					var bat_near_vaisseau:FlxSprite = new FlxSprite(object_near_vaisseau.x, object_near_vaisseau.y);
					switch(object_near_vaisseau.gid) {
						case 66 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau11);
							break;
						case 67 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau12);
							break;
						case 68 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau13);
							break;
						case 69 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau14);
							break;
						case 70 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau15);
							break;
						case 71 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau16);
							break;
						case 72 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau17);
							break;
						case 73 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau18);
							break;
						case 74 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau19);
							break;
						case 75 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau110);
							break;
						case 76 :
							bat_near_vaisseau.loadGraphic(ImgNearVaisseau111);
							break;
					}
					bat_near_vaisseau.y -= bat_near_vaisseau.frameHeight;
					batiments_near_vaisseau.add(bat_near_vaisseau);
				}
				FlxG.state.add(batiments_near_vaisseau);
			}
			FlxG.state.add(tile);
			FlxG.tilemap = tile;
			
			// PARSING DES OBJETS
			var group:TmxObjectGroup = tmx.getObjectGroup('Gameplay');
			for each(var object:TmxObject in group.objects) {
				switch(object.type) {
					case "Ground":
						var sol:FlxSprite = new FlxSprite(object.x, object.y);
						sol.width = object.width;
						sol.y += object.height - 10;
						sol.height = object.height;
						sol.visible = false;
						grounds.add(sol);
						FlxG.state.add(grounds);
						break;
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
						item_save.add (new TubeVert(object.x, object.y, 1, 0));
						lootcount += 1;
						break;
					case "GrosTube":
						item.add (new TubeVert(object.x, object.y, 5,1));
						item_save.add (new TubeVert(object.x, object.y, 5, 1));
						lootcount += 5;
						break;
					case "Alien":
						ens.add (new AlienNormal(object.x, object.y));
						ens_save.add (new AlienNormal(object.x, object.y));
						break;
					case "AlienVert":
						ens.add (new AlienVert(object.x, object.y));
						ens_save.add (new AlienVert(object.x, object.y));
						break;
					case "Tourelle":
						tourelles.add (new Tourelle(object.x, object.y));
						tourelles_save.add (new Tourelle(object.x, object.y));
						break;
					case "AlienHorizontal":
						ens.add (new AlienHorizontal(object.x, object.y));
						ens_save.add (new AlienHorizontal(object.x, object.y));
						break;
					case "Ascenceur":
						ascenceurs.add (new Ascenceur(object.x, object.y));
						ascenceurs_save.add (new Ascenceur(object.x, object.y));
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
						DustbinBieber_save.add (new Poubelle(object.x, object.y));
						break;
					case "Soucoupe":
						soucoupes.add (new Soucoupe(object.x, object.y));
						break;
					case "backflip":
						var startBF :FlxSprite = new FlxSprite(object.x, object.y);
						startBF.width = object.width;
						startBF.height = object.height;
						backflip.add (startBF);
						break;
					case "endBackflip":
						var endBF :FlxSprite = new FlxSprite(object.x, object.y);
						endBF.width = object.width;
						endBF.height = object.height;
						endBackflip.add (endBF);
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
						destructible.add(new Destructible_ground(object.x, object.y));
						destructible_save.add(new Destructible_ground(object.x, object.y));
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
			/* TODO / DEV LOOTCOUNT A VIRER*/
			trace("Loot des tubes : ", lootcount);
			FlxG.state.add(item);
			FlxG.state.add(destructible);
			FlxG.state.add(tremplins);
			FlxG.state.add(ascenceurs);
			FlxG.state.add(triggers);
			FlxG.state.add(piques);
			FlxG.state.add(DustbinBieber);
			FlxG.state.add(shootemup);
			FlxG.state.add(souffleries);
			FlxG.state.add(backflip);
			FlxG.state.add(endBackflip);
			FlxG.state.add(soucoupes);
			FlxG.state.add(ens);
			FlxG.state.add(tourelles);
			FlxG.state.add(checkpoints);
			FlxG.state.add(fin);
			// AJOUT PLAYER ET CAM
			player = new Player(50, 610);
			FlxG.player = player;
			cam = new Cam(player);
			FlxG.state.add(player);
			FlxG.state.add(cam);
			FlxG.worldBounds = new FlxRect(0, 0, largeur, 600 + offsety);
			FlxG.camera.setBounds(0, 0, largeur, 600 + offsety);
			FlxG.camera.follow(cam);
			finishedload = true;
		}
		
		// RECHARGE OBJETS POUR CHECKPOINTS
		public function reload_map():void {
			var i:int = 0;
			while (i < ens.length) {
				ens.members[i].kill();
				FlxG.state.remove(ens.members[i], true);
				ens.remove(ens.members[i], true);
			}
			for each (var en:FlxSprite in ens_save.members) {
				if (en is AlienHorizontal) {
					var new_enh:AlienHorizontal = new AlienHorizontal(en.x, en.y);
					ens.add(new_enh);
				}
				if (en is AlienNormal) {
					var new_enn:AlienNormal = new AlienNormal(en.x, en.y);
					ens.add(new_enn);
				}
			}
			/*var j:int = 0;
			while (j < souffleries.length) {
				if ((souffleries.members[i] as Soufflerie).soundIn != null) {
					(souffleries.members[i] as Soufflerie).soundIn.stop();
					(souffleries.members[i] as Soufflerie).soundIn.kill();
					(souffleries.members[i] as Soufflerie).soundIn.destroy();
				}
				j++;
			}*/
			while (i < ascenceurs.length) {
				if ((ascenceurs.members[i] as Ascenceur).soundActivation1 != null) {
					(ascenceurs.members[i] as Ascenceur).soundActivation1.stop();
					(ascenceurs.members[i] as Ascenceur).soundActivation1.kill();
					(ascenceurs.members[i] as Ascenceur).soundActivation1.destroy();
				}
				if ((ascenceurs.members[i] as Ascenceur).soundActivation2 != null) {
					(ascenceurs.members[i] as Ascenceur).soundActivation2.stop();
					(ascenceurs.members[i] as Ascenceur).soundActivation2.kill();
					(ascenceurs.members[i] as Ascenceur).soundActivation2.destroy();
				}
				if ((ascenceurs.members[i] as Ascenceur).soundMoves != null) {
					(ascenceurs.members[i] as Ascenceur).soundMoves.stop();
					(ascenceurs.members[i] as Ascenceur).soundMoves.kill();
					(ascenceurs.members[i] as Ascenceur).soundMoves.destroy();
				}
				ascenceurs.members[i].kill();
				FlxG.state.remove(ascenceurs.members[i], true);
				ascenceurs.remove(ascenceurs.members[i], true);
			}
			for each (var asc:Ascenceur in ascenceurs_save.members) {
				var new_asc:Ascenceur = new Ascenceur(asc.x, asc.y);
				ascenceurs.add(new_asc);
			}
			while (i < item.length) {
				item.members[i].kill();
				FlxG.state.remove(item.members[i], true);
				item.remove(item.members[i], true);
			}
			for each (var itm:TubeVert in item_save.members) {
				var new_item:TubeVert = new TubeVert(itm.x, itm.y, itm.loot, itm.type);
				item.add(new_item);
			}
			while (i < DustbinBieber.length) {
				DustbinBieber.members[i].kill();
				FlxG.state.remove(DustbinBieber.members[i], true);
				DustbinBieber.remove(DustbinBieber.members[i], true);
			}
			for each (var dust:Poubelle in DustbinBieber_save.members) {
				var new_dust:Poubelle = new Poubelle(dust.x, dust.y);
				DustbinBieber.add(new_dust);
			}
			while (i < destructible.length) {
				destructible.members[i].kill();
				FlxG.state.remove(destructible.members[i], true);
				destructible.remove(destructible.members[i], true);
			}
			for each (var dest:Destructible_ground in destructible_save.members) {
				var new_dest:Destructible_ground = new Destructible_ground(dest.x, dest.y);
				destructible.add(new_dest);
			}
			/*
			while (i < tourelles.length) {
				if ((tourelles.members[i] as Tourelle) != null) {
					(tourelles.members[i] as Tourelle).flammes.kill();
					(tourelles.members[i] as Tourelle).flammes.exists = false;
					FlxG.state.remove((tourelles.members[i] as Tourelle).flammes, true);
					(tourelles.members[i] as Tourelle).flammes.destroy();
					(tourelles.members[i] as Tourelle).flammes = null;
				}
				tourelles.members[i].kill();
				(tourelles.members[i] as Tourelle).exists = false;
				FlxG.state.remove(tourelles.members[i], true);
				tourelles.remove(tourelles.members[i], true);
			}
			for each (var tour:Tourelle in tourelles_save.members) {
				var new_tour:Tourelle = new Tourelle(tour.x, tour.y);
				tourelles.add(new_tour);
			}*/
			FlxG.player.dead = false;
		}
	}

}