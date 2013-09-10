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
package com.devcafe.pageflip.data
{
	import com.devcafe.pageflip.Book;
	import com.devcafe.pageflip.BookEvent;
	import com.devcafe.pageflip.Page;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class LoaderQueue
	{
		
		protected var book:Book;
		
		protected var page:Page;
		
		protected var lastIndex:Number = 0;
		
		public function LoaderQueue(book:Book)
		{
			this.book = book;
		}
		
		public function loadNext():void
		{
			if (! book.numPages) return;
			
			var i:Number = lastIndex;
			while (i < book.numPages && book.getPageAt(i).thumb) {
				i++;
			}
			
			lastIndex = i;
			
			if (i < book.numPages) {
				load(book.getPageAt(i));
			}
		}
		
		protected function load(page:Page):void
		{
			this.page = page;
			
			page.addEventListener(BookEvent.PAGE_LOADED, handleLoadComplete);
			page.loadNow();
		}
		
		protected function handleLoadComplete(e:BookEvent):void
		{
			page.removeEventListener(BookEvent.PAGE_LOADED, handleLoadComplete);
			
			//if (! page.stage) page.unload();
			
			loadNext();
		}
		
	}

}