package com.robertgurgul.cms.command.homeImg
{
	import com.robertgurgul.cms.message.pages.HomeImgMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class AddHomeImgCommand
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg:HomeImgMessage): AsyncToken 
		{
			return service.addHomeImg(msg.homeImgVo);
		}
		
		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}