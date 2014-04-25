package com.robertgurgul.cms.message.gallery
{
	public class RemoveGalleryImgMessage1
	{
		[Selector]
		public var type:String;
		
		public var tableName:String;
		public var id:int;
		
		public function RemoveGalleryImgMessage1(tableName:String, id:int)
		{
			this.tableName = tableName;
			this.id = id;
		}
	}
}