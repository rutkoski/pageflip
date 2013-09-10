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
package com.devcafe.pageflip.ui
{
	import com.devcafe.pageflip.Book;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class NavigationMenu extends MovieClip
	{
		
		public var firstBtn:NavigationControll;
		
		public var previousBtn:NavigationControll;
		
		public var nextBtn:NavigationControll;
		
		public var lastBtn:NavigationControll;
		
		public var pageInput:NavigationControll;
		
		public var background:Sprite;
		
		protected var _book:Book;
		
		protected var inited:Boolean = false;
		
		protected var buttons:Array = [];
		
		public function get book():Book
		{
			return _book;
		}
		
		public function set book(value:Book):void
		{
			var oldValue:Book = _book;
			
			if (oldValue == value) return;
			
			_book = value;
			
			firstBtn.book = book;
			previousBtn.book = book;
			nextBtn.book = book;
			lastBtn.book = book;
			pageInput.book = book;
		}
		
		public function NavigationMenu()
		{
			super();
			
			addFrameScript(0, init);
		}
		
		protected function init():void
		{
			stop();
			
			buttons.push(firstBtn);
			buttons.push(previousBtn);
			buttons.push(pageInput);
			buttons.push(nextBtn);
			buttons.push(lastBtn);
			
			stage.addEventListener(Event.RESIZE, draw);
			
			draw();
			
			inited = true;
		}
		
		protected function draw(e:Event = null):void
		{
			background.width = stage.stageWidth;
			
			var x:Number;
			var w:Number = 0;
			var gap:Number = 10;
			var button:DisplayObject;
			
			for each (button in buttons) {
				w += button.width + gap;
			}
			w -= gap;
			
			x = (stage.stageWidth - w) / 2;
			
			for each (button in buttons) {
				if (inited) {
					TweenLite.to(button, 1, { x: x } );
				} else {
					button.x = x;
				}
				
				x += button.width + gap;
			}
		}
		
	}

}