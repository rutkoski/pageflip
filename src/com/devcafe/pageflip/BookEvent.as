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
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class BookEvent extends Event
	{
		
		public static var PAGE_CHANGE:String = 'pageChange';
		
		public static var PAGE_LOADED:String = 'pageLoaded';
		
		public static var FLIP_BEGIN:String = 'flipBegin';
		
		public static var FLIP_END:String = 'flipEnd';
		
		public function BookEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new BookEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("BookEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
	
}