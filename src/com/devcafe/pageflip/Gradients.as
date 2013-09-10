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
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class Gradients
	{
		
		// --- shadow / gradient params
		public static var shadowLength:Number= 0x33;
		public static var shadowAlpha:Number= 0.2;
		public static var shadowFill:String = GradientType.LINEAR;
		public static var shadowColorsL:Array = [0xFFFFFF, 0x000000];
		public static var shadowAlphasL:Array = [0, shadowAlpha];
		public static var shadowRatiosL:Array = [0xFF-shadowLength, 0xFF];
		public static var shadowColorsR:Array = [0x000000, 0xFFFFFF];
		public static var shadowAlphasR:Array = [shadowAlpha, 0];
		public static var shadowRatiosR:Array = [0x00, shadowLength];
		public static var shadowSpread:String = SpreadMethod.PAD;
		
		public static function drawShadowFixed(ocf:Object, mc:Shape):void{

			// affectations
			var wid:Number=ocf.width;
			var hei:Number=ocf.height;
			var nb:Number;
			var ppts:Array=ocf.pPoints;
			var cpts:Array=ocf.cPoints;
			var spts:Array=ocf.sPoints;
			
			var shadowMatFixed:Matrix = new Matrix();
			
			shadowMatFixed.createGradientBox(wid, hei, 0, 0, 0);

			
			// draw the shadow on the fixed side
			if (ocf.pt.x == 0) {
				mc.graphics.beginGradientFill(shadowFill, shadowColorsL, shadowAlphasL, shadowRatiosL, shadowMatFixed, shadowSpread);
			}
			else {
				mc.graphics.beginGradientFill(shadowFill, shadowColorsR, shadowAlphasR, shadowRatiosR, shadowMatFixed, shadowSpread);
			}
			nb=ppts.length;
			mc.graphics.moveTo(ppts[nb - 1].x, ppts[nb - 1].y);
			while (--nb >= 0) mc.graphics.lineTo(ppts[nb].x, ppts[nb].y);
			mc.graphics.endFill();
		}
		
		public static function drawShadowFixed2(ocf:Object, mc:Shape):void{

			// affectations
			var wid:Number=ocf.width;
			var hei:Number=ocf.height;
			var nb:Number;
			var ppts:Array=ocf.pPoints;
			var cpts:Array=ocf.cPoints;
			var spts:Array=ocf.sPoints;
			
			var shadowMatFixed:Matrix = new Matrix();
			
			shadowMatFixed.createGradientBox(wid, hei, 0, 0, 0);

			if (ocf.pt.x) {
				shadowMatFixed.translate( - wid, 0);
			} else {
				shadowMatFixed.translate(wid, 0);
			}
			
			if (ocf.pt.x) {
				mc.graphics.beginGradientFill(shadowFill, shadowColorsL, shadowAlphasL, shadowRatiosL, shadowMatFixed, shadowSpread);
			}
			else {
				mc.graphics.beginGradientFill(shadowFill, shadowColorsR, shadowAlphasR, shadowRatiosR, shadowMatFixed, shadowSpread);
			}
			nb=ppts.length;
			
			if (ocf.pt.x) {
				mc.graphics.moveTo(0, 0);
				mc.graphics.lineTo(- wid, 0);
				mc.graphics.lineTo( - wid, hei);
				mc.graphics.lineTo(0, hei);
				mc.graphics.lineTo(0, 0);
			} else {
				mc.graphics.moveTo(wid, 0);
				mc.graphics.lineTo(wid * 2, 0);
				mc.graphics.lineTo(wid * 2, hei);
				mc.graphics.lineTo(wid, hei);
				mc.graphics.lineTo(wid, 0);
			}
			
			mc.graphics.endFill();
		}
		
		public static function drawShadowFlippedIn(ocf:Object, mc:Shape):void
		{
			// affectations
			var wid:Number=ocf.width;
			var hei:Number=ocf.height;
			var nb:Number;
			var ppts:Array=ocf.pPoints;
			var cpts:Array=ocf.cPoints;
			var spts:Array=ocf.sPoints;
			
			var shadowMatFixed:Matrix = new Matrix();
			var shadowMatFlippedIn:Matrix = new Matrix();
			
			shadowMatFixed.createGradientBox(wid, hei, 0, 0, 0);
			
			// draw the inside shadow on the flipped side
			shadowMatFlippedIn= shadowMatFixed.clone();
			shadowMatFlippedIn.concat(ocf.shadowMatFlippedIn);
			
			if (cpts != null) {
				//mc.graphics.beginBitmapFill(bmp1, ocf.shadowMatFlippedIn, false, true);
				if (ocf.pt.x == 0) {
					mc.graphics.beginGradientFill(shadowFill, shadowColorsR, shadowAlphasR, shadowRatiosR, shadowMatFlippedIn, shadowSpread);
				}
				else {
					mc.graphics.beginGradientFill(shadowFill, shadowColorsL, shadowAlphasL, shadowRatiosL, shadowMatFlippedIn, shadowSpread);
				}
				nb=cpts.length;
				mc.graphics.moveTo(cpts[nb-1].x,cpts[nb-1].y);
				while (--nb>=0)mc.graphics.lineTo(cpts[nb].x,cpts[nb].y);
				mc.graphics.endFill();
			}
		}
		
		public static function drawShadowFlippedOut(ocf:Object, mc:Shape):void{

			// affectations
			var wid:Number=ocf.width;
			var hei:Number=ocf.height;
			var nb:Number;
			var ppts:Array=ocf.pPoints;
			var cpts:Array=ocf.cPoints;
			var spts:Array=ocf.sPoints;
			
			var shadowMatFixed:Matrix = new Matrix();
			var shadowMatFlippedOut:Matrix = new Matrix();
			
			shadowMatFixed.createGradientBox(wid, hei, 0, 0, 0);

			// draw the outside shadow on the flipped side
			shadowMatFlippedOut= shadowMatFixed.clone();
			shadowMatFlippedOut.concat(ocf.shadowMatFlippedOut);
		
			if (cpts != null) {
				//mc.graphics.beginBitmapFill(bmp1, ocf.shadowMatFlippedOut, false, true);
				if (ocf.pt.x == 0) {
					mc.graphics.beginGradientFill(shadowFill, shadowColorsL, shadowAlphasL, shadowRatiosL, shadowMatFlippedOut, shadowSpread);
				}
				else {
					mc.graphics.beginGradientFill(shadowFill, shadowColorsR, shadowAlphasR, shadowRatiosR, shadowMatFlippedOut, shadowSpread);
				}
				nb= spts.length;
				mc.graphics.moveTo(spts[nb-1].x, spts[nb-1].y);
				while (--nb>=0)mc.graphics.lineTo(spts[nb].x, spts[nb].y);
				mc.graphics.endFill();
			}
		}
		
	}

}