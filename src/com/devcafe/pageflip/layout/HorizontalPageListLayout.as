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
package com.devcafe.pageflip.layout
{
	import com.devcafe.pageflip.PageList;
	import com.devcafe.pageflip.PageListItem;
	import com.devcafe.pageflip.ui.Container;
	import com.devcafe.pageflip.ui.ContainerLayout;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class HorizontalPageListLayout extends ContainerLayout
	{
		
		public var padding:Number = 10;
		
		protected function get list():PageList
		{
			return container as PageList;
		}
		
		public function HorizontalPageListLayout(list:PageList)
		{
			super(list as Container);
		}
		
		override public function update():void
		{
			if (! list.book) return;
			
			var item:PageListItem;
			
			var i:Number;
			
			var p:Number = list.book.width / 2 / list.book.height;
			
			var h:Number = (list.height - padding - padding);
			var w:Number = h * p;
			
			var x:Number = padding;
			var y:Number = padding;
			
			for (i = 0; i < list.numElements; i++) {
				item = list.getElementAt(i) as PageListItem;
				item.setSize(w, h);
				item.move(x, y);
				item.drawNow();
				
				x += item.width + padding;
			}
			
			list.contentWidth = x;
			list.contentHeight = list.height;
		}
		
	}

}