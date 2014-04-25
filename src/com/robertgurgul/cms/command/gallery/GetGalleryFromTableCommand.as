package com.robertgurgul.cms.command.gallery
{
	import com.robertgurgul.cms.message.gallery.GalleryMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class GetGalleryFromTableCommand
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg:GalleryMessage): AsyncToken 
		{
			return service.getGalleryFromTable(msg.galleryVo.table);
		}
		
		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}