package com.robertgurgul.cms.message.utils
{
	public class ContactMessage
	{
		public var title:String;
		public var email:String;
		public var desc:String;
		
		public function ContactMessage(title:String, email:String, desc:String)
		{
			this.title = title;
			this.email = email;
			this.desc = desc;
		}
	}
}