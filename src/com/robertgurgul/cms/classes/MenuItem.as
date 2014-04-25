package com.robertgurgul.cms.classes{
	
	import mx.collections.ArrayCollection;
	
	public class MenuItem
	{	
		public var id:int;
		public var name:String;
		public var kat:String;
		public var id_parent:int;
		public var link:String;
		public var kindCMS:String;
		public var show_stat:int;
		public var children:ArrayCollection = new ArrayCollection();
		
		public function MenuItem(_id:int, _name:String, _kat:String,  _id_parent:int, _link:String, _kindCMS:String, _show_stat:int, _children:ArrayCollection = null)
		{
			this.id = _id;
			this.name = _name;
			this.kat = _kat;
			this.id_parent = _id_parent;
			this.link = _link;
			this.kindCMS = _kindCMS;
			this.show_stat = _show_stat;
		}
		public function addChildren(_children:Object = null):void
		{
				this.children.addItem(_children);
		}
		
		
	}
	
}