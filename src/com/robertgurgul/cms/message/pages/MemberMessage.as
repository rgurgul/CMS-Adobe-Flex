package com.robertgurgul.cms.message.pages
{
	import com.robertgurgul.cms.vo.MemberVo;
	
	import mx.controls.Alert;

	public class MemberMessage
	{
		public static const GET_MEMBERS:String = "GET_MEMBERS"; 
		public static const ADD_MEMBER:String = "ADD_MEMBER"; 
		public static const UPDATE_MEMBER:String = "UPDATE_MEMBER";
		public static const REMOVE_MEMBER:String = "REMOVE_MEMBER"; 
		
		[Selector]
		public var type:String;
		
		public var memberVo:MemberVo;
		
		public function MemberMessage(type:String, memberVo:MemberVo = null)
		{
			this.type = type;
			this.memberVo = memberVo;
		}
	}
}