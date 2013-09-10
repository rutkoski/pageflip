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
	import com.devcafe.pageflip.BookEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class ButtonLast extends Button
	{
		
		public function ButtonLast()
		{
			super();
		}
		
		override protected function handlePageChange(e:BookEvent = null):void
		{
			enabled = ! book.isLastPage();
			
			super.handlePageChange(e);
		}
		
		override protected function handleClick(e:MouseEvent):void
		{
			book.lastPage();
			
			super.handleClick(e);
		}
		
	}

}