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
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class PageListItem extends UIComponent
	{
		
		protected var background:Sprite;
		
		protected var content:Sprite;
		
		protected var preloader:Preloader;
		
		protected var _page:Page;
		
		public function get page():Page
		{
			return _page;
		}
		
		public function set page(value:Page):void
		{
			var oldValue:Page = _page;
			
			if (oldValue == value) return;
			
			if (value) {
				value.removeEventListener(BookEvent.PAGE_LOADED, handlePageLoaded);
			}
			
			_page = value;
			
			if (value && value.url) {
				if (value.thumb) {
					handlePageLoaded();
				} else {
					preloader.visible = true;
					value.addEventListener(BookEvent.PAGE_LOADED, handlePageLoaded);
				}
			}
			
			invalidate();
		}
		
		public function PageListItem()
		{
			super();
		}
		
		override protected function configUI():void
		{
			super.configUI();
			
			background = new Sprite;
			background.graphics.beginFill(0xffffff);
			background.graphics.drawRect(0, 0, 1, 1);
			addChild(background);
			
			content = new Sprite;
			addChild(content);
			
			preloader = new Preloader;
			preloader.visible = false;
			addChild(preloader);
			
			buttonMode = true;
		}
		
		override protected function draw():void
		{
			if (isInvalid(InvalidationType.SIZE)) {
				background.width = width;
				background.height = height;
				
				//preloader.visible = page && ! page.loaded && page.url;
				preloader.x = (width - preloader.width) / 2;
				preloader.y = (height - preloader.height) / 2;
				
				drawThumb();
			}
			
			super.draw();
		}
		
		protected function handlePageLoaded(e:BookEvent = null):void
		{
			page.removeEventListener(BookEvent.PAGE_LOADED, handlePageLoaded);
			preloader.visible = false;
			validateNow();
		}
		
		protected function drawThumb():void
		{
			content.graphics.clear();
			
			if (! page || ! page.thumb) return;
			
			var bitmapData:BitmapData = page.thumb;
			
			var m:Matrix = new Matrix;
			m.scale(width / bitmapData.width, height / bitmapData.height);
			
			content.graphics.beginBitmapFill(bitmapData, m, false, true);
			content.graphics.drawRect(0, 0, width, height);
		}
		
	}

}