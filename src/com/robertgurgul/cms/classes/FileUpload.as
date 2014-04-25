package com.robertgurgul.cms.classes
{
	import com.robertgurgul.cms.remoting.*;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import mx.controls.Alert;
	import mx.controls.TextInput;
	import mx.rpc.remoting.RemoteObject;
	
	
	public class FileUpload extends EventDispatcher
	{
		private var fileRef:FileReference = new FileReference();
		private var imageURL:TextInput;
		public static var objFileUpload:FileUpload;
		
		[Inject(id="loginService")]
		public var service:RemoteObject;
		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		private var request:URLRequest;
		public var loadedImg:String;

		public static function getInstance():FileUpload
		{
			if(objFileUpload == null)
			{
				objFileUpload = new FileUpload;
			}
			return objFileUpload;
		}
		
		public function fileUpload(dir:String):void
		{
			var imageTypes:FileFilter = new FileFilter("Files (*.jpg, *.jpeg, *.gif, *.png, *.pdf)", "*.jpg; *.jpeg; *.gif; *.png; *.pdf"); 
			var allTypes:Array = new Array(imageTypes);
			
			fileRef.browse(allTypes);
			
			fileRef.addEventListener(Event.SELECT, selectHandler); 
			fileRef.addEventListener(Event.COMPLETE, completeHandler);
			fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, uploadDataComplete);
			
			var urlVars:URLVariables = new URLVariables();
			urlVars.targetFolder     = dir;
			
			request = new URLRequest("../amfphp/services/yourUploadHandlerScript.php")
			request.method        = "post";
			request.data          = urlVars;
		}
		
		public function uploadDataComplete(event:DataEvent):void 
		{
			loadedImg = event.data;
			dispatchEvent( new Event("uploadDataComplete", true) );
		}
		
		public function fileRemove(data:*):void
		{
			Alert.show(data.data.name);
		}
		private function selectHandler(event:Event):void 
		{ 
			try 
			{ 
				fileRef.upload(request); 
			} 
			catch (error:Error) 
			{ 
				Alert.show("Unable to upload file.");
			}
		} 
		private function completeHandler(event:Event):void 
		{ 
			
		}
	}
}