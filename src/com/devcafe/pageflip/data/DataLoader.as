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
package com.devcafe.pageflip.data
{
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class DataLoader extends EventDispatcher
	{
		
		protected var _data:Array;
		
		protected var _options:Object;
		
		public function get data():Array
		{
			return _data;
		}
		
		public function get options():Object
		{
			return _options;
		}
		
		public function DataLoader()
		{
			super();
		}
		
		public function load(url:String):void
		{
			//
		}
		
	}

}