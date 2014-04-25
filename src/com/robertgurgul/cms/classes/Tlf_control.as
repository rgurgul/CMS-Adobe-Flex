package com.robertgurgul.cms.classes
{
	import com.robertgurgul.cms.model.*;
	import com.robertgurgul.cms.remoting.*;
	import com.robertgurgul.cms.view.*;
	import com.robertgurgul.cms.view.BottomBar.ControlTextBar;
	import com.robertgurgul.cms.view.BottomBar.GraphicBar;
	
	import flash.events.*;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.edit.ElementRange;
	import flashx.textLayout.edit.IEditManager;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.elements.*;
	import flashx.textLayout.events.SelectionEvent;
	import flashx.textLayout.formats.FormatValue;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextDecoration;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.undo.IUndoManager;
	import flashx.undo.UndoManager;
	
	import mx.controls.TextInput;
	import mx.core.FlexGlobals;
	import mx.events.ColorPickerEvent;
	
	import spark.components.RichEditableText;
	import spark.events.IndexChangeEvent;
	
	public class Tlf_control
	{
		private var editor:RichEditableText;
		public var title:TextInput;
		private var graphicBar:GraphicBar;
		private var doChangeImage:Boolean = false;
		private var linkBar:com.robertgurgul.cms.view.BottomBar.LinkBar;
		private var controlBar:com.robertgurgul.cms.view.BottomBar.ControlTextBar;
		private var undoManager:IUndoManager = new UndoManager();
		private var currentElement:ParagraphElement;

		public function get strHTML():String
		{
			return TextConverter.export(editor.textFlow, TextConverter.TEXT_FIELD_HTML_FORMAT, ConversionType.STRING_TYPE).toString();
		}
		public function get strTLF():String
		{
			return TextConverter.export(editor.textFlow, TextConverter.TEXT_LAYOUT_FORMAT, ConversionType.STRING_TYPE).toString();
		}

		public function Tlf_control(obj:*, 
									_graphicBar:com.robertgurgul.cms.view.BottomBar.GraphicBar, 
									_linkBar:com.robertgurgul.cms.view.BottomBar.LinkBar,
									_controlBar:com.robertgurgul.cms.view.BottomBar.ControlTextBar):void
		{
			editor = obj.editor;
			title = obj.titlee;
			graphicBar = _graphicBar;
			linkBar = _linkBar;
			controlBar = _controlBar;
			
			initializeConfiguration();
		}
		private function initializeConfiguration():void
		{
			var config:Configuration = TextFlow.defaultConfiguration;
			config.manageTabKey = true;
			var initialFormat:TextLayoutFormat = new TextLayoutFormat();
			initialFormat.fontFamily = "Arial";
			initialFormat.paddingLeft = 2;
			initialFormat.paddingTop = 2;
			initialFormat.paddingRight = 2;
			initialFormat.paddingBottom = 2;
			config.textFlowInitialFormat = initialFormat;
			
			editor.textFlow = new TextFlow(config);
		}
		
		public function addTab():void
		{
			var tab:TabElement = new TabElement();
			editor.textFlow.addChildAt(editor.selectionActivePosition, tab);
		}
		public function addList(event:Event = null):void
		{
			var list:ListElement = new ListElement()
			list.listStyleType="disc"; // note you don’t need to create a new TextLayoutFormat
			list.listStylePosition="outside";
			
			list.addChild(addListItem(''));
			editor.textFlow.addChildAt(editor.textFlow.getChildIndex(currentElement),list);
			
			editor.textFlow.flowComposer.updateAllControllers();
		}
		public function addListItem(str:String):ListItemElement
		{
			var paragraphElement:ParagraphElement = new ParagraphElement();
			var paragraphFormat:TextLayoutFormat = new TextLayoutFormat();
			paragraphElement.format = paragraphFormat;
			paragraphFormat.listStyleType = "disc";
			paragraphFormat.listStylePosition = "outside";
			
			var spanElement:SpanElement = new SpanElement();
			spanElement.text = str;
			
			paragraphElement.addChild(spanElement);
			
			var item:ListItemElement = new ListItemElement();
			
			item.addChild(paragraphElement)
			return item;
		}
		public function changeLink(urlText:String, targetText:String, extendToOverlappingLinks:Boolean):void
		{
			var em:IEditManager = IEditManager(editor.textFlow.interactionManager)
				em.applyLink(urlText, targetText, extendToOverlappingLinks);
			
				editor.setFocus();

		}
		public function initText(e:Event = null):void 
		{
			editor.textFlow = TextConverter.importToFlow(DataHolder.getInstance().dataPage.descTLF, TextConverter.TEXT_LAYOUT_FORMAT);
			editor.textFlow.addEventListener(SelectionEvent.SELECTION_CHANGE, selectionHandler);
		}
		private function selectionHandler(ev:SelectionEvent):void
		{
			// Find selected element range
			var range:ElementRange = ev.selectionState ?  
				ElementRange.createElementRange(ev.selectionState.textFlow,
					ev.selectionState.absoluteStart, ev.selectionState.absoluteEnd) : null;
			
			currentElement = range.firstLeaf.getParentByType(ParagraphElement) as ParagraphElement;
			
			var makeItTheChangeButton:Boolean = false;
			
			// this logic is a complicated by the fact that we extend the end of the selection because the FE is at the end of the paragraph
			if (range && range.firstLeaf is InlineGraphicElement && range.absoluteStart == range.firstLeaf.getAbsoluteStart())
			{
				// two cases just the FE and just the FE plus the paragraph terminator
				if (range.absoluteEnd == range.absoluteStart+1 || (range.firstParagraph == range.lastParagraph && range.absoluteEnd == range.absoluteStart+2 && range.absoluteEnd == range.lastParagraph.getAbsoluteStart() + range.lastParagraph.textLength))
					makeItTheChangeButton = true; 
			} else {
				doChangeImage = false;
				graphicBar.imageButton.label = 'Wstaw';
			}
			
			// block selection of just the FE
			if (makeItTheChangeButton)
				updateForChange(InlineGraphicElement(range.firstLeaf));
			else
				updateForInsert(range);
			
			var linkString:String = "";
			var linkTarget:String = "";
			var linkEl:LinkElement = range.firstLeaf.getParentByType(LinkElement) as LinkElement;
			if (linkEl != null)
			{
				var linkElStart:int = linkEl.getAbsoluteStart();
				var linkElEnd:int = linkElStart + linkEl.textLength;
				if (linkElEnd < linkElStart)
				{
					var temp:int = linkElStart;
					linkElStart = linkElEnd;
					linkElEnd = temp;
				}
				
				var beginRange:int = range.absoluteStart;
				var endRange:int = range.absoluteEnd;
				
				var beginPara:ParagraphElement = range.firstParagraph;
				if (endRange == (beginPara.getAbsoluteStart() + beginPara.textLength))
				{
					endRange--;
				}
				
				if ((beginRange == endRange) || (endRange <= linkElEnd))
				{
					linkString = LinkElement(linkEl).href;
					linkTarget = LinkElement(linkEl).target;
				}
			}
			
			linkBar.linkTextInput.text = linkString ? linkString : "";
			linkBar.setTargetCombo(linkTarget ? linkTarget : "");

			var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			
			controlBar.fontDDL.selectedItem = txtLayFmt.fontFamily;
			controlBar.sizeDDL.selectedItem = txtLayFmt.fontSize;
			
			controlBar.boldBtn.selected = (txtLayFmt.fontWeight == FontWeight.BOLD);
			controlBar.italBtn.selected = (txtLayFmt.fontStyle == FontPosture.ITALIC);
			controlBar.underBtn.selected = (txtLayFmt.textDecoration == TextDecoration.UNDERLINE);
			controlBar.colorCP.selectedColor = txtLayFmt.color;
			controlBar.lineBtn.selected = txtLayFmt.lineThrough;

			switch (txtLayFmt.textAlign) {
				case TextAlign.LEFT:
					controlBar.txtAlignBB.selectedIndex = 0;
					break;
				case TextAlign.CENTER:
					controlBar.txtAlignBB.selectedIndex = 1;
					break;
				case TextAlign.RIGHT:
					controlBar.txtAlignBB.selectedIndex = 2;
					break;
				case TextAlign.JUSTIFY:
					controlBar.txtAlignBB.selectedIndex = 3;
					break;
				default:
					controlBar.txtAlignBB.selectedIndex = -1;
					break;
			}
		}
		protected function updateForChange(inlineElement:InlineGraphicElement):void
		{
			var sourceString:String = inlineElement.source.toString()
			var widthString:String = inlineElement.width === undefined ? FormatValue.AUTO : inlineElement.width.toString();
			var heightString:String = inlineElement.height === undefined ? FormatValue.AUTO : inlineElement.height.toString();
			doUpdate(sourceString, widthString, heightString, true, true);
		}
		protected function updateForInsert(range:ElementRange):void
		{
			
		}
		private function doUpdate(url:String, width:String, height:String, modify:Boolean, enableImage:Boolean):void
		{
			graphicBar.imageWidth.text = width;
			graphicBar.imageHeight.text = height;
			graphicBar.imageButton.label = modify ? "Change" : "Wstaw";
			graphicBar.imageURL.text = url;
			doChangeImage = modify;			
		}

		public function imageBtn_clickHandler(event:MouseEvent):void 
		{
			if (doChangeImage)
			{
				var em1:IEditManager = IEditManager(editor.textFlow.interactionManager);
				em1.modifyInlineGraphic(event.target.parent.imageURL.text, event.target.parent.imageWidth.text, event.target.parent.imageHeight.text, event.target.parent.floatChoose.selectedItem.value);
				graphicBar.imageButton.label = 'Wstaw';
				doChangeImage = false;
			} else {
				var selection:SelectionState = editor.textFlow.interactionManager.getSelectionState();
				var span:FlowElement = editor.textFlow.findLeaf(selection.absoluteStart) as FlowElement;
				
				var newSpan:FlowElement = span.splitAtPosition(span.parentRelativeStart);
				var ilg:InlineGraphicElement = new InlineGraphicElement();
				ilg.source = event.target.parent.imageURL.text;
				ilg.float = event.target.parent.floatChoose.selectedItem.value;
				ilg.width = event.target.parent.imageWidth.text;
				ilg.height = event.target.parent.imageHeight.text;
				ilg.paddingRight = 10;
				ilg.paddingLeft = 10;
				span.getParagraph().addChildAt(span.getParagraph().getChildIndex(span)+1, ilg);
				editor.textFlow.flowComposer.updateAllControllers();
			}
		}
		public function fontDDL_changeHandler(evt:IndexChangeEvent):void {
			var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			txtLayFmt.fontFamily = evt.currentTarget.selectedItem;
			editor.setFormatOfRange(txtLayFmt,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			editor.setFocus();
		}
		public function sizeDDL_changeHandler(evt:IndexChangeEvent):void {
			var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			txtLayFmt.fontSize = evt.currentTarget.selectedItem;
			editor.setFormatOfRange(txtLayFmt,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			editor.setFocus();
		}
		
		public function boldBtn_clickHandler(evt:MouseEvent = null):void 
		{
			var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			txtLayFmt.fontWeight = (txtLayFmt.fontWeight == FontWeight.BOLD) ? FontWeight.NORMAL : FontWeight.BOLD;
			editor.setFormatOfRange(txtLayFmt,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			editor.setFocus();
		} 
		
		public function italBtn_clickHandler(evt:MouseEvent = null):void {
			var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			
			txtLayFmt.fontStyle = (txtLayFmt.fontStyle == FontPosture.ITALIC) ? FontPosture.NORMAL : FontPosture.ITALIC;
			
			editor.setFormatOfRange(txtLayFmt,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			
			editor.setFocus();
		}
		public function super_script_clickHandler(evt:MouseEvent = null):void {
			var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			
			txtLayFmt.baselineShift = (txtLayFmt.baselineShift == flashx.textLayout.formats.BaselineShift.SUPERSCRIPT) ? 
				0 : flashx.textLayout.formats.BaselineShift.SUPERSCRIPT;
			
			
			editor.setFormatOfRange(txtLayFmt,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			editor.setFocus();	
		}
		public function sub_script_clickHandler(evt:MouseEvent = null):void {
			var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			
			txtLayFmt.baselineShift = (txtLayFmt.baselineShift == flashx.textLayout.formats.BaselineShift.SUBSCRIPT) ? 
				0 : flashx.textLayout.formats.BaselineShift.SUBSCRIPT;
			
			editor.setFormatOfRange(txtLayFmt,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			editor.setFocus();	
		}
		
		public function underBtn_clickHandler(evt:MouseEvent = null):void 
		{
			var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			txtLayFmt.textDecoration = (txtLayFmt.textDecoration == TextDecoration.UNDERLINE) ? TextDecoration.NONE : TextDecoration.UNDERLINE;
			editor.setFormatOfRange(txtLayFmt,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			editor.setFocus();
		}
		
		public function colorCP_changeHandler(evt:ColorPickerEvent):void {
			var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			txtLayFmt.color = evt.currentTarget.selectedColor;
			editor.setFormatOfRange(txtLayFmt,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			editor.setFocus();
		}
		
		public function txtAlignBB_changeHandler(evt:IndexChangeEvent):void {
			if (evt.currentTarget.selectedItem) {
				var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
					editor.selectionAnchorPosition,
					editor.selectionActivePosition);
				txtLayFmt.textAlign = evt.currentTarget.selectedItem.value;
				editor.setFormatOfRange(txtLayFmt,
					editor.selectionAnchorPosition,
					editor.selectionActivePosition);
				editor.setFocus();
			}
		}
		
		public function lineBtn_clickHandler(evt:MouseEvent = null):void {
			var txtLayFmt:TextLayoutFormat = editor.getFormatOfRange(null,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			txtLayFmt.lineThrough = evt.currentTarget.selected;
			editor.setFormatOfRange(txtLayFmt,
				editor.selectionAnchorPosition,
				editor.selectionActivePosition);
			editor.setFocus();
		}
		public function exportToHtml(e:MouseEvent):void
		{
			var tmp:String = TextConverter.export(editor.textFlow, TextConverter.TEXT_FIELD_HTML_FORMAT, ConversionType.STRING_TYPE).toString();
		}
		
		public function clearEditor():void
		{
			editor.text = '';
			FlexGlobals.topLevelApplication.editableContainer.titlee.text = '';
		}
	}
}