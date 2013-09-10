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
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class ButtonFullScreen extends Button
	{
		
		public var symbol:MovieClip;
		
		public function ButtonFullScreen()
		{
			super();
		}
		
		override protected function init():void
		{
			super.init();
			
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, handleFullScreen);
			
			screenState();
		}
		
		protected function handleFullScreen(e:FullScreenEvent):void
		{
			screenState();
		}
		
		override protected function handleClick(e:MouseEvent):void
		{
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				stage.displayState =  StageDisplayState.NORMAL;
				screenState();
			} else {
				stage.displayState =  StageDisplayState.FULL_SCREEN;
				screenState();
			}
			
			super.handleClick(e);
		}
		
		protected function screenState():void
		{
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				symbol.gotoAndStop(2);
			} else {
				symbol.gotoAndStop(1);
			}
		}
		
		override protected function upState():void
		{
			super.upState();
			screenState();
		}
		
		override protected function overState():void
		{
			super.overState();
			screenState();
		}
		
		override protected function downState():void
		{
			super.downState();
			screenState();
		}
		
		override protected function disabledState():void
		{
			super.disabledState();
			screenState();
		}
		
	}

}