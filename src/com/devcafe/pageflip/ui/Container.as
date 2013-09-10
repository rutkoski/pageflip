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
	import fl.core.UIComponent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class Container extends UIComponent
	{
		
		protected var content:Sprite;
		
		protected var _layout:ContainerLayout;
		
		protected var _contentWidth:Number = NaN;
		
		protected var _contentHeight:Number = NaN;
		
		public function get contentWidth():Number
		{
			return _contentWidth || content.width;
		}
		
		public function set contentWidth(value:Number):void
		{
			_contentWidth = value;
		}
		
		public function get contentHeight():Number
		{
			return _contentHeight || content.height;
		}
		
		public function set contentHeight(value:Number):void
		{
			_contentHeight = value;
		}
		
		public function get layout():ContainerLayout
		{
			return _layout;
		}
		
		public function set layout(value:ContainerLayout):void
		{
			var oldValue:ContainerLayout = _layout;
			
			if (oldValue == value) return;
			
			_layout = value;
			
			invalidate();
		}
		
		public function get numElements():int
		{
			return content.numChildren;
		}
		
		public function Container()
		{
			super();
		}
		
		public function addElement(e:DisplayObject):DisplayObject
		{
			content.addChild(e);
			
			invalidate(InvalidationType.DATA);
			
			return e;
		}
		
		public function addElementAt(e:DisplayObject, index:int):DisplayObject
		{
			content.addChildAt(e, index);
			
			invalidate(InvalidationType.DATA);
			
			return e;
		}
		
		public function containsElement(e:DisplayObject):Boolean
		{
			return content.contains(e);
		}
		
		public function getElementAt(index:int):DisplayObject
		{
			return content.getChildAt(index);
		}
		
		public function getElementIndex(e:DisplayObject):int
		{
			return content.getChildIndex(e);
		}
		
		public function removeElement(e:DisplayObject):DisplayObject
		{
			content.removeChild(e);
			
			invalidate(InvalidationType.DATA);
			
			return e;
		}
		
		public function removeElementAt(index:int):DisplayObject
		{
			var e:DisplayObject = content.removeChildAt(index);
			
			invalidate(InvalidationType.DATA);
			
			return e;
		}
		
		public function setElementIndex(e:DisplayObject, index:int):void
		{
			content.setChildIndex(e, index);
			
			invalidate(InvalidationType.SIZE);
		}
		
		public function swapElements(e1:DisplayObject, e2:DisplayObject):void
		{
			content.swapChildren(e1, e2);
			
			invalidate(InvalidationType.SIZE);
		}
		
		public function swapElementsAt(index1:int, index2:int):void
		{
			content.swapChildrenAt(index1, index2);
			
			invalidate(InvalidationType.SIZE);
		}
		
		public function getContainerBounds():Rectangle
		{
			return new Rectangle(0, 0, width, height);
		}
		
		public function getContentBounds():Rectangle
		{
			return new Rectangle(0, 0, contentWidth, contentHeight);
		}
		
		override protected function configUI():void
		{
			super.configUI();
			
			content = new Sprite;
			addChild(content);
		}
		
		override protected function draw():void
		{
			if (layout && isInvalid(InvalidationType.DATA, InvalidationType.SIZE)) {
				layout.update();
			}
			
			super.draw();
		}
		
	}

}