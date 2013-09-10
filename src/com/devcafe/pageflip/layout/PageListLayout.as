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
	public class PageListLayout extends ContainerLayout
	{
		
		public var padding:Number = 10;
		
		public var gap:Number = 2;
		
		protected function get list():PageList
		{
			return container as PageList;
		}
		
		public function PageListLayout(list:PageList)
		{
			super(list as Container);
		}
		
		override public function update():void
		{
			if (! list.book) return;
			
			var item:PageListItem;
			
			var i:Number;
			
			var p:Number = list.book.width / 2 / list.book.height;
			
			var w:Number = (list.width - padding - padding - gap) / 2;
			var h:Number = w / p;
			
			var y:Number = padding;
			
			var even:Boolean = true;
			
			for (i = 0; i < list.numElements; i++) {
				var x:Number = even ? padding + gap + w : padding;
				
				item = list.getElementAt(i) as PageListItem;
				item.setSize(w, h);
				item.move(x, y);
				item.drawNow();
				
				if (even) {
					y += item.height + padding;
				}
				
				even = ! even;
			}
			
			y += item.height + padding;
			
			list.contentWidth = list.width;
			list.contentHeight = y;
		}
		
	}

}