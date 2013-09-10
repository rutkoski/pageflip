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
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class Resize
	{
		
		public static function outside(containerWidth:Number, containerHeight:Number, contentWidth:Number, contentHeight:Number):Point
		{
			var w1:Number = containerWidth;
			var h1:Number = containerHeight;
			
			var w0:Number = contentWidth;
			var h0:Number = contentHeight;
			
			var w2:Number = w1;
			var h2:Number = h1;
			
			var prop:Number;
			
			if ((w0 / h0) > (w1 / h1)) {
				h2 = h1;
				prop = h2 / h0;
				w2 = w0 * prop;
			} else {
				w2 = w1;
				prop = w2 / w0;
				h2 = h0 * prop;
			}
			
			return new Point(w2, h2);
		}
		
		public static function inside(containerWidth:Number, containerHeight:Number, contentWidth:Number, contentHeight:Number):Point
		{
			var w1:Number = containerWidth;
			var h1:Number = containerHeight;
			
			var w0:Number = contentWidth;
			var h0:Number = contentHeight;
			
			var w2:Number = w1;
			var h2:Number = h1;
			
			var prop:Number;
			
			if ((w0 / h0) > (w1 / h1)) {
				w2 = w1;
				prop = w2 / w0;
				h2 = h0 * prop;
			} else {
				h2 = h1;
				prop = h2 / h0;
				w2 = w0 * prop;
			}
			
			return new Point(w2, h2);
		}
		
	}

}