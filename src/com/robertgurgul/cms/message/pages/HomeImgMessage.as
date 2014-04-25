package com.robertgurgul.cms.message.pages
{	
	import com.robertgurgul.cms.vo.HomeImgVo;
	
	import mx.controls.Alert;
	
	public class HomeImgMessage
	{	
		public static const ADD_IMG:String = "ADD_IMG";
		public static const GET_IMGS:String = "GET_IMG";
		public static const EDIT_IMG:String = "EDIT_IMG";
		public static const REMOVE_IMG:String = "REMOVE_IMG";
		
		[Selector]
		public var type:String;
		
		public var homeImgVo:HomeImgVo;
		
		
		public function HomeImgMessage(type:String, homeImgVo:HomeImgVo = null)
		{
			this.type = type;
			this.homeImgVo = homeImgVo;
		}
	}
}