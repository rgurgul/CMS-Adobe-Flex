package com.robertgurgul.cms.message.utils
{	
	import mx.collections.ArrayCollection;

	public class ReorderTableMessage
	{	
		public static const REORDER_TABLE:String = "REORDER_TABLE";
		
		[Selector]
		public var type:String;
		
		public var tableName:String;
		public var arr:ArrayCollection;
		
		public function ReorderTableMessage(type:String,
									tableName:String,
									arr:ArrayCollection)
		{
			this.type = type;
			this.tableName = tableName;
			this.arr = arr;
		}

	}
}