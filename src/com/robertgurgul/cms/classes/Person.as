package com.robertgurgul.cms.classes
{
	import mx.collections.ArrayCollection;
	
	public class Person{
		
		public var name:String;
		public var children:ArrayCollection;
		
		public function Person(_name:String, _children:ArrayCollection = null){
			this.name = _name;
			if(_children != null)
				this.children = _children;
		}
		
	}
	
}