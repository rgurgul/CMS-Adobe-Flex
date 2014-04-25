package com.robertgurgul.cms.message.gallery
{	
	import mx.controls.Alert;
	
	public class AddGalleryImgMessage
	{	
		public static const ADD_GALLERY_PORTFOLIO:String = "ADD_GALLERY_PORTFOLIO";
		public static const ADD_GALLERY_EDUKACJA:String = "ADD_GALLERY_EDUKACJA";
		public static const TABLE_PORTFOLIO:String = "portfolio";
		public static const TABLE_EDUKACJA:String = "edukacja";
		
		
		[Selector]
		public var type:String;
		
		public var galleryName:String;
		public var imgName:String;
		public var imgDir:String;
		
		public function AddGalleryImgMessage(type:String, galleryName:String, imgName:String, imgDir:String):void
		{
			this.type = type;
			this.galleryName = galleryName;
			this.imgName = imgName;
			this.imgDir = imgDir;
		}
	}
}