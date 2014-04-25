package com.robertgurgul.cms.message.gallery
{	
	import com.robertgurgul.cms.vo.GalleryVo;
	
	import mx.controls.Alert;
	
	public class GalleryMessage
	{	
		public static const ADD_GALLERY:String = "ADD_GALLERY";
		public static const GET_GALLERY_PORTFOLIO:String = "GET_GALLERY_PORTFOLIO";
		public static const GET_GALLERY_EDUKACJA:String = "GET_GALLERY_EDUKACJA";
		public static const REORDER_GALLERY:String = "REORDER_GALLERY";
		public static const LINK_PORTFOLIO:String = "/assets/img/portfolio/";
		public static const LINK_EDUKACJA:String = "/assets/img/edukacja/";
		public static const TABLE_PORTFOLIO:String = "portfolio";
		public static const TABLE_EDUKACJA:String = "edukacja";
		
		public static const GET_GALLERY_PRODUCTS:String = "GET_GALLERY_PRODUCTS";
		public static const LINK_PRODUCTS_FOLDER:String = "/assets/img/products/";
		public static const LINK_HOME_IMG_FOLDER:String = "/assets/img/home/";
		public static const LINK_MEMBERS:String = "/assets/img/members/";
		
		public static const REMOVE_IMG:String = "REMOVE_IMG";
		
		
		[Selector]
		public var type:String;
		
		public var galleryVo:GalleryVo;
		
		public function GalleryMessage(type:String, galleryVo:GalleryVo = null)
		{
			this.type = type;
			this.galleryVo = galleryVo;
		}
	}
}