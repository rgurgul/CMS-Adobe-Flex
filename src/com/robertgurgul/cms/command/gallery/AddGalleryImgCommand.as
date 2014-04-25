package com.robertgurgul.cms.command.gallery
{
	import com.robertgurgul.cms.message.gallery.AddGalleryImgMessage;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.remoting.RemoteObject;
	
	public class AddGalleryImgCommand 
	{
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		public function execute (msg:AddGalleryImgMessage): AsyncToken 
		{
			return service.addGalleryImg(msg.galleryName, msg.imgName, msg.imgDir);
		}
		
		public function error (fault: Fault): void {
			Alert.show(fault.toString());
		}
	}
}