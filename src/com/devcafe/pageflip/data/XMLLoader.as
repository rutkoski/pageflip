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
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class XMLLoader extends DataLoader
	{
		
		protected var loader:URLLoader;
		
		public function XMLLoader()
		{
			super();
		}
		
		override public function load(url:String):void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, handleLoadComplete);
			loader.load(new URLRequest(url));
		}
		
		protected function handleLoadComplete(e:Event):void
		{
			_data = [];
			_options = { };
			
			var attribute:XML;
			
			var xml:XML = new XML(loader.data);
			
			for each (attribute in xml.attributes()) {
				_options[attribute.localName()] = attribute;
			}
			
			for each (var node:XML in xml.pages.page) {
				var page:Object = { };
				
				for each (attribute in node.attributes()) {
					page[attribute.localName()] = attribute;
				}
				
				_data.push(page);
			}
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}

}