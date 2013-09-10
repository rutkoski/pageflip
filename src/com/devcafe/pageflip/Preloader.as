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
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class Preloader extends MovieClip
	{
		
		protected var _contentLoaderInfo:LoaderInfo;
		
		public function get contentLoaderInfo():LoaderInfo
		{
			return _contentLoaderInfo;
		}
		
		public function set contentLoaderInfo(value:LoaderInfo):void
		{
			_contentLoaderInfo = value;
			
			contentLoaderInfo.addEventListener(Event.INIT, handleInit);
			contentLoaderInfo.addEventListener(Event.COMPLETE, handleComplete);
			contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, handleProgress);
		}
		
		public function Preloader()
		{
			super();
		}
		
		protected function handleInit(e:Event):void
		{
			visible = true;
		}
		
		protected function handleProgress(e:ProgressEvent):void
		{
			//
		}
		
		protected function handleComplete(e:Event):void
		{
			visible = false;
		}
		
	}

}