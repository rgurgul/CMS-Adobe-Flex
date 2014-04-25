package com.robertgurgul.cms.classes
{	
	
	import com.robertgurgul.cms.model.*;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.controls.Alert;
	import mx.controls.Tree;
	
	[Bindable] public class Controller 
	{
		public static var objControl:Controller;
		
		public var btnSaveEnabled:Boolean;
		
		public var lastClick:String;
		
		public static function getInstance():Controller
		{
			if(objControl == null)
			{
				objControl = new Controller;
			}
			
			return objControl;
		}
		
		public function showLink(menu:Tree):void
		{
			
			if(!menu.selectedItem) Alert.show('proszę wybrać zakładkę z menu');
			
			var href:String;
			
			switch(menu.selectedItem.kindCMS)
			{
				case "text":
					href = menu.selectedItem.link;
					break;
				case "post":
					href = 'posts/' + menu.selectedItem.id;
					break;
				case "lista":
					href = 'list/' + menu.selectedItem.id;
					break;				
			}
			
			navigateToURL( new URLRequest(Utils.path + href), '_blank' );
		}
	}
}