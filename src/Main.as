/**
 * DevCafé Pageflip Lite
 *
 * @author Rodrigo Rutkoski Rodrigues <rutkoski@gmail.com>
 *
 * This file is part of DevCafé Pageflip Lite.
 *
 * DevCafé Pageflip Lite is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * DevCafé Pageflip Lite is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
 */
package
{
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import com.devcafe.pageflip.Book;
	import com.devcafe.pageflip.BookEvent;
	import com.devcafe.pageflip.data.DataLoader;
	import com.devcafe.pageflip.data.LoaderQueue;
	import com.devcafe.pageflip.data.XMLLoader;
	import com.devcafe.pageflip.Resize;
	import com.devcafe.pageflip.ui.NavigationMenu;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * DevCafé Pageflip Lite
	 *
	 * @author Rodrigo Rutkoski Rodrigues <rutkoski@gmail.com>
	 */
	public class Main extends MovieClip
	{
		
		public var book:Book;
		
		public var navigation:NavigationMenu;
		
		public var copy:MovieClip;
		
		public var preloader:MovieClip;
		
		public var dataLoader:DataLoader;
		
		protected var queue:LoaderQueue;
		
		protected var bookWidth:Number;
		
		protected var bookHeight:Number;
		
		protected var inited:Boolean = false;
		
		protected var path:String;
		
		public function Main()
		{
			super();
			
			var params:Object = loaderInfo.parameters;
			
			path = params.path || '';
			
			if (path.length && ! path.match(/\/$/)) {
				path += '/';
			}
			
			addFrameScript(1, app);
			
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		protected function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stop();
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			
			draw();
		}
		
		protected function handleEnterFrame(e:Event):void
		{
			if (loaderInfo.bytesLoaded == loaderInfo.bytesTotal) {
				removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
				nextFrame();
			}
		}
		
		protected function app():void
		{
			stop();
			
			dataLoader = new XMLLoader();
			dataLoader.addEventListener(Event.COMPLETE, handleDataLoaded);
			dataLoader.load(path + 'pageflip.xml');
			
			navigation.book = book;
			
			queue = new LoaderQueue(book);
			
			stage.addEventListener(Event.RESIZE, draw);
			
			bookWidth = book.width;
			bookHeight = book.height;
			
			book.addEventListener(BookEvent.PAGE_CHANGE, handlePageChange);
			
			draw();
			
			inited = true;
		}
		
		protected function handleDataLoaded(e:Event):void
		{
			if (dataLoader.options.pageWidth && dataLoader.options.pageWidth) {
				bookWidth = dataLoader.options.pageWidth * 2;
				bookHeight = dataLoader.options.pageHeight;
			}
			
			draw();
			
			book.options = dataLoader.options;
			book.dataProvider = dataLoader.data;
			
			queue.loadNext();
			
			SWFAddress.addEventListener(SWFAddressEvent.EXTERNAL_CHANGE, onExternalChange);
		}
		
		protected function handlePageChange(e:BookEvent):void
		{
			var page:String = book.currentPages().join('-');
			SWFAddress.setValue(page);
		}
		
		protected function onExternalChange(e:SWFAddressEvent):void
		{
			var page:String = SWFAddress.getValue();
			var matches:Array = page.match(/(\d+)/);
			
			if (matches) {
				book.gotoPage(matches[1]);
			}
		}
		
		protected function draw(e:Event = null):void
		{
			if (navigation) {
				var margin:Number = 100;
				
				var p:Point = Resize.inside(stage.stageWidth - margin, stage.stageHeight - navigation.height - margin, bookWidth, bookHeight);
				
				var x:Number = (stage.stageWidth - p.x) / 2;
				var y:Number = ((stage.stageHeight - navigation.height - p.y) / 2) + navigation.height;
				
				if (inited) {
					TweenLite.to(book, .3, { x:x, y:y, width:p.x, height:p.y } );
				} else {
					book.x = x;
					book.y = y;
					book.width = p.x;
					book.height = p.y;
				}
				
				copy.x = stage.stageWidth - copy.width;
				copy.y = stage.stageHeight - copy.height;
			}
			
			if (preloader) {
				preloader.x = (stage.stageWidth - preloader.width) / 2;
				preloader.y = (stage.stageHeight - preloader.height) / 2;
			}
		}
		
	}

}