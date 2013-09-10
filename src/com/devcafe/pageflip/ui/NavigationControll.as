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
	import com.devcafe.pageflip.BookEvent;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class NavigationControll extends MovieClip
	{
		
		protected var _book:Book;
		
		public function get book():Book
		{
			return _book;
		}
		
		public function set book(value:Book):void
		{
			var oldValue:Book = _book;
			
			if (oldValue == value) return;
			
			if (oldValue) {
				oldValue.removeEventListener(BookEvent.PAGE_CHANGE, handlePageChange);
			}
			
			_book = value;
			
			if (value) {
				value.addEventListener(BookEvent.PAGE_CHANGE, handlePageChange);
			}
			
			handlePageChange();
		}
		
		public function NavigationControll()
		{
			super();
			
			addFrameScript(0, init);
		}
		
		protected function init():void
		{
			stop();
		}
		
		protected function handlePageChange(e:BookEvent = null):void
		{
			//
		}
		
	}

}