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
	import com.foxaweb.pageflip.PageFlip;
	import com.greensock.plugins.BezierThroughPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class Book extends UIComponent
	{
		
		public var flipDuration:Number = .8;
		
		public var options:Object = { };
		
		protected var flipping:Boolean;
		
		protected var _dataProvider:Array;
		
		protected var _pages:Array = [];
		
		protected var background:Shape;
		
		protected var content:Sprite;
		
		protected var render:Shape;
		
		protected var shadow:Shape;
		
		protected var bitmaps:Array = [];
		
		protected var flipCorner:Point;
		
		protected var flipPoint:Point;
		
		protected var lastFlipPoint:Point;
		
		protected var _leftIndex:int;
		
		protected var _rightIndex:int;
		
		protected var _leftVisiblePage:Page;
		
		protected var _rightVisiblePage:Page;
		
		protected var _frontFlippingPage:Page;
		
		protected var _backFlippingPage:Page;
		
		protected var cornerLength:Number = 40;
		
		protected var corners:Array = [];
		
		public function get numPages():int
		{
			return pages.length;
		}
		
		public function get dataProvider():Array
		{
			return _dataProvider;
		}
		
		public function set dataProvider(value:Array):void
		{
			var oldValue:Array = _dataProvider;
			
			if (oldValue == value) return;
			
			_dataProvider = value;
			
			if (value.length % 2 != 0) {
				value.push(null);
			}
			
			var pages:Array = [];
			
			if (value) {
				var index:int = 0;
				
				for each (var item:Object in dataProvider) {
					var page:Page = new Page;
					page.book = this;
					
					for (var prop:String in item) {
						page[prop] = item[prop];
					}
					
					pages.push(page);
				}
			}
			
			_pages = pages;
			
			leftIndex = -1;
			
			leftVisiblePage = null;
			rightVisiblePage = getPageAt(0);
			
			invalidate();
		}
		
		protected function get leftVisiblePage():Page
		{
			return _leftVisiblePage;
		}
		
		protected function set leftVisiblePage(value:Page):void
		{
			var oldValue:Page = _leftVisiblePage;
			
			if (oldValue == value) return;
			
			if (oldValue != null) {
				content.removeChild(oldValue);
			}
			
			_leftVisiblePage = value;
			
			if (value) {
				if (! value.loaded) value.loadNow();
				content.addChild(value);
			}
		}
		
		protected function get rightVisiblePage():Page
		{
			return _rightVisiblePage;
		}
		
		protected function set rightVisiblePage(value:Page):void
		{
			var oldValue:Page = _rightVisiblePage;
			
			if (oldValue == value) return;
			
			if (oldValue != null) {
				content.removeChild(oldValue);
			}
			
			_rightVisiblePage = value;
			
			if (value) {
				if (! value.loaded) value.loadNow();
				content.addChild(value);
			}
		}
		
		protected function get frontFlippingPage():Page
		{
			return _frontFlippingPage;
		}
		
		protected function set frontFlippingPage(value:Page):void
		{
			var oldValue:Page = _frontFlippingPage;
			
			if (oldValue == value) return;
			
			_frontFlippingPage = value;
			
			if (value) {
				if (! value.loaded) value.loadNow();
				bitmaps[0] = value.getBitmapData();
			} else {
				delete bitmaps[0];
			}
		}
		
		protected function get backFlippingPage():Page
		{
			return _backFlippingPage;
		}
		
		protected function set backFlippingPage(value:Page):void
		{
			var oldValue:Page = _backFlippingPage;
			
			if (oldValue == value) return;
			
			_backFlippingPage = value;
			
			if (value) {
				if (! value.loaded) value.loadNow();
				bitmaps[1] = value.getBitmapData();
			} else {
				delete bitmaps[1];
			}
		}
		
		protected function get leftIndex():int
		{
			return _leftIndex;
		}
		
		protected function set leftIndex(value:int):void
		{
			var oldValue:int = _leftIndex;
			
			if (oldValue == value) return;
			
			_leftIndex = value;
			_rightIndex = value + 1;
			
			dispatchEvent(new BookEvent(BookEvent.PAGE_CHANGE));
		}
		
		protected function get rightIndex():int
		{
			return _rightIndex;
		}
		
		protected function set rightIndex(value:int):void
		{
			var oldValue:int = _rightIndex;
			
			if (oldValue == value) return;
			
			_rightIndex = value;
			_leftIndex = value - 1;
			
			dispatchEvent(new BookEvent(BookEvent.PAGE_CHANGE));
		}
		
		public function get pages():Array
		{
			return _pages;
		}
		
		public function get zoom():Number { return getScaleX(); }
		
		public function set zoom(value:Number):void
		{
			setScaleX(value);
			setScaleY(value);
		}
		
		public function Book()
		{
			super();
		}
		
		public function getPageAt(index:int):Page
		{
			if (index < 0 || index >= numPages) return null;
			
			return pages[index];
		}
		
		public function isFirstPage():Boolean
		{
			return rightIndex == 0;
		}
		
		public function isLastPage():Boolean
		{
			return rightIndex == numPages;
		}
		
		/**
		 * Get current visible page(s) number(s)
		 *
		 * @return Array
		 */
		public function currentPages():Array
		{
			var pages:Array = [];
			if (! isFirstPage()) pages.push(leftIndex + 1);
			if (! isLastPage()) pages.push(rightIndex + 1);
			return pages;
		}
		
		/**
		 * Flip to first page
		 */
		public function firstPage():void
		{
			gotoPage(1);
		}
		
		/**
		 * Flip to previous page
		 */
		public function previousPage():void
		{
			gotoPage(leftIndex - 2);
		}
		
		/**
		 * Flip to next page
		 */
		public function nextPage():void
		{
			gotoPage(rightIndex + 2);
		}
		
		/**
		 * Flip to last page
		 */
		public function lastPage():void
		{
			gotoPage(numPages);
		}
		
		/**
		 * Flip to pageNum
		 *
		 * @param	pageNum 1-based page number
		 */
		public function gotoPage(pageNum:int):void
		{
			pageNum--;
			
			pageNum = Math.max(0, Math.min(numPages, pageNum));
			
			if (pageNum == leftIndex || pageNum == rightIndex) return;
			
			flipping = true;
			
			flipCorner.x = pageNum < leftIndex ? 0 : 1;
			flipCorner.y = 1;
			
			var currLeftIndex:int = leftIndex;
			var currRightIndex:int = rightIndex;
			
			if (isLeftPage(pageNum)) {
				leftIndex = pageNum;
			} else {
				rightIndex = pageNum;
			}
			
			frontFlippingPage = getPageAt(flipCorner.x ? currRightIndex : currLeftIndex);
			backFlippingPage = getPageAt(flipCorner.x ? leftIndex : rightIndex);
			rightVisiblePage = getPageAt(flipCorner.x ? rightIndex : currRightIndex);
			leftVisiblePage = getPageAt(flipCorner.x ? currLeftIndex : leftIndex);
			
			flipPoint.x = flipCorner.x ? width / 2 : 0;
			flipPoint.y = height;
			
			autoFlip(flipCorner.x);
			
			dispatchEvent(new BookEvent(BookEvent.FLIP_BEGIN));
		}
		
		/**
		 *
		 *
		 *
		 */
		
		override protected function configUI():void
		{
			super.configUI();
			
			flipCorner = new Point;
			flipPoint = new Point;
			lastFlipPoint = new Point;
			
			background = new Shape;
			background.graphics.beginFill(0, 0);
			background.graphics.drawRect(0, 0, 1, 1);
			addChild(background);
			
			content = new Sprite;
			content.mouseEnabled = false;
			addChild(content);
			
			render = new Shape;
			addChild(render);
			
			shadow = new Shape;
			shadow.visible = false;
			addChild(shadow);
			
			createCorners();
			
			TweenPlugin.activate([BezierThroughPlugin]);
			
			addEventListener(MouseEvent.CLICK, handleMouseFlipEvents);
			addEventListener(MouseEvent.MOUSE_DOWN, handleMouseFlipEvents);
			
			flipEnded();
			
			if (isLivePreview) {
				dataProvider = [null, null];
			}
		}
		
		protected function createCorners():void
		{
			var points:Array = [ { x:0, y:0 }, { x:0, y:1 }, { x:1, y:0 }, { x:1, y:1 } ];
			
			for each (var point:Object in points) {
				var corner:Corner = new Corner(point.x, point.y, cornerLength);
				addChild(corner);
				corners.push(corner);
			}
		}
		
		override protected function draw():void
		{
			if (isInvalid(InvalidationType.SIZE)) {
				background.width = width;
				background.height = height;
				
				var even:Boolean = true;
				for (var i:int = 0; i < numPages; i++) {
					var page:Page = getPageAt(i);
					page.x = even ? width / 2 : 0;
					page.y = 0;
					page.setSize(width / 2, height);
					page.drawNow();
					
					even = !even;
				}
				
				for each (var corner:Corner in corners) {
					corner.position(width, height);
				}
				
				drawShadow();
			}
			
			super.draw();
		}
		
		protected function drawShadow():void
		{
			shadow.graphics.clear();
			
			var emptyBitmap = new BitmapData(width, height, true, 0x00ff00);
			emptyBitmap.fillRect(new Rectangle(0, 0, width, height), 0x00ff00);
			
			var ocf:Object = PageFlip.computeFlip(new Point(0, 0), new Point(0, 0),  width / 2, height, true, 1);
			
			PageFlip.drawBitmapSheet(ocf, shadow, emptyBitmap, emptyBitmap, true, false, false, true);
		}
		
		protected function handleHoverEvents(e:MouseEvent):void
		{
			if (flipping) return;
			
			var corner:Corner = e.target as Corner;
			
			switch (e.type) {
				case MouseEvent.MOUSE_OVER:
					var point:Point = corner.point;
					
					if ((point.x == 0 && isFirstPage()) || (point.x && isLastPage())) return;
					
					disableHover();
					
					TweenLite.killTweensOf(flipPoint, true);
					
					flipCorner = point.clone();
					
					flipPoint.x = flipCorner.x ? width / 2 : 0;
					flipPoint.y = flipCorner.y ? height : 0;
					
					frontFlippingPage = getPageAt(flipCorner.x ? rightIndex : leftIndex);
					backFlippingPage = getPageAt(flipCorner.x ? rightIndex + 1 : leftIndex - 1);
					rightVisiblePage = getPageAt(flipCorner.x ? rightIndex + 2 : rightIndex);
					leftVisiblePage = getPageAt(flipCorner.x ? leftIndex : leftIndex - 2);
					
					corner.addEventListener(MouseEvent.MOUSE_MOVE, handleHoverEvents);
					corner.addEventListener(MouseEvent.MOUSE_OUT, handleHoverEvents);
					
					TweenLite.to(flipPoint, fixFlipDuration(mouseX - render.x), { x:mouseX - render.x, y:mouseY, onUpdate:flipUpdate } );
					
					break;
					
				case MouseEvent.MOUSE_MOVE:
					TweenLite.to(flipPoint, fixFlipDuration(mouseX - render.x), { x:mouseX - render.x, y:mouseY, onUpdate:flipUpdate } );
					break;
					
				case MouseEvent.MOUSE_OUT:
					clearHover();
					
					var x:Number = flipCorner.x ? width / 2 : 0;
					var y:Number = flipCorner.y ? height : 0;
					
					TweenLite.to(flipPoint, fixFlipDuration(x), { x:x, y:y, onUpdate:flipUpdate, onComplete:flipEnded } );
					
					break;
			}
		}
		
		protected function enableHover():void
		{
			for each (var corner:Corner in corners) {
				corner.addEventListener(MouseEvent.MOUSE_OVER, handleHoverEvents);
			}
		}
		
		protected function disableHover():void
		{
			for each (var corner:Corner in corners) {
				corner.removeEventListener(MouseEvent.MOUSE_OVER, handleHoverEvents);
			}
		}
		
		protected function clearHover():void
		{
			for each (var corner:Corner in corners) {
				corner.removeEventListener(MouseEvent.MOUSE_MOVE, handleHoverEvents);
				corner.removeEventListener(MouseEvent.MOUSE_OUT, handleHoverEvents);
			}
		}
		
		protected function handleMouseFlipEvents(e:Event):void
		{
			switch (e.type) {
				case MouseEvent.CLICK:
					if (! (e.target is Page || e.target is Corner)) return;
					
					if (onLeftSide(mouseX)) {
						previousPage();
					} else {
						nextPage();
					}
					
					break;
					
				case MouseEvent.MOUSE_DOWN:
					if (! (e.target is Page || e.target is Corner)) return;
					
					if ((onLeftSide(mouseX) && isFirstPage()) || (onRightSide(mouseX) && isLastPage())) return;
					
					clearHover();
					disableHover();
					
					flipping = true;
					
					TweenLite.killTweensOf(flipPoint, true);
					
					flipCorner.x = onLeftSide(mouseX) ? 0 : 1;
					flipCorner.y = mouseY < height / 2 ? 0 : 1;
					
					frontFlippingPage = getPageAt(flipCorner.x ? rightIndex : leftIndex);
					backFlippingPage = getPageAt(flipCorner.x ? rightIndex + 1 : leftIndex - 1);
					rightVisiblePage = getPageAt(flipCorner.x ? rightIndex + 2 : rightIndex);
					leftVisiblePage = getPageAt(flipCorner.x ? leftIndex : leftIndex - 2);
					
					flipPoint.x = flipCorner.x ? width / 2 : 0;
					flipPoint.y = flipCorner.y ? height : 0;
					
					stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseFlipEvents);
					stage.addEventListener(Event.ENTER_FRAME, handleMouseFlipEvents);
					
					dispatchEvent(new BookEvent(BookEvent.FLIP_BEGIN));
					
					break;
					
				case MouseEvent.MOUSE_UP:
					stage.removeEventListener(Event.ENTER_FRAME, handleMouseFlipEvents);
					stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseFlipEvents);
					
					completeFlip();
					
					break;
					
				case Event.ENTER_FRAME:
					flipPoint.x = mouseX - render.x;
					flipPoint.y = mouseY;
					
					flipUpdate();
					
					break;
			}
		}
		
		/**
		 * Determine final x and y, the new left and right indexes, and complete the flipping animation
		 */
		protected function completeFlip():void
		{
			var x:Number;
			var y:Number;
			
			if (flipCorner.x) {
				x = onLeftSide(flipPoint.x + render.x) ? - width / 2 : width / 2;
				leftIndex += onLeftSide(flipPoint.x + render.x) ? 2 : 0;
			}
			else {
				x = onLeftSide(flipPoint.x + render.x) ? 0 : width;
				leftIndex -= onLeftSide(flipPoint.x + render.x) ? 0 : 2;
			}
			
			y = flipCorner.y ? height : 0;
			
			TweenLite.to(flipPoint, fixFlipDuration(x), { x:x, y:y, onUpdate:flipUpdate, onComplete:flipEnded } );
		}
		
		/**
		 *
		 * @param	flipX	Flip origin corner, 0 or 1
		 */
		protected function autoFlip(flipX:uint):void
		{
			var x:Number = flipX ? - width / 2 : width;
			TweenLite.to(flipPoint, fixFlipDuration(x), { x:x, bezierThrough:[ { y:height * .9 }, { y:height } ], onUpdate:flipUpdate, onComplete:flipEnded } );
		}
		
		/**
		 * Draw the page flip effect
		 */
		protected function flipUpdate():void
		{
			shadow.visible = false;
			
			var p:Point = flipPoint.clone();
			
			p.x = Math.round(p.x);
			p.y = Math.round(p.y);
			
			if (lastFlipPoint.x == p.x && lastFlipPoint.y == p.y) return;
			
			render.x = width / 2 * flipCorner.x;
			
			var ocf:Object = PageFlip.computeFlip(p.clone(), flipCorner,  width / 2, height, true, 1);
			
			var drawShadowFixed:Boolean = frontFlippingPage.index > 0 && frontFlippingPage.index < numPages - 1;
			var drawShadowFlippedIn:Boolean = backFlippingPage.index > 0 && backFlippingPage.index < numPages - 1;
			var drawShadowFlippedOut:Boolean = backFlippingPage.index > 0 && backFlippingPage.index < numPages - 1;
			var drawShadowFixed2:Boolean = frontFlippingPage.index > 0 && frontFlippingPage.index < numPages - 1;
			
			render.graphics.clear();
			
			PageFlip.drawBitmapSheet(ocf, render, bitmaps[0], bitmaps[1], drawShadowFixed, drawShadowFlippedIn, drawShadowFlippedOut, drawShadowFixed2);
			
			stage.invalidate();
			
			lastFlipPoint = p.clone();
		}
		
		/**
		 * Clean up after flip ended
		 */
		protected function flipEnded():void
		{
			leftVisiblePage = getPageAt(leftIndex);
			rightVisiblePage = getPageAt(rightIndex);
			
			render.graphics.clear();
			
			shadow.visible = (! isFirstPage() && ! isLastPage());
			
			flipping = false;
			
			enableHover();
			
			dispatchEvent(new BookEvent(BookEvent.FLIP_END));
		}
		
		/**
		 * Fix flipDuration according to distance from current flipPoint.x to final x
		 *
		 * @param	x final flip x
		 * @return fixed flip duration
		 */
		protected function fixFlipDuration(x:Number):Number
		{
			return Math.abs((flipPoint.x - x) / width) * flipDuration;
		}
		
		protected function isLeftPage(pageNum:int):Boolean
		{
			return (pageNum % 2 != 0);
		}
		
		protected function onLeftSide(x:Number):Boolean
		{
			return (x < width / 2);
		}
		
		protected function onRightSide(x:Number):Boolean
		{
			return (x > width / 2);
		}
		
	}

}