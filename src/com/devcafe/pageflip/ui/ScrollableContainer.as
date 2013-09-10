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
	import fl.core.InvalidationType;
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class ScrollableContainer extends Container
	{
		
		protected var _verticalScrollPosition:Number = 0;
		
		protected var _horizontalScrollPosition:Number = 0;
		
		public function get verticalScrollPosition():Number
		{
			return _verticalScrollPosition;
		}
		
		public function set verticalScrollPosition(value:Number):void
		{
			var oldValue:Number = _verticalScrollPosition;
			
			if (oldValue == value) return;
			
			_verticalScrollPosition = Math.max(Math.min(0, value), maxVerticalScrollPosition);
			
			invalidate(InvalidationType.SCROLL);
		}
		
		public function get horizontalScrollPosition():Number
		{
			return _horizontalScrollPosition;
		}
		
		public function set horizontalScrollPosition(value:Number):void
		{
			var oldValue:Number = _horizontalScrollPosition;
			
			if (oldValue == value) return;
			
			_horizontalScrollPosition = Math.max(Math.min(0, value), maxHorizontalScrollPosition);
			
			invalidate(InvalidationType.SCROLL);
		}
		
		public function get maxHorizontalScrollPosition():Number
		{
			return contentWidth >= width ? width - contentWidth : 0;
		}
		
		public function get maxVerticalScrollPosition():Number
		{
			return contentHeight >= height ? height - contentHeight : 0;
		}
		
		public function ScrollableContainer()
		{
			super();
		}
		
		public function setScrollPosition(v:Number, h:Number):void
		{
			verticalScrollPosition = v;
			horizontalScrollPosition = h;
		}
		
		override protected function draw():void
		{
			if (isInvalid(InvalidationType.SCROLL)) {
				content.x = horizontalScrollPosition;// * (getContainerBounds().width - getContentBounds().width);
				content.y = verticalScrollPosition;// * (getContainerBounds().height - getContentBounds().height);
			}
			
			super.draw();
		}
		
	}

}