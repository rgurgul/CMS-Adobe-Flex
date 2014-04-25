package com.robertgurgul.cms.classes 
{

	
	[Bindable] public class Config
	{
		private static var m_objConfig:Config;
		public var menu:Object = new Object();
		/*public var sub1:Boolean;
		public var sub2:Boolean;*/
		
		public var pathURL:String;
		
		public static function getInstance():Config
		{
			if(m_objConfig == null)
				m_objConfig = new Config();
			
			return m_objConfig;
		}
		
		
	}
}