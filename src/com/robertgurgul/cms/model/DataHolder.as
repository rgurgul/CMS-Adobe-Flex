package com.robertgurgul.cms.model
{	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.controls.Alert;
	
	/**
	 * DataHolder class represent all data which needs to be stored 
	 * or needs to be used by any of the classes.
	 * It also dispatches events on adding a new event from any of the views.
	 * It is a singletone class so only single instance will be created through out the application cycle.
	*/
	[Bindable] public class DataHolder extends EventDispatcher 
	{
		import flash.events.EventDispatcher;
		
		public static var objDataHolder:DataHolder;
		
		private var m_arrEvents:Array; 
		private var page:Object = new Object;
		public var posts:IList;
		public var editPost:Object = new Object();
		private var photos:ArrayCollection;
		public var pdfs:ArrayCollection;
		public var menu:ArrayCollection = new ArrayCollection();
		public var sub1:ArrayCollection = new ArrayCollection();
		public var currentPage:Object = new Object();
		public var linkuj:String;
		
		public function DataHolder()
		{
			m_arrEvents = new Array();
		}
		
		// return class instance and if it is not created then create it first and the return.
		public static function getInstance():DataHolder
		{
			if(objDataHolder == null)
			{
				objDataHolder = new DataHolder;
			}
			
			return objDataHolder;
		}
		
		public function set dataPage(obj:Object):void
		{
			page = obj;
		}
		
		public function get dataPage():Object
		{
			return page;
		}
		public function set dataPhotos(obj:ArrayCollection):void
		{
			photos = obj;
		}
		
		public function get dataPhotos():ArrayCollection
		{
			return photos;
		}
		public function set dataMenu(obj:ArrayCollection):void
		{
			menu = obj;
		}
		
		public function get dataMenu():ArrayCollection
		{
			dispatchEvent( new Event("refreshMenu", true) );
			return menu;
		}
	}
}