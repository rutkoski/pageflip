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
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class Button extends NavigationControll
	{
		
		override public function get enabled():Boolean
		{
			return super.enabled;
		}
		
		override public function set enabled(value:Boolean):void
		{
			var oldValue:Boolean = super.enabled;
			
			if (oldValue == value) return;
			
			super.enabled = value;
			
			if (value) {
				upState();
			} else {
				disabledState();
			}
		}
		
		public function Button()
		{
			super();
		}
		
		override protected function init():void
		{
			super.init();
			
			mouseChildren = false;
			buttonMode = true;
			
			addEventListener(MouseEvent.MOUSE_OVER, handleMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		protected function handleClick(e:MouseEvent):void
		{
			//
		}
		
		protected function handleMouseUp(e:MouseEvent):void
		{
			if (enabled) {
				overState();
			}
		}
		
		protected function handleMouseDown(e:MouseEvent):void
		{
			if (enabled) {
				downState();
			}
		}
		
		protected function handleMouseOut(e:MouseEvent):void
		{
			if (enabled) {
				upState();
			}
		}
		
		protected function handleMouseOver(e:MouseEvent):void
		{
			if (enabled) {
				overState();
			}
		}
		
		protected function upState():void
		{
			gotoAndStop('up');
		}
		
		protected function downState():void
		{
			gotoAndStop('down');
		}
		
		protected function overState():void
		{
			gotoAndStop('over');
		}
		
		protected function disabledState():void
		{
			gotoAndStop('disabled');
		}
		
	}

}