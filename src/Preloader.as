package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	public class Preloader extends MovieClip
	{
		[Embed(source = '../assets/gfx/misc/loading.png')] private var loadingPNG:Class;
		
		private var bg:Bitmap;
		private var load:Bitmap;
		private var progressBar:Bitmap;
		
		public function Preloader() 
		{
			if (stage)
			{
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
				stage.quality = StageQuality.LOW;
			}
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			bg = new Bitmap(new BitmapData(800, 600, false, 0x0));
			
			load = new loadingPNG;
			load.x = 0
			load.y = 0
			
			progressBar = new Bitmap(new BitmapData(448*2, 16*2, false, 0xffa1a5d7));
			progressBar.x = 16*2;
			progressBar.y = 128*2;
			
			addChild(bg);
			addChild(load);
			addChild(progressBar);
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			var pct:int = int((e.bytesLoaded / e.bytesTotal) * 100);
			var fill:int = 10 * pct;
			progressBar.bitmapData.fillRect(new Rectangle(0, 0, fill, progressBar.height), 0xff7c81c3);
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			removeChild(load);
			removeChild(progressBar);
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("AITH") as Class;
			
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}