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
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class Corner extends Sprite
	{
		
		public var point:Point;
		
		protected var s:uint;
		
		public function Corner(x:Number, y:Number, s:uint = 100)
		{
			this.s = s;
			
			point = new Point(x, y);
			
			buttonMode = true;
			focusRect = false;
			
			super();
		}
		
		public function position(width:Number, height:Number):void
		{
			graphics.clear();
			
			var w:Number = s * (point.x ? -1 : 1);
			var h:Number = s * (point.y ? -1 : 1);
			
			graphics.beginFill(0x00ff00, 0);
			graphics.moveTo(0, 0);
			graphics.lineTo(w, 0);
			graphics.lineTo(w, h);
			graphics.lineTo(0, h);
			graphics.lineTo(0, 0);
			graphics.endFill();
			
			x = point.x * width;
			y = point.y * height;
		}
		
	}

}