package com.robertgurgul.cms.message.gallery
{	
	public class GetGalleryMessage1
	{
		public static const GET_GALLERY:String = "GET_GALLERY";
		public static const LINK_PRODUCTS:String = "/assets/img/products/";
		public static const LINK_HOME_IMG:String = "/assets/img/home/";
		public static const LINK_MEMBERS:String = "/assets/img/members/";
		
		[Selector]
		public var type:String;
		public var link:String;
		
		public function GetGalleryMessage1(type:String, link:String)
		{
			this.type = type;
			this.link = link;
		}
		
	}
}