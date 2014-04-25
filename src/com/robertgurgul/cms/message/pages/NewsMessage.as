package com.robertgurgul.cms.message.pages
{	
	import com.robertgurgul.cms.vo.NewsVo;
	
	import mx.controls.Alert;

	public class NewsMessage
	{	
		public static const ADD_NEWS:String = "ADD_NEWS";
		public static const GET_NEWS:String = "GET_NEWS";
		public static const UPDATE_NEWS:String = "UPDATE_NEWS";
		public static const REMOVE_NEWS:String = "REMOVE_NEWS";
		public static const REORDER_NEWS:String = "REORDER_NEWS";
		
		[Selector]
		public var type:String;
		
		public var newsVo:NewsVo;
		
		public function NewsMessage(type:String, newsVo:NewsVo = null)
		{
			this.type = type;
			this.newsVo = newsVo;
		}
	}
}