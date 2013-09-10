/**
 * DevCafé Pageflip
 *
 * @author Rodrigo Rutkoski Rodrigues <rutkoski@gmail.com>
 *
 * This file is part of DevCafé Pageflip.
 *
 * DevCafé Pageflip is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * DevCafé Pageflip is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.devcafe.pageflip
{
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class Page extends UIComponent
	{
		
		public static var LEFT:int = 1;
		
		public static var RIGHT:int = -1;
		
		public var book:Book;
		
		public var preloader:Preloader;
		
		protected var background:Sprite;
		
		protected var loader:Loader;
		
		protected var maskSprite:Sprite;
		
		protected var _autoLoad:Boolean;
		
		protected var _autoUnload:Boolean;
		
		protected var _scaleMode:String;
		
		protected var _align:String;
		
		protected var _verticalAlign:String;
		
		protected var _smoothing:Boolean = true;
		
		protected var _backgroundColor:Number = 0xFFFFFF;
		
		protected var _backgroundAlpha:Number = 1;
		
		protected var _loaded:Boolean;
		
		protected var _url:String;
		
		protected var _thumb:BitmapData;
		
		public function get side():int
		{
			return (index % 2 == 0) ? Page.LEFT : Page.RIGHT;
		}
		
		public function get index():int
		{
			return book.pages.indexOf(this);
		}
		
		public function get url():String { return _url; }
		
		public function set url(value:String):void
		{
			var oldValue:String = _url;
			
			if (oldValue == value) return;
			
			unload();
			
			_url = value;
			
			if (value && autoLoad) {
				if (stage) {
					load(url);
				} else {
					addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
				}
			}
		}
		
		public function get backgroundColor():Number { return _backgroundColor; }
		
		public function set backgroundColor(value:Number):void
		{
			var oldValue:Number = _backgroundColor;
			
			if (oldValue == value) return;
			
			_backgroundColor = value;
			
			invalidate();
		}
		
		public function get backgroundAlpha():Number { return _backgroundAlpha; }
		
		public function set backgroundAlpha(value:Number):void
		{
			var oldValue:Number = _backgroundAlpha;
			
			if (oldValue == value) return;
			
			_backgroundAlpha = value;
			
			invalidate();
		}
		
		public function get scaleMode():String { return _scaleMode; }
		
		public function set scaleMode(value:String):void
		{
			var oldValue:String = _scaleMode;
			
			if (oldValue == value) return;
			
		  _scaleMode = value;
			
		  invalidate();
		}
		
		public function get smoothing():Boolean { return _smoothing; }
		
		public function set smoothing(value:Boolean):void
		{
			var oldValue:Boolean = _smoothing;
			
			if (oldValue == value) return;
			
			_smoothing = value;
			
			invalidate();
		}
		
		public function get align():String { return _align; }
		
		public function set align(value:String):void
		{
			var oldValue:String = _align;
			
			if (oldValue == value) return;
			
			_align = value;
			
			invalidate();
		}
		
		public function get verticalAlign():String { return _verticalAlign; }
		
		public function set verticalAlign(value:String):void
		{
			var oldValue:String = _verticalAlign;
			
			if (oldValue == value) return;
			
			_verticalAlign = value;
			
			invalidate();
		}
		
		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		public function get thumb():BitmapData
		{
			return _thumb;
		}
		
		public function get autoLoad():Boolean { return _autoLoad; }
		
		public function set autoLoad(value:Boolean):void
		{
			var oldValue:Boolean = _autoLoad;
			
			if (oldValue == value) return;
			
			_autoLoad = value;
			
			if (value) {
				addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
				
				if (stage) {
					loadNow();
				}
			} else {
				removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			}
		}
		
		public function get autoUnload():Boolean { return _autoUnload; }
		
		public function set autoUnload(value:Boolean):void
		{
			var oldValue:Boolean = _autoUnload;
			
			if (oldValue == value) return;
			
			_autoUnload = value;
			
			if (value) {
				addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
				
				if (! stage) {
					unload();
				}
			} else {
				removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			}
		}
		
		public function Page()
		{
			super();
		}
		
		/**
		 * Force loading the page
		 */
		public function loadNow():void
		{
			load(url);
		}
		
		/**
		 * Unload the page
		 */
		public function unload():void
		{
			loader.unload();
			_loaded = false;
		}
		
		/**
		 * Get a bitmap snapshot of the page
		 *
		 * @return BitmapData
		 */
		public function getBitmapData():BitmapData
		{
			var bitmapData:BitmapData = new BitmapData(width, height, true, backgroundColor);
			bitmapData.draw(this, null, null, null, null, true);
			return bitmapData;
		}
		
		protected function load(url:String):void
		{
			if (! url) return;
			
			var path:String = book.options.path;
			if (path && url && ! url.match(/^https?:\/\//)) {
				if (! path.match(/\/$/)) {
					path += '/';
				}
				
				url = path + url;
			}
			
			var request:URLRequest = new URLRequest(url);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoadComplete);
			loader.load(request);
			
			preloader.visible = true;
		}
		
		protected function handleAddedToStage(e:Event):void
		{
			if (! loaded) load(url);
		}
		
		protected function handleRemovedFromStage(e:Event):void
		{
			unload();
		}
		
		protected function handleLoadComplete(e:Event):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, handleLoadComplete);
			
			preloader.visible = false;
			
			_loaded = true;
			
			if (loader.content is Bitmap) {
				scaleMode = scaleMode || PageScaleMode.STRETCH;
				align = align || PageAlign.CENTER;
				verticalAlign = verticalAlign || PageAlign.MIDDLE;
			} else {
				scaleMode = scaleMode || PageScaleMode.NO_SCALE;
				align = align || PageAlign.LEFT;
				verticalAlign = verticalAlign || PageAlign.TOP;
			}
			
			validateNow();
			
			if (! thumb) {
				_thumb = getBitmapData();
			}
			
			dispatchEvent(new BookEvent(BookEvent.PAGE_LOADED));
		}
		
		override protected function configUI():void
		{
			super.configUI();
			
			background = new Sprite;
			background.mouseEnabled = false;
			addChild(background);
			
			loader = new Loader;
			loader.mouseEnabled = false;
			addChild(loader);
			
			maskSprite = new Sprite;
			maskSprite.graphics.beginFill(0x00FF00);
			maskSprite.graphics.drawRect(0, 0, 1, 1);
			addChild(maskSprite);
			
			loader.mask = maskSprite;
			
			preloader = new Preloader;
			preloader.mouseEnabled = false;
			preloader.visible = false;
			addChild(preloader);
		}
		
		override protected function draw():void
		{
			if (isInvalid(InvalidationType.STYLES)) {
				background.graphics.clear();
				background.graphics.beginFill(backgroundColor, backgroundAlpha);
				background.graphics.drawRect(0, 0, 1, 1);
				
				if (loader.content) {
					if (loader.content is Bitmap) {
						Bitmap(loader.content).smoothing = smoothing;
					}
				}
			}
			
			if (isInvalid(InvalidationType.STYLES, InvalidationType.SIZE)) {
				if (loader.content) {
					if (scaleMode != PageScaleMode.NO_SCALE) {
						var s:Point = new Point(loader.content.width, loader.content.height);
						
						switch (scaleMode) {
							case PageScaleMode.STRETCH:
								s.x = width;
								s.y = height;
								break;
								
							case PageScaleMode.FIT_INSIDE:
								s = Resize.inside(width, height, s.x, s.y);
								break;
								
							case PageScaleMode.FIT_OUTSITE:
								s = Resize.outside(width, height, s.x, s.y);
								break;
						}
						
						loader.content.width = s.x;
						loader.content.height = s.y;
					}
					
					switch (align) {
						case PageAlign.LEFT: loader.content.x = 0; break;
						case PageAlign.CENTER: loader.content.x = (width - loader.content.width) / 2; break;
						case PageAlign.RIGHT: loader.content.x = width - loader.content.width; break;
					}
					
					switch (verticalAlign) {
						case PageAlign.TOP: loader.content.y = 0; break;
						case PageAlign.MIDDLE: loader.content.y = (height - loader.content.height) / 2; break;
						case PageAlign.BOTTOM: loader.content.y = height - loader.content.height; break;
					}
				}
			}
			
			if (isInvalid(InvalidationType.SIZE)) {
				background.width = width;
				background.height = height;
				
				maskSprite.width = width;
				maskSprite.height = height;
				
				preloader.x = (width - preloader.width) / 2;
				preloader.y = (height - preloader.height) / 2;
			}
			
			super.draw();
		}
		
		override public function toString():String
		{
			return '[Page ' + index + ']';
		}
		
	}

}