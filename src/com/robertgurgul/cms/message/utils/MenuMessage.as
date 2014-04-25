package com.robertgurgul.cms.message.utils
{	
	import mx.controls.Alert;

	public class MenuMessage
	{
		public static const GET_MENU:String = "GET_MENU";
		public static const ADD_MENU_ITEM:String = "ADD_MENU_ITEM";
		
		[Selector]
		public var type:String;
		
		public var itemName:String;
		public var itemKind:String;
			
		public function MenuMessage(type:String, itemName:String = '', itemKind:String = '')
		{
			this.type = type;
			this.itemName = itemName;
			this.itemKind = itemKind;
		}
	}
}