package com.robertgurgul.cms.message.pages
{	
	import com.robertgurgul.cms.vo.ProductVo;

	public class ProductsMessage
	{	
		public static const GET_PRODUCTS:String = "GET_PRODUCT";
		public static const ADD_PRODUCT:String = "ADD_PRODUCT";
		public static const UPDATE_PRODUCT:String = "UPDATE_PRODUCT";
		public static const REMOVE_PRODUCT:String = "REMOVE_PRODUCT";
		public static const REORDER_PRODUCT:String = "REORDER_PRODUCT";
		public static const SHOW_PRODUCT_WIN:String = "SHOW_PRODUCT_WIN";
		
		[Selector]
		public var type:String;
		
		public var productVo:ProductVo;
		
		public function ProductsMessage(type:String, productVo:ProductVo = null)
		{
			this.type = type;
			this.productVo = productVo;
		}
	}
}