package com.robertgurgul.cms.message.pages
{	
	import com.robertgurgul.cms.vo.PageVo;
	
	import mx.controls.Alert;

	public class PageMessage
	{
		public static const GET_PAGE:String = "GET_PAGE";
		public static const EDIT_PAGE:String = "EDIT_PAGE";
		
		[Selector]
		public var type:String;
		
		public var pageVo:PageVo;
			
		public function PageMessage(type:String, pageVo:PageVo = null)
		{
			this.type = type;
			this.pageVo = pageVo;
		}
	}
}