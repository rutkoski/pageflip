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
	import com.devcafe.pageflip.layout.HorizontalPageListLayout;
	import com.devcafe.pageflip.layout.PageListLayout;
	import com.devcafe.pageflip.ui.ScrollableContainer;
	import fl.core.InvalidationType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class PageList extends ScrollableContainer
	{
		
		protected var _book:Book;
		
		protected var maskClip:Sprite;
		
		public function get book():Book
		{
			return _book;
		}
		
		public function set book(value:Book):void
		{
			var oldValue:Book = _book;
			
			if (oldValue == value) return;
			
			_book = value;
			
			invalidate();
		}
		
		public function PageList()
		{
			super();
		}
		
		override protected function configUI():void
		{
			super.configUI();
			
			maskClip = new Sprite;
			maskClip.graphics.beginFill(0x00FF00);
			maskClip.graphics.drawRect(0, 0, 1, 1);
			addChild(maskClip);
			
			mask = maskClip;
			
			if (width > height) {
				layout = new HorizontalPageListLayout(this);
			} else {
				layout = new PageListLayout(this);
			}
		}
		
		protected function handleItemClick(e:MouseEvent):void
		{
			book.gotoPage(PageListItem(e.currentTarget).page.index + 1);
		}
		
		override protected function draw():void
		{
			if (isInvalid(InvalidationType.DATA)) {
				while (numElements) {
					removeElementAt(0);
				}
				
				if (book) {
					for (var i:int = 0; i < book.numPages; i++) {
						var item:PageListItem = new PageListItem;
						item.page = book.getPageAt(i);
						item.addEventListener(MouseEvent.CLICK, handleItemClick);
						
						addElement(item);
					}
				}
			}
			
			if (isInvalid(InvalidationType.SIZE)) {
				maskClip.width = width;
				maskClip.height = height;
			}
			
			super.draw();
		}
		
	}

}