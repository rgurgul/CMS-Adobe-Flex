package com.robertgurgul.cms.message.utils
{
	public class LoginMessage
	{
		public static const LOGIN_SUCCESS:String = "success";
		public static const LOGIN_FAULT:String = "fault";
		public static const LOGIN_CHECK:String = "check";
		
		[Selector]
		public var type:String;
		
		public var login:String;
		public var pass:String;
		
		public function LoginMessage(type:String, login:String = '', pass:String = '')
		{
			this.type = type;
			this.login = login;
			this.pass = pass;
		}	
	}
}