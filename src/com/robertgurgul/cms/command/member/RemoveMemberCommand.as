package com.robertgurgul.cms.command.member
{
	import com.robertgurgul.cms.message.pages.HomeImgMessage;
	import com.robertgurgul.cms.message.pages.MemberMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class RemoveMemberCommand
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg:MemberMessage): AsyncToken 
		{
			return service.removeMember(msg.memberVo.id);
		}
		
		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}