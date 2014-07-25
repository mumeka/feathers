/*
 Copyright (c) 2014 Josh Tynjala

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */
package feathers.themes
{
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Callout;
	import feathers.controls.Check;
	import feathers.controls.Drawers;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.NumericStepper;
	import feathers.controls.PageIndicator;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.controls.PickerList;
	import feathers.controls.ProgressBar;
	import feathers.controls.Radio;
	import feathers.controls.Screen;
	import feathers.controls.ScrollBar;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollScreen;
	import feathers.controls.ScrollText;
	import feathers.controls.Scroller;
	import feathers.controls.SimpleScrollBar;
	import feathers.controls.Slider;
	import feathers.controls.TabBar;
	import feathers.controls.TextArea;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleButton;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.popups.DropDownPopUpContentManager;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextBlockTextEditor;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.controls.text.TextFieldTextEditor;
	import feathers.core.FeathersControl;
	import feathers.core.FocusManager;
	import feathers.core.PopUpManager;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.skins.StandardIcons;
	import feathers.system.DeviceCapabilities;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;

	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormatAlign;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * The base class for the "Metal Works" theme for desktop Feathers apps.
	 * Handles everything except asset loading, which is left to subclasses.
	 *
	 * @see MetalWorksDesktopTheme
	 * @see MetalWorksDesktopThemeWithAssetManager
	 */
	public class BaseMetalWorksDesktopTheme extends StyleNameFunctionTheme
	{
		[Embed(source="/../assets/fonts/SourceSansPro-Regular.ttf",fontFamily="SourceSansPro",fontWeight="normal",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_SANS_PRO_REGULAR:Class;

		[Embed(source="/../assets/fonts/SourceSansPro-Semibold.ttf",fontFamily="SourceSansPro",fontWeight="bold",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_SANS_PRO_SEMIBOLD:Class;

		protected static const FONT_NAME:String = "SourceSansPro";

		protected static const PRIMARY_BACKGROUND_COLOR:uint = 0x4a4137;
		protected static const LIGHT_TEXT_COLOR:uint = 0xe5e5e5;
		protected static const DARK_TEXT_COLOR:uint = 0x1a1816;
		protected static const SELECTED_TEXT_COLOR:uint = 0xff9900;
		protected static const DISABLED_TEXT_COLOR:uint = 0x8a8a8a;
		protected static const DARK_DISABLED_TEXT_COLOR:uint = 0x383430;
		protected static const LIST_BACKGROUND_COLOR:uint = 0x332f2b;
		protected static const LIST_BACKGROUND_HOVER_COLOR:uint = 0xff7700;
		protected static const LIST_BACKGROUND_SELECTED_COLOR:uint = 0xff9900;
		protected static const TAB_BACKGROUND_COLOR:uint = 0x1a1816;
		protected static const TAB_DISABLED_BACKGROUND_COLOR:uint = 0x292624;
		protected static const GROUPED_LIST_HEADER_BACKGROUND_COLOR:uint = 0x242322;
		protected static const GROUPED_LIST_FOOTER_BACKGROUND_COLOR:uint = 0x242322;
		protected static const SCROLL_BAR_TRACK_COLOR:uint = 0x1a1816;
		protected static const SCROLL_BAR_TRACK_DOWN_COLOR:uint = 0xff7700;
		protected static const TEXT_SELECTION_BACKGROUND_COLOR:uint = 0x574f46;
		protected static const MODAL_OVERLAY_COLOR:uint = 0x29241e;
		protected static const MODAL_OVERLAY_ALPHA:Number = 0.8;
		protected static const DRAWER_OVERLAY_COLOR:uint = 0x29241e;
		protected static const DRAWER_OVERLAY_ALPHA:Number = 0.4;

		protected static const DEFAULT_SCALE9_GRID:Rectangle = new Rectangle(3, 3, 1, 1);
		protected static const SIMPLE_SCALE9_GRID:Rectangle = new Rectangle(2, 2, 1, 1);
		protected static const BUTTON_SCALE9_GRID:Rectangle = new Rectangle(3, 3, 1, 16);
		protected static const BUTTON_SELECTED_SCALE9_GRID:Rectangle = new Rectangle(4, 4, 1, 14);
		protected static const SCROLL_BAR_STEP_BUTTON_SCALE9_GRID:Rectangle = new Rectangle(3, 3, 1, 7);
		protected static const BACK_BUTTON_SCALE3_REGION1:Number = 13;
		protected static const BACK_BUTTON_SCALE3_REGION2:Number = 1;
		protected static const FORWARD_BUTTON_SCALE3_REGION1:Number = 3;
		protected static const FORWARD_BUTTON_SCALE3_REGION2:Number = 1;
		protected static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 2, 82);
		protected static const TAB_SCALE9_GRID:Rectangle = new Rectangle(7, 7, 1, 11);
		protected static const SCROLL_BAR_THUMB_REGION1:int = 5;
		protected static const SCROLL_BAR_THUMB_REGION2:int = 14;

		protected static const ATLAS_NAME:String = "metalworks";

		protected static const THEME_NAME_HORIZONTAL_SCROLL_BAR_INCREMENT_BUTTON:String = "metalworks-desktop-horizontal-scroll-bar-increment-button";
		protected static const THEME_NAME_HORIZONTAL_SCROLL_BAR_DECREMENT_BUTTON:String = "metalworks-desktop-horizontal-scroll-bar-decrement-button";
		protected static const THEME_NAME_HORIZONTAL_SCROLL_BAR_THUMB:String = "metalworks-desktop-horizontal-scroll-bar-thumb";
		protected static const THEME_NAME_HORIZONTAL_SCROLL_BAR_MINIMUM_TRACK:String = "metalworks-desktop-horizontal-scroll-bar-minimum-track";
		protected static const THEME_NAME_HORIZONTAL_SCROLL_BAR_MAXIMUM_TRACK:String = "metalworks-desktop-horizontal-scroll-bar-maximum-track";

		protected static const THEME_NAME_VERTICAL_SCROLL_BAR_INCREMENT_BUTTON:String = "metalworks-desktop-vertical-scroll-bar-increment-button";
		protected static const THEME_NAME_VERTICAL_SCROLL_BAR_DECREMENT_BUTTON:String = "metalworks-desktop-vertical-scroll-bar-decrement-button";
		protected static const THEME_NAME_VERTICAL_SCROLL_BAR_THUMB:String = "metalworks-desktop-vertical-scroll-bar-thumb";
		protected static const THEME_NAME_VERTICAL_SCROLL_BAR_MINIMUM_TRACK:String = "metalworks-desktop-vertical-scroll-bar-minimum-track";
		protected static const THEME_NAME_VERTICAL_SCROLL_BAR_MAXIMUM_TRACK:String = "metalworks-desktop-vertical-scroll-bar-maximum-track";

		protected static const THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB:String = "metalworks-desktop-horizontal-simple-scroll-bar-thumb";
		protected static const THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB:String = "metalworks-desktop-vertical-simple-scroll-bar-thumb";

		protected static const THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK:String = "metalworks-desktop-horizontal-slider-minimum-track";
		protected static const THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK:String = "metalworks-desktop-horizontal-slider-maximum-track";

		protected static const THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK:String = "metalworks-desktop-vertical-slider-minimum-track";
		protected static const THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK:String = "metalworks-desktop-vertical-slider-maximum-track";

		protected static function textRendererFactory():TextBlockTextRenderer
		{
			return new TextBlockTextRenderer();
		}

		protected static function textEditorFactory():TextBlockTextEditor
		{
			return new TextBlockTextEditor();
		}

		protected static function horizontalScrollBarFactory():ScrollBar
		{
			var scrollBar:ScrollBar = new ScrollBar();
			scrollBar.direction = ScrollBar.DIRECTION_HORIZONTAL;
			return scrollBar;
		}

		protected static function verticalScrollBarFactory():ScrollBar
		{
			var scrollBar:ScrollBar = new ScrollBar();
			scrollBar.direction = ScrollBar.DIRECTION_VERTICAL;
			return scrollBar;
		}

		protected static function popUpOverlayFactory():DisplayObject
		{
			var quad:Quad = new Quad(100, 100, MODAL_OVERLAY_COLOR);
			quad.alpha = MODAL_OVERLAY_ALPHA;
			return quad;
		}

		public function BaseMetalWorksDesktopTheme()
		{
		}

		protected var scale:Number = 1;

		protected var smallFontSize:int;
		protected var regularFontSize:int;
		protected var largeFontSize:int;

		protected var gridSize:int;
		protected var extraSmallGutterSize:int;
		protected var smallGutterSize:int;
		protected var gutterSize:int;
		protected var borderSize:int;
		protected var controlSize:int;
		protected var wideControlSize:int;
		protected var smallControlSize:int;
		protected var calloutArrowOverlapGap:int;
		protected var calloutBackgroundMinSize:int;
		protected var progressBarFillMinSize:int;
		protected var scrollBarGutterSize:int;
		protected var popUpSize:int;

		protected var regularFontDescription:FontDescription;
		protected var boldFontDescription:FontDescription;

		protected var scrollTextTextFormat:TextFormat;
		protected var scrollTextDisabledTextFormat:TextFormat;

		protected var darkUIElementFormat:ElementFormat;
		protected var lightUIElementFormat:ElementFormat;
		protected var selectedUIElementFormat:ElementFormat;
		protected var lightUIDisabledElementFormat:ElementFormat;
		protected var darkUIDisabledElementFormat:ElementFormat;

		protected var largeDarkElementFormat:ElementFormat;
		protected var largeLightElementFormat:ElementFormat;
		protected var largeDisabledElementFormat:ElementFormat;

		protected var darkElementFormat:ElementFormat;
		protected var lightElementFormat:ElementFormat;
		protected var disabledElementFormat:ElementFormat;

		protected var smallLightElementFormat:ElementFormat;
		protected var smallDisabledElementFormat:ElementFormat;

		protected var atlas:TextureAtlas;
		protected var atlasTexture:Texture;
		protected var headerBackgroundSkinTexture:Texture;
		protected var headerPopupBackgroundSkinTexture:Texture;
		protected var backgroundSkinTextures:Scale9Textures;
		protected var backgroundDisabledSkinTextures:Scale9Textures;
		protected var backgroundFocusedSkinTextures:Scale9Textures;
		protected var listBackgroundSkinTextures:Scale9Textures;
		protected var buttonUpSkinTextures:Scale9Textures;
		protected var buttonDownSkinTextures:Scale9Textures;
		protected var buttonDisabledSkinTextures:Scale9Textures;
		protected var buttonSelectedUpSkinTextures:Scale9Textures;
		protected var buttonSelectedDisabledSkinTextures:Scale9Textures;
		protected var buttonQuietHoverSkinTextures:Scale9Textures;
		protected var buttonCallToActionUpSkinTextures:Scale9Textures;
		protected var buttonCallToActionDownSkinTextures:Scale9Textures;
		protected var buttonDangerUpSkinTextures:Scale9Textures;
		protected var buttonDangerDownSkinTextures:Scale9Textures;
		protected var buttonBackUpSkinTextures:Scale3Textures;
		protected var buttonBackDownSkinTextures:Scale3Textures;
		protected var buttonBackDisabledSkinTextures:Scale3Textures;
		protected var buttonForwardUpSkinTextures:Scale3Textures;
		protected var buttonForwardDownSkinTextures:Scale3Textures;
		protected var buttonForwardDisabledSkinTextures:Scale3Textures;
		protected var pickerListButtonIconTexture:Texture;
		protected var tabUpSkinTextures:Scale9Textures;
		protected var tabDownSkinTextures:Scale9Textures;
		protected var tabDisabledSkinTextures:Scale9Textures;
		protected var tabSelectedSkinTextures:Scale9Textures;
		protected var tabSelectedDisabledSkinTextures:Scale9Textures;
		protected var radioUpIconTexture:Texture;
		protected var radioDownIconTexture:Texture;
		protected var radioDisabledIconTexture:Texture;
		protected var radioSelectedUpIconTexture:Texture;
		protected var radioSelectedDownIconTexture:Texture;
		protected var radioSelectedDisabledIconTexture:Texture;
		protected var checkUpIconTexture:Texture;
		protected var checkDownIconTexture:Texture;
		protected var checkDisabledIconTexture:Texture;
		protected var checkSelectedUpIconTexture:Texture;
		protected var checkSelectedDownIconTexture:Texture;
		protected var checkSelectedDisabledIconTexture:Texture;
		protected var pageIndicatorNormalSkinTexture:Texture;
		protected var pageIndicatorSelectedSkinTexture:Texture;
		protected var itemRendererUpSkinTextures:Scale9Textures;
		protected var itemRendererSelectedSkinTextures:Scale9Textures;
		protected var backgroundPopUpSkinTextures:Scale9Textures;
		protected var calloutTopArrowSkinTexture:Texture;
		protected var calloutRightArrowSkinTexture:Texture;
		protected var calloutBottomArrowSkinTexture:Texture;
		protected var calloutLeftArrowSkinTexture:Texture;
		protected var horizontalSimpleScrollBarThumbSkinTextures:Scale3Textures;
		protected var horizontalScrollBarDecrementButtonIconTexture:Texture;
		protected var horizontalScrollBarDecrementButtonDisabledIconTexture:Texture;
		protected var horizontalScrollBarDecrementButtonUpSkinTextures:Scale9Textures;
		protected var horizontalScrollBarIncrementButtonIconTexture:Texture;
		protected var horizontalScrollBarIncrementButtonDisabledIconTexture:Texture;
		protected var horizontalScrollBarIncrementButtonUpSkinTextures:Scale9Textures;
		protected var verticalSimpleScrollBarThumbSkinTextures:Scale3Textures;
		protected var verticalScrollBarDecrementButtonIconTexture:Texture;
		protected var verticalScrollBarDecrementButtonDisabledIconTexture:Texture;
		protected var verticalScrollBarDecrementButtonUpSkinTextures:Scale9Textures;
		protected var verticalScrollBarIncrementButtonIconTexture:Texture;
		protected var verticalScrollBarIncrementButtonDisabledIconTexture:Texture;
		protected var verticalScrollBarIncrementButtonUpSkinTextures:Scale9Textures;
		protected var searchIconTexture:Texture;

		override public function dispose():void
		{
			if(this.atlas)
			{
				this.atlas.dispose();
				this.atlas = null;
				//no need to dispose the atlas texture because the atlas will do that
				this.atlasTexture = null;
			}

			//don't forget to call super.dispose()!
			super.dispose();
		}

		protected function initializeStage():void
		{
			Starling.current.stage.color = PRIMARY_BACKGROUND_COLOR;
			Starling.current.nativeStage.color = PRIMARY_BACKGROUND_COLOR;
		}

		protected function initialize():void
		{
			this.initializeScale();
			this.initializeFonts();
			this.initializeTextures();
			this.initializeGlobals();
			this.initializeStage();
			this.initializeStyleProviders();
		}

		protected function initializeGlobals():void
		{
			FeathersControl.defaultTextRendererFactory = textRendererFactory;
			FeathersControl.defaultTextEditorFactory = textEditorFactory;

			PopUpManager.overlayFactory = popUpOverlayFactory;
			Callout.stagePaddingTop = Callout.stagePaddingRight = Callout.stagePaddingBottom =
				Callout.stagePaddingLeft = this.smallGutterSize;

			FocusManager.setEnabledForStage(Starling.current.stage, true);
		}

		protected function initializeScale():void
		{
			this.scale = Starling.contentScaleFactor;

			this.gridSize = Math.round(30 * this.scale);
			this.extraSmallGutterSize = Math.round(2 * this.scale);
			this.smallGutterSize = Math.round(4 * this.scale);
			this.gutterSize = Math.round(8 * this.scale);
			this.borderSize = Math.max(1, Math.round(1 * this.scale));
			this.controlSize = Math.round(22 * this.scale);
			this.smallControlSize = Math.round(12 * this.scale);
			this.calloutBackgroundMinSize = Math.round(5 * this.scale);
			this.progressBarFillMinSize = Math.round(7 * this.scale);
			this.scrollBarGutterSize = Math.round(4 * this.scale);
			this.wideControlSize = this.gridSize * 4 + this.smallGutterSize * 3;
			this.popUpSize = this.gridSize * 10 + this.smallGutterSize * 9;
			this.calloutArrowOverlapGap = -1 * this.scale;
		}

		protected function initializeFonts():void
		{
			this.smallFontSize = Math.round(11 * this.scale);
			this.regularFontSize = Math.round(13 * this.scale);
			this.largeFontSize = Math.round(15 * this.scale);

			//these are for components that don't use FTE
			this.scrollTextTextFormat = new TextFormat("_sans", this.regularFontSize, LIGHT_TEXT_COLOR);
			this.scrollTextDisabledTextFormat = new TextFormat("_sans", this.regularFontSize, DISABLED_TEXT_COLOR);

			this.regularFontDescription = new FontDescription(FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			this.boldFontDescription = new FontDescription(FONT_NAME, FontWeight.BOLD, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);

			this.darkUIElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, DARK_TEXT_COLOR);
			this.lightUIElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, LIGHT_TEXT_COLOR);
			this.selectedUIElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, SELECTED_TEXT_COLOR);
			this.lightUIDisabledElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, DISABLED_TEXT_COLOR);
			this.darkUIDisabledElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, DARK_DISABLED_TEXT_COLOR);

			this.darkElementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, DARK_TEXT_COLOR);
			this.lightElementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, LIGHT_TEXT_COLOR);
			this.disabledElementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, DISABLED_TEXT_COLOR);

			this.smallLightElementFormat = new ElementFormat(this.regularFontDescription, this.smallFontSize, LIGHT_TEXT_COLOR);
			this.smallDisabledElementFormat = new ElementFormat(this.regularFontDescription, this.smallFontSize, DISABLED_TEXT_COLOR);

			this.largeDarkElementFormat = new ElementFormat(this.regularFontDescription, this.largeFontSize, DARK_TEXT_COLOR);
			this.largeLightElementFormat = new ElementFormat(this.regularFontDescription, this.largeFontSize, LIGHT_TEXT_COLOR);
			this.largeDisabledElementFormat = new ElementFormat(this.regularFontDescription, this.largeFontSize, DISABLED_TEXT_COLOR);
		}

		protected function initializeTextures():void
		{
			var backgroundSkinTexture:Texture = this.atlas.getTexture("background-skin");
			var backgroundInsetSkinTexture:Texture = this.atlas.getTexture("background-inset-skin");
			var backgroundDisabledSkinTexture:Texture = this.atlas.getTexture("background-disabled-skin");
			var backgroundFocusedSkinTexture:Texture = this.atlas.getTexture("background-focused-skin");
			var backgroundPopUpSkinTexture:Texture = this.atlas.getTexture("background-popup-skin");

			var checkUpIconTexture:Texture = this.atlas.getTexture("check-up-icon");
			var checkDownIconTexture:Texture = this.atlas.getTexture("check-down-icon");
			var checkDisabledIconTexture:Texture = this.atlas.getTexture("check-disabled-icon");

			this.backgroundSkinTextures = new Scale9Textures(backgroundSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundDisabledSkinTextures = new Scale9Textures(backgroundDisabledSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundFocusedSkinTextures = new Scale9Textures(backgroundFocusedSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundPopUpSkinTextures = new Scale9Textures(backgroundPopUpSkinTexture, SIMPLE_SCALE9_GRID);
			this.listBackgroundSkinTextures = new Scale9Textures(this.atlas.getTexture("list-background-skin"), DEFAULT_SCALE9_GRID);

			this.buttonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("button-disabled-skin"), BUTTON_SCALE9_GRID);
			this.buttonSelectedUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-up-skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-disabled-skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonQuietHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("button-quiet-hover-skin"), BUTTON_SCALE9_GRID);
			this.buttonCallToActionUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-call-to-action-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonCallToActionDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-call-to-action-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonDangerUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-danger-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonDangerDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-danger-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonBackUpSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-up-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonBackDownSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-down-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonBackDisabledSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-disabled-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonForwardUpSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-up-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonForwardDownSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-down-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonForwardDisabledSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-disabled-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);

			this.tabUpSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-up-skin"), TAB_SCALE9_GRID);
			this.tabDownSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-down-skin"), TAB_SCALE9_GRID);
			this.tabDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-disabled-skin"), TAB_SCALE9_GRID);
			this.tabSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-skin"), TAB_SCALE9_GRID);
			this.tabSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-disabled-skin"), TAB_SCALE9_GRID);

			this.pickerListButtonIconTexture = this.atlas.getTexture("picker-list-icon");

			this.radioUpIconTexture = checkUpIconTexture;
			this.radioDownIconTexture = checkDownIconTexture;
			this.radioDisabledIconTexture = checkDisabledIconTexture;
			this.radioSelectedUpIconTexture = this.atlas.getTexture("radio-selected-up-icon");
			this.radioSelectedDownIconTexture = this.atlas.getTexture("radio-selected-down-icon");
			this.radioSelectedDisabledIconTexture = this.atlas.getTexture("radio-selected-disabled-icon");

			this.checkUpIconTexture = checkUpIconTexture;
			this.checkDownIconTexture = checkDownIconTexture;
			this.checkDisabledIconTexture = checkDisabledIconTexture;
			this.checkSelectedUpIconTexture = this.atlas.getTexture("check-selected-up-icon");
			this.checkSelectedDownIconTexture = this.atlas.getTexture("check-selected-down-icon");
			this.checkSelectedDisabledIconTexture = this.atlas.getTexture("check-selected-disabled-icon");

			this.pageIndicatorSelectedSkinTexture = this.atlas.getTexture("page-indicator-selected-skin");
			this.pageIndicatorNormalSkinTexture = this.atlas.getTexture("page-indicator-normal-skin");

			this.searchIconTexture = this.atlas.getTexture("search-icon");

/*			this.itemRendererUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-item-up-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.itemRendererSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-item-selected-skin"), ITEM_RENDERER_SCALE9_GRID);
*/
			this.headerBackgroundSkinTexture = this.atlas.getTexture("header-background-skin");
			this.headerPopupBackgroundSkinTexture = this.atlas.getTexture("header-popup-background-skin");

			this.calloutTopArrowSkinTexture = this.atlas.getTexture("callout-arrow-top-skin");
			this.calloutRightArrowSkinTexture = this.atlas.getTexture("callout-arrow-right-skin");
			this.calloutBottomArrowSkinTexture = this.atlas.getTexture("callout-arrow-bottom-skin");
			this.calloutLeftArrowSkinTexture = this.atlas.getTexture("callout-arrow-left-skin");

			this.horizontalSimpleScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getTexture("horizontal-simple-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2);
			this.horizontalScrollBarDecrementButtonIconTexture = this.atlas.getTexture("horizontal-scroll-bar-decrement-button-icon");
			this.horizontalScrollBarDecrementButtonDisabledIconTexture = this.atlas.getTexture("horizontal-scroll-bar-decrement-button-disabled-icon");
			this.horizontalScrollBarDecrementButtonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("horizontal-scroll-bar-decrement-button-up-skin"), SCROLL_BAR_STEP_BUTTON_SCALE9_GRID);
			this.horizontalScrollBarIncrementButtonIconTexture = this.atlas.getTexture("horizontal-scroll-bar-increment-button-icon");
			this.horizontalScrollBarIncrementButtonDisabledIconTexture = this.atlas.getTexture("horizontal-scroll-bar-increment-button-disabled-icon");
			this.horizontalScrollBarIncrementButtonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("horizontal-scroll-bar-increment-button-up-skin"), SCROLL_BAR_STEP_BUTTON_SCALE9_GRID);

			this.verticalSimpleScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getTexture("vertical-simple-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2);
			this.verticalScrollBarDecrementButtonIconTexture = this.atlas.getTexture("vertical-scroll-bar-decrement-button-icon");
			this.verticalScrollBarDecrementButtonDisabledIconTexture = this.atlas.getTexture("vertical-scroll-bar-decrement-button-disabled-icon");
			this.verticalScrollBarDecrementButtonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("vertical-scroll-bar-decrement-button-up-skin"), SCROLL_BAR_STEP_BUTTON_SCALE9_GRID);
			this.verticalScrollBarIncrementButtonIconTexture = this.atlas.getTexture("vertical-scroll-bar-increment-button-icon");
			this.verticalScrollBarIncrementButtonDisabledIconTexture = this.atlas.getTexture("vertical-scroll-bar-increment-button-disabled-icon");
			this.verticalScrollBarIncrementButtonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("vertical-scroll-bar-increment-button-up-skin"), SCROLL_BAR_STEP_BUTTON_SCALE9_GRID);

			StandardIcons.listDrillDownAccessoryTexture = this.atlas.getTexture("list-accessory-drill-down-icon");
		}

		protected function initializeStyleProviders():void
		{
			//alert
			this.getStyleProviderForClass(Alert).defaultStyleFunction = this.setAlertStyles;
			this.getStyleProviderForClass(Header).setFunctionForStyleName(Alert.DEFAULT_CHILD_NAME_HEADER, this.setPopupHeaderStyles);
			this.getStyleProviderForClass(ButtonGroup).setFunctionForStyleName(Alert.DEFAULT_CHILD_NAME_BUTTON_GROUP, this.setAlertButtonGroupStyles);
			this.getStyleProviderForClass(TextBlockTextRenderer).setFunctionForStyleName(Alert.DEFAULT_CHILD_NAME_MESSAGE, this.setAlertMessageTextRendererStyles);

			//button
			this.getStyleProviderForClass(Button).defaultStyleFunction = this.setButtonStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON, this.setCallToActionButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_NAME_QUIET_BUTTON, this.setQuietButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_NAME_DANGER_BUTTON, this.setDangerButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_NAME_BACK_BUTTON, this.setBackButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_NAME_FORWARD_BUTTON, this.setForwardButtonStyles);

			//button group
			this.getStyleProviderForClass(ButtonGroup).defaultStyleFunction = this.setButtonGroupStyles;

			//callout
			this.getStyleProviderForClass(Callout).defaultStyleFunction = this.setCalloutStyles;

			//check
			this.getStyleProviderForClass(Check).defaultStyleFunction = this.setCheckStyles;

			//drawers
			this.getStyleProviderForClass(Drawers).defaultStyleFunction = this.setDrawersStyles;

			//grouped list (see also: item renderers)
			this.getStyleProviderForClass(GroupedList).defaultStyleFunction = this.setGroupedListStyles;

			//header
			this.getStyleProviderForClass(Header).defaultStyleFunction = this.setHeaderStyles;

			//header and footer renderers for grouped list
			this.getStyleProviderForClass(DefaultGroupedListHeaderOrFooterRenderer).defaultStyleFunction = this.setGroupedListHeaderRendererStyles;
			this.getStyleProviderForClass(DefaultGroupedListHeaderOrFooterRenderer).setFunctionForStyleName(GroupedList.DEFAULT_CHILD_NAME_FOOTER_RENDERER, this.setGroupedListFooterRendererStyles);

			//item renderers for lists
			this.getStyleProviderForClass(DefaultGroupedListItemRenderer).defaultStyleFunction = this.setItemRendererStyles;
			this.getStyleProviderForClass(DefaultListItemRenderer).defaultStyleFunction = this.setItemRendererStyles;
			this.getStyleProviderForClass(TextBlockTextRenderer).setFunctionForStyleName(BaseDefaultItemRenderer.DEFAULT_CHILD_NAME_ACCESSORY_LABEL, this.setItemRendererAccessoryLabelRendererStyles);
			this.getStyleProviderForClass(TextBlockTextRenderer).setFunctionForStyleName(BaseDefaultItemRenderer.DEFAULT_CHILD_NAME_ICON_LABEL, this.setItemRendererIconLabelStyles);

			//labels
			this.getStyleProviderForClass(Label).defaultStyleFunction = this.setLabelStyles;
			this.getStyleProviderForClass(Label).setFunctionForStyleName(Label.ALTERNATE_NAME_HEADING, this.setHeadingLabelStyles);
			this.getStyleProviderForClass(Label).setFunctionForStyleName(Label.ALTERNATE_NAME_DETAIL, this.setDetailLabelStyles);

			//list (see also: item renderers)
			this.getStyleProviderForClass(List).defaultStyleFunction = this.setListStyles;

			//numeric stepper
			this.getStyleProviderForClass(NumericStepper).defaultStyleFunction = this.setNumericStepperStyles;
			this.getStyleProviderForClass(TextInput).setFunctionForStyleName(NumericStepper.DEFAULT_CHILD_NAME_TEXT_INPUT, this.setNumericStepperTextInputStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(NumericStepper.DEFAULT_CHILD_NAME_DECREMENT_BUTTON, this.setNumericStepperDecrementButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(NumericStepper.DEFAULT_CHILD_NAME_INCREMENT_BUTTON, this.setNumericStepperIncrementButtonStyles);

			//page indicator
			this.getStyleProviderForClass(PageIndicator).defaultStyleFunction = this.setPageIndicatorStyles;

			//panel
			this.getStyleProviderForClass(Panel).defaultStyleFunction = this.setPanelStyles;
			this.getStyleProviderForClass(Header).setFunctionForStyleName(Panel.DEFAULT_CHILD_NAME_HEADER, this.setPopupHeaderStyles);

			//panel screen
			this.getStyleProviderForClass(Header).setFunctionForStyleName(PanelScreen.DEFAULT_CHILD_NAME_HEADER, this.setPanelScreenHeaderStyles);

			//picker list (see also: list and item renderers)
			this.getStyleProviderForClass(PickerList).defaultStyleFunction = this.setPickerListStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(PickerList.DEFAULT_CHILD_NAME_BUTTON, this.setPickerListButtonStyles);
			this.getStyleProviderForClass(List).setFunctionForStyleName(PickerList.DEFAULT_CHILD_NAME_LIST, this.setPickerListListStyles);

			//progress bar
			this.getStyleProviderForClass(ProgressBar).defaultStyleFunction = this.setProgressBarStyles;

			//radio
			this.getStyleProviderForClass(Radio).defaultStyleFunction = this.setRadioStyles;

			//scroll bar
			this.getStyleProviderForClass(ScrollBar).setFunctionForStyleName(Scroller.DEFAULT_CHILD_NAME_HORIZONTAL_SCROLL_BAR, this.setHorizontalScrollBarStyles);
			this.getStyleProviderForClass(ScrollBar).setFunctionForStyleName(Scroller.DEFAULT_CHILD_NAME_VERTICAL_SCROLL_BAR, this.setVerticalScrollBarStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SCROLL_BAR_INCREMENT_BUTTON, this.setHorizontalScrollBarIncrementButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SCROLL_BAR_DECREMENT_BUTTON, this.setHorizontalScrollBarDecrementButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SCROLL_BAR_THUMB, this.setHorizontalScrollBarThumbStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SCROLL_BAR_MINIMUM_TRACK, this.setHorizontalScrollBarMinimumTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SCROLL_BAR_MAXIMUM_TRACK, this.setHorizontalScrollBarMaximumTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SCROLL_BAR_INCREMENT_BUTTON, this.setVerticalScrollBarIncrementButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SCROLL_BAR_DECREMENT_BUTTON, this.setVerticalScrollBarDecrementButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SCROLL_BAR_THUMB, this.setVerticalScrollBarThumbStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SCROLL_BAR_MINIMUM_TRACK, this.setVerticalScrollBarMinimumTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SCROLL_BAR_MAXIMUM_TRACK, this.setVerticalScrollBarMaximumTrackStyles);

			//scroll container
			this.getStyleProviderForClass(ScrollContainer).defaultStyleFunction = this.setScrollContainerStyles;
			this.getStyleProviderForClass(ScrollContainer).setFunctionForStyleName(ScrollContainer.ALTERNATE_NAME_TOOLBAR, this.setToolbarScrollContainerStyles);

			//scroll text
			this.getStyleProviderForClass(ScrollText).defaultStyleFunction = this.setScrollTextStyles;

			//simple scroll bar
			this.getStyleProviderForClass(SimpleScrollBar).defaultStyleFunction = this.setSimpleScrollBarStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB, this.setHorizontalSimpleScrollBarThumbStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB, this.setVerticalSimpleScrollBarThumbStyles);

			//slider
			this.getStyleProviderForClass(Slider).defaultStyleFunction = this.setSliderStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Slider.DEFAULT_CHILD_NAME_THUMB, this.setSliderThumbStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK, this.setHorizontalSliderMinimumTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK, this.setHorizontalSliderMaximumTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK, this.setVerticalSliderMinimumTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK, this.setVerticalSliderMaximumTrackStyles);

			//tab bar
			this.getStyleProviderForClass(TabBar).defaultStyleFunction = this.setTabBarStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(TabBar.DEFAULT_CHILD_NAME_TAB, this.setTabStyles);

			//text input
			this.getStyleProviderForClass(TextInput).defaultStyleFunction = this.setTextInputStyles;
			this.getStyleProviderForClass(TextInput).setFunctionForStyleName(TextInput.ALTERNATE_NAME_SEARCH_TEXT_INPUT, this.setSearchTextInputStyles);

			//text area
			this.getStyleProviderForClass(TextArea).defaultStyleFunction = this.setTextAreaStyles;

			//toggle switch
			this.getStyleProviderForClass(ToggleSwitch).defaultStyleFunction = this.setToggleSwitchStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_NAME_THUMB, this.setToggleSwitchThumbStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_NAME_ON_TRACK, this.setToggleSwitchTrackStyles);
			//we don't need a style function for the off track in this theme
			//the toggle switch layout uses a single track
		}

		protected function pageIndicatorNormalSymbolFactory():DisplayObject
		{
			var symbol:ImageLoader = new ImageLoader();
			symbol.source = this.pageIndicatorNormalSkinTexture;
			symbol.textureScale = this.scale;
			return symbol;
		}

		protected function pageIndicatorSelectedSymbolFactory():DisplayObject
		{
			var symbol:ImageLoader = new ImageLoader();
			symbol.source = this.pageIndicatorSelectedSkinTexture;
			symbol.textureScale = this.scale;
			return symbol;
		}

		protected function imageLoaderFactory():ImageLoader
		{
			var image:ImageLoader = new ImageLoader();
			image.textureScale = this.scale;
			return image;
		}

	//-------------------------
	// Shared
	//-------------------------

		protected function setScrollerStyles(scroller:Scroller):void
		{
			scroller.horizontalScrollBarFactory = horizontalScrollBarFactory;
			scroller.verticalScrollBarFactory = verticalScrollBarFactory;
			scroller.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_FIXED;
			scroller.interactionMode = Scroller.INTERACTION_MODE_MOUSE;
		}

	//-------------------------
	// Alert
	//-------------------------

		protected function setAlertStyles(alert:Alert):void
		{
			this.setScrollerStyles(alert);

			var backgroundSkin:Scale9Image = new Scale9Image(this.backgroundPopUpSkinTextures, this.scale);
			alert.backgroundSkin = backgroundSkin;

			alert.paddingTop = this.gutterSize;
			alert.paddingRight = this.gutterSize;
			alert.paddingBottom = this.smallGutterSize;
			alert.paddingLeft = this.gutterSize;
			alert.outerPadding = this.borderSize;
			alert.gap = this.smallGutterSize;
			alert.maxWidth = this.popUpSize;
			alert.maxHeight = this.popUpSize;
		}

		//see Panel section for Header styles

		protected function setAlertButtonGroupStyles(group:ButtonGroup):void
		{
			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
			group.verticalAlign = ButtonGroup.VERTICAL_ALIGN_JUSTIFY;
			group.distributeButtonSizes = false;
			group.gap = this.smallGutterSize;
			group.padding = this.smallGutterSize;
		}

		protected function setAlertMessageTextRendererStyles(renderer:TextBlockTextRenderer):void
		{
			renderer.wordWrap = true;
			renderer.elementFormat = this.lightElementFormat;
		}

	//-------------------------
	// Button
	//-------------------------

		protected function setBaseButtonStyles(button:Button):void
		{
			button.defaultLabelProperties.elementFormat = this.darkUIElementFormat;
			button.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			if(button is ToggleButton)
			{
				ToggleButton(button).selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			}

			button.paddingTop = this.smallGutterSize;
			button.paddingBottom = this.smallGutterSize;
			button.paddingLeft = this.gutterSize;
			button.paddingRight = this.gutterSize;
			button.gap = this.smallGutterSize;
			button.minGap = this.smallGutterSize;
			button.minWidth = button.minHeight = this.smallControlSize;
		}

		protected function setButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
			button.minWidth = this.gridSize * 2 + this.gutterSize * 1;
		}

		protected function setCallToActionButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonCallToActionUpSkinTextures;
			skinSelector.setValueForState(this.buttonCallToActionDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
		}

		protected function setQuietButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = null;
			skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState(this.buttonQuietHoverSkinTextures, Button.STATE_HOVER, false);
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			button.downLabelProperties.elementFormat = this.darkUIElementFormat;
			button.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			if(button is ToggleButton)
			{
				var toggleButton:ToggleButton = ToggleButton(button);
				toggleButton.defaultSelectedLabelProperties.elementFormat = this.darkUIElementFormat;
				toggleButton.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			}

			button.paddingTop = this.smallGutterSize;
			button.paddingBottom = this.smallGutterSize;
			button.paddingLeft = this.gutterSize;
			button.paddingRight = this.gutterSize;
			button.gap = this.smallGutterSize;
			button.minGap = this.smallGutterSize;
			button.minWidth = button.minHeight = this.controlSize;
		}

		protected function setDangerButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonDangerUpSkinTextures;
			skinSelector.setValueForState(this.buttonDangerDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
		}

		protected function setBackButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonBackUpSkinTextures;
			skinSelector.setValueForState(this.buttonBackDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonBackDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
			button.paddingLeft = this.gutterSize + this.smallGutterSize;
		}

		protected function setForwardButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonForwardUpSkinTextures;
			skinSelector.setValueForState(this.buttonForwardDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonForwardDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.setBaseButtonStyles(button);
			button.paddingRight = this.gutterSize + this.smallGutterSize;
		}

	//-------------------------
	// ButtonGroup
	//-------------------------

		protected function setButtonGroupStyles(group:ButtonGroup):void
		{
			group.minWidth = this.wideControlSize;
			group.gap = this.smallGutterSize;
		}

	//-------------------------
	// Callout
	//-------------------------

		protected function setCalloutStyles(callout:Callout):void
		{
			var backgroundSkin:Scale9Image = new Scale9Image(this.backgroundPopUpSkinTextures, this.scale);
			backgroundSkin.width = this.calloutBackgroundMinSize;
			backgroundSkin.height = this.calloutBackgroundMinSize;
			callout.backgroundSkin = backgroundSkin;

			var topArrowSkin:Image = new Image(this.calloutTopArrowSkinTexture);
			topArrowSkin.scaleX = topArrowSkin.scaleY = this.scale;
			callout.topArrowSkin = topArrowSkin;
			callout.topArrowGap = this.calloutArrowOverlapGap;

			var rightArrowSkin:Image = new Image(this.calloutRightArrowSkinTexture);
			rightArrowSkin.scaleX = rightArrowSkin.scaleY = this.scale;
			callout.rightArrowSkin = rightArrowSkin;
			callout.rightArrowGap = this.calloutArrowOverlapGap;

			var bottomArrowSkin:Image = new Image(this.calloutBottomArrowSkinTexture);
			bottomArrowSkin.scaleX = bottomArrowSkin.scaleY = this.scale;
			callout.bottomArrowSkin = bottomArrowSkin;
			callout.bottomArrowGap = this.calloutArrowOverlapGap;

			var leftArrowSkin:Image = new Image(this.calloutLeftArrowSkinTexture);
			leftArrowSkin.scaleX = leftArrowSkin.scaleY = this.scale;
			callout.leftArrowSkin = leftArrowSkin;
			callout.leftArrowGap = this.calloutArrowOverlapGap;

			callout.padding = this.gutterSize;
		}

	//-------------------------
	// Check
	//-------------------------

		protected function setCheckStyles(check:Check):void
		{
			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.defaultValue = this.checkUpIconTexture;
			iconSelector.defaultSelectedValue = this.checkSelectedUpIconTexture;
			iconSelector.setValueForState(this.checkDownIconTexture, Button.STATE_DOWN, false);
			iconSelector.setValueForState(this.checkDisabledIconTexture, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(this.checkSelectedDownIconTexture, Button.STATE_DOWN, true);
			iconSelector.setValueForState(this.checkSelectedDisabledIconTexture, Button.STATE_DISABLED, true);
			iconSelector.displayObjectProperties =
			{
				scaleX: this.scale,
				scaleY: this.scale
			};
			check.stateToIconFunction = iconSelector.updateValue;

			check.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			check.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			check.selectedDisabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;

			check.gap = this.smallGutterSize;
			check.minWidth = this.controlSize;
			check.minHeight = this.controlSize;
		}

	//-------------------------
	// Drawers
	//-------------------------

		protected function setDrawersStyles(drawers:Drawers):void
		{
			var overlaySkin:Quad = new Quad(1, 1, DRAWER_OVERLAY_COLOR);
			overlaySkin.alpha = DRAWER_OVERLAY_ALPHA;
			drawers.overlaySkin = overlaySkin;
		}

	//-------------------------
	// GroupedList
	//-------------------------

		protected function setGroupedListStyles(list:GroupedList):void
		{
			this.setScrollerStyles(list);

			list.padding = this.extraSmallGutterSize;
			list.backgroundSkin = new Scale9Image(this.listBackgroundSkinTextures, this.scale);
			list.backgroundDisabledSkin = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);


			list.verticalScrollPolicy = List.SCROLL_POLICY_AUTO;
		}

		//see List section for item renderer styles

		protected function setGroupedListHeaderRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			renderer.backgroundSkin = new Quad(this.controlSize, this.controlSize, GROUPED_LIST_HEADER_BACKGROUND_COLOR);

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.contentLabelProperties.elementFormat = this.lightUIElementFormat;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.minWidth = renderer.minHeight = this.controlSize;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		protected function setGroupedListFooterRendererStyles(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			renderer.backgroundSkin = new Quad(this.controlSize, this.controlSize, GROUPED_LIST_FOOTER_BACKGROUND_COLOR);

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
			renderer.contentLabelProperties.elementFormat = this.lightElementFormat;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.minWidth = renderer.minHeight = this.controlSize;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

	//-------------------------
	// Header
	//-------------------------

		protected function setHeaderStyles(header:Header):void
		{
			header.minWidth = this.gridSize;
			header.minHeight = this.gridSize;
			header.paddingTop = this.smallGutterSize;
			header.paddingBottom = this.smallGutterSize;
			header.paddingRight = this.gutterSize;
			header.paddingLeft = this.gutterSize;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;

			var backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture, this.scale);
			backgroundSkin.width = backgroundSkin.height = this.controlSize;
			header.backgroundSkin = backgroundSkin;
			header.titleProperties.elementFormat = this.lightElementFormat;
		}

	//-------------------------
	// Label
	//-------------------------

		protected function setLabelStyles(label:Label):void
		{
			label.textRendererProperties.elementFormat = this.lightElementFormat;
			label.textRendererProperties.disabledElementFormat = this.disabledElementFormat;
		}

		protected function setHeadingLabelStyles(label:Label):void
		{
			label.textRendererProperties.elementFormat = this.largeLightElementFormat;
			label.textRendererProperties.disabledElementFormat = this.largeDisabledElementFormat;
		}

		protected function setDetailLabelStyles(label:Label):void
		{
			label.textRendererProperties.elementFormat = this.smallLightElementFormat;
			label.textRendererProperties.disabledElementFormat = this.smallDisabledElementFormat;
		}

	//-------------------------
	// List
	//-------------------------

		protected function setListStyles(list:List):void
		{
			this.setScrollerStyles(list);

			list.padding = this.extraSmallGutterSize;
			list.backgroundSkin = new Scale9Image(this.listBackgroundSkinTextures, this.scale);
			list.backgroundDisabledSkin = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);

			list.verticalScrollPolicy = List.SCROLL_POLICY_AUTO;
		}

		protected function setItemRendererStyles(renderer:BaseDefaultItemRenderer):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = LIST_BACKGROUND_COLOR;
			skinSelector.defaultSelectedValue = LIST_BACKGROUND_SELECTED_COLOR;
			skinSelector.setValueForState(LIST_BACKGROUND_HOVER_COLOR, Button.STATE_HOVER, false);
			skinSelector.setValueForState(LIST_BACKGROUND_SELECTED_COLOR, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize/*,
				textureScale: this.scale*/
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			renderer.defaultLabelProperties.elementFormat = this.lightElementFormat;
			renderer.hoverLabelProperties.elementFormat = this.darkElementFormat;
			renderer.downLabelProperties.elementFormat = this.darkElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.darkElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.disabledElementFormat;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.gap = this.smallGutterSize;
			renderer.minGap = this.smallGutterSize;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.smallGutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = this.controlSize;

			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
		}

		protected function setItemRendererAccessoryLabelRendererStyles(renderer:TextBlockTextRenderer):void
		{
			renderer.elementFormat = this.lightElementFormat;
		}

		protected function setItemRendererIconLabelStyles(renderer:TextBlockTextRenderer):void
		{
			renderer.elementFormat = this.lightElementFormat;
		}

	//-------------------------
	// NumericStepper
	//-------------------------

		protected function setNumericStepperStyles(stepper:NumericStepper):void
		{
			stepper.buttonLayoutMode = NumericStepper.BUTTON_LAYOUT_MODE_RIGHT_SIDE_VERTICAL;
		}

		protected function setNumericStepperTextInputStyles(input:TextInput):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, TextInput.STATE_DISABLED);
			skinSelector.setValueForState(this.backgroundFocusedSkinTextures, TextInput.STATE_FOCUSED);
			skinSelector.displayObjectProperties =
			{
				width: this.gridSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			input.stateToSkinFunction = skinSelector.updateValue;

			input.minWidth = this.gridSize;
			input.minHeight = this.controlSize;
			input.gap = this.smallGutterSize;
			input.paddingTop = this.smallGutterSize;
			input.paddingBottom = this.smallGutterSize;
			input.paddingLeft = this.gutterSize;
			input.paddingRight = this.gutterSize;
			input.textEditorProperties.cursorSkin = new Quad(1, 1, LIGHT_TEXT_COLOR);
			input.textEditorProperties.selectionSkin = new Quad(1, 1, TEXT_SELECTION_BACKGROUND_COLOR);
			input.textEditorProperties.elementFormat = this.lightUIElementFormat;
			input.textEditorProperties.disabledElementFormat = this.lightUIDisabledElementFormat;
			input.textEditorProperties.textAlign = TextBlockTextEditor.TEXT_ALIGN_CENTER;
		}

		protected function setNumericStepperDecrementButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.verticalScrollBarIncrementButtonUpSkinTextures;
			/*skinSelector.setValueForState(this.verticalScrollBarIncrementButtonHoverSkinTextures, Button.STATE_HOVER, false);
			skinSelector.setValueForState(this.verticalScrollBarIncrementButtonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.verticalScrollBarIncrementButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
			*/
			button.stateToSkinFunction = skinSelector.updateValue;
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.smallControlSize
			};

			button.defaultIcon = new Image(this.verticalScrollBarIncrementButtonIconTexture);
			button.disabledIcon = new Image(this.verticalScrollBarIncrementButtonDisabledIconTexture);

			var incrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
			incrementButtonDisabledIcon.alpha = 0;
			button.disabledIcon = incrementButtonDisabledIcon;

			button.keepDownStateOnRollOut = true;
			button.hasLabelTextRenderer = false;
		}

		protected function setNumericStepperIncrementButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.verticalScrollBarDecrementButtonUpSkinTextures;
			/*skinSelector.setValueForState(this.verticalScrollBarDecrementButtonHoverSkinTextures, Button.STATE_HOVER, false);
			skinSelector.setValueForState(this.verticalScrollBarDecrementButtonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.verticalScrollBarDecrementButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
			*/
			button.stateToSkinFunction = skinSelector.updateValue;
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.smallControlSize
			};

			button.defaultIcon = new Image(this.verticalScrollBarDecrementButtonIconTexture);
			button.disabledIcon = new Image(this.verticalScrollBarDecrementButtonDisabledIconTexture);

			var incrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
			incrementButtonDisabledIcon.alpha = 0;
			button.disabledIcon = incrementButtonDisabledIcon;

			button.keepDownStateOnRollOut = true;
			button.hasLabelTextRenderer = false;
		}

	//-------------------------
	// PageIndicator
	//-------------------------

		protected function setPageIndicatorStyles(pageIndicator:PageIndicator):void
		{
			pageIndicator.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
			pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
			pageIndicator.gap = this.gutterSize;
			pageIndicator.padding = this.smallGutterSize;
		}

	//-------------------------
	// Panel
	//-------------------------

		protected function setPanelStyles(panel:Panel):void
		{
			this.setScrollerStyles(panel);

			var backgroundSkin:Scale9Image = new Scale9Image(this.backgroundPopUpSkinTextures, this.scale);
			panel.backgroundSkin = backgroundSkin;
			panel.padding = this.gutterSize;
			panel.outerPadding = this.borderSize;
		}

		protected function setPopupHeaderStyles(header:Header):void
		{
			header.minWidth = this.gridSize;
			header.minHeight = this.gridSize;
			header.paddingTop = this.smallGutterSize;
			header.paddingBottom = this.smallGutterSize;
			header.paddingRight = this.gutterSize;
			header.paddingLeft = this.gutterSize;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;

			var backgroundSkin:TiledImage = new TiledImage(this.headerPopupBackgroundSkinTexture, this.scale);
			backgroundSkin.width = backgroundSkin.height = this.controlSize;
			header.backgroundSkin = backgroundSkin;
			header.titleProperties.elementFormat = this.lightElementFormat;
		}

	//-------------------------
	// PanelScreen
	//-------------------------

		protected function setPanelScreenHeaderStyles(header:Header):void
		{
			this.setHeaderStyles(header);
			header.useExtraPaddingForOSStatusBar = true;
		}

	//-------------------------
	// PickerList
	//-------------------------

		protected function setPickerListStyles(list:PickerList):void
		{
			list.popUpContentManager = new DropDownPopUpContentManager();
		}

		protected function setPickerListListStyles(list:List):void
		{
			this.setListStyles(list);
			list.maxHeight = 110;
		}

		protected function setPickerListButtonStyles(button:Button):void
		{
			this.setButtonStyles(button);

			var defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.source = this.pickerListButtonIconTexture;
			defaultIcon.snapToPixels = true;
			button.defaultIcon = defaultIcon;

			button.gap = Number.POSITIVE_INFINITY; //fill as completely as possible
			button.minGap = 10;
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			button.iconPosition = Button.ICON_POSITION_RIGHT;
			button.paddingRight = 6;
		}

	//-------------------------
	// ProgressBar
	//-------------------------

		protected function setProgressBarStyles(progress:ProgressBar):void
		{
			var backgroundSkin:Scale9Image = new Scale9Image(this.backgroundSkinTextures, this.scale);
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				backgroundSkin.width = this.smallControlSize;
				backgroundSkin.height = this.wideControlSize;
			}
			else
			{
				backgroundSkin.width = this.wideControlSize;
				backgroundSkin.height = this.smallControlSize;
			}
			progress.backgroundSkin = backgroundSkin;

			var backgroundDisabledSkin:Scale9Image = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				backgroundDisabledSkin.width = this.smallControlSize;
				backgroundDisabledSkin.height = this.wideControlSize;
			}
			else
			{
				backgroundDisabledSkin.width = this.wideControlSize;
				backgroundDisabledSkin.height = this.smallControlSize;
			}
			progress.backgroundDisabledSkin = backgroundDisabledSkin;

			var fillSkin:Scale9Image = new Scale9Image(this.buttonUpSkinTextures, this.scale);
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				fillSkin.width = this.smallControlSize;
				fillSkin.height = this.progressBarFillMinSize;
			}
			else
			{
				fillSkin.width = this.progressBarFillMinSize;
				fillSkin.height = this.smallControlSize;
			}
			progress.fillSkin = fillSkin;

			var fillDisabledSkin:Scale9Image = new Scale9Image(this.buttonDisabledSkinTextures, this.scale);
			if(progress.direction == ProgressBar.DIRECTION_VERTICAL)
			{
				fillDisabledSkin.width = this.smallControlSize;
				fillDisabledSkin.height = this.progressBarFillMinSize;
			}
			else
			{
				fillDisabledSkin.width = this.progressBarFillMinSize;
				fillDisabledSkin.height = this.smallControlSize;
			}
			progress.fillDisabledSkin = fillDisabledSkin;
		}

	//-------------------------
	// Radio
	//-------------------------

		protected function setRadioStyles(radio:Radio):void
		{
			var iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.defaultValue = this.radioUpIconTexture;
			iconSelector.defaultSelectedValue = this.radioSelectedUpIconTexture;
			iconSelector.setValueForState(this.radioDownIconTexture, Button.STATE_DOWN, false);
			iconSelector.setValueForState(this.radioDisabledIconTexture, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(this.radioSelectedDownIconTexture, Button.STATE_DOWN, true);
			iconSelector.setValueForState(this.radioSelectedDisabledIconTexture, Button.STATE_DISABLED, true);
			iconSelector.displayObjectProperties =
			{
				scaleX: this.scale,
				scaleY: this.scale
			};
			radio.stateToIconFunction = iconSelector.updateValue;

			radio.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			radio.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			radio.selectedDisabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;

			radio.gap = this.smallGutterSize;
			radio.minWidth = this.controlSize;
			radio.minHeight = this.controlSize;
		}

	//-------------------------
	// ScrollBar
	//-------------------------

		protected function setHorizontalScrollBarStyles(scrollBar:ScrollBar):void
		{
			scrollBar.direction = ScrollBar.DIRECTION_HORIZONTAL;
			scrollBar.trackLayoutMode = ScrollBar.TRACK_LAYOUT_MODE_SINGLE;

			scrollBar.customIncrementButtonName = THEME_NAME_HORIZONTAL_SCROLL_BAR_INCREMENT_BUTTON;
			scrollBar.customDecrementButtonName = THEME_NAME_HORIZONTAL_SCROLL_BAR_DECREMENT_BUTTON;
			scrollBar.customThumbName = THEME_NAME_HORIZONTAL_SCROLL_BAR_THUMB;
			scrollBar.customMinimumTrackName = THEME_NAME_HORIZONTAL_SCROLL_BAR_MINIMUM_TRACK;
		}

		protected function setVerticalScrollBarStyles(scrollBar:ScrollBar):void
		{
			scrollBar.direction = ScrollBar.DIRECTION_VERTICAL;
			scrollBar.trackLayoutMode = ScrollBar.TRACK_LAYOUT_MODE_MIN_MAX;

			scrollBar.customIncrementButtonName = THEME_NAME_VERTICAL_SCROLL_BAR_INCREMENT_BUTTON;
			scrollBar.customDecrementButtonName = THEME_NAME_VERTICAL_SCROLL_BAR_DECREMENT_BUTTON;
			scrollBar.customThumbName = THEME_NAME_VERTICAL_SCROLL_BAR_THUMB;
			scrollBar.customMinimumTrackName = THEME_NAME_VERTICAL_SCROLL_BAR_MINIMUM_TRACK;
			scrollBar.customMaximumTrackName = THEME_NAME_VERTICAL_SCROLL_BAR_MAXIMUM_TRACK;
		}

		protected function setHorizontalScrollBarIncrementButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.horizontalScrollBarIncrementButtonUpSkinTextures;
			/*skinSelector.setValueForState(this.horizontalScrollBarIncrementButtonHoverSkinTextures, Button.STATE_HOVER, false);
			skinSelector.setValueForState(this.horizontalScrollBarIncrementButtonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.horizontalScrollBarIncrementButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
			*/
			button.stateToSkinFunction = skinSelector.updateValue;
			skinSelector.displayObjectProperties =
			{
				width: this.smallControlSize,
				height: this.smallControlSize
			};

			button.defaultIcon = new Image(this.horizontalScrollBarIncrementButtonIconTexture);
			button.disabledIcon = new Image(this.horizontalScrollBarIncrementButtonDisabledIconTexture);

			var incrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
			incrementButtonDisabledIcon.alpha = 0;
			button.disabledIcon = incrementButtonDisabledIcon;

			button.hasLabelTextRenderer = false;
		}

		protected function setHorizontalScrollBarDecrementButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.horizontalScrollBarDecrementButtonUpSkinTextures;
			/*skinSelector.setValueForState(this.horizontalScrollBarDecrementButtonHoverSkinTextures, Button.STATE_HOVER, false);
			skinSelector.setValueForState(this.horizontalScrollBarDecrementButtonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.horizontalScrollBarDecrementButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
			*/
			skinSelector.displayObjectProperties =
			{
				width: this.smallControlSize,
				height: this.smallControlSize
			};

			button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultIcon = new Image(this.horizontalScrollBarDecrementButtonIconTexture);
			button.disabledIcon = new Image(this.horizontalScrollBarDecrementButtonDisabledIconTexture);

			var decrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
			decrementButtonDisabledIcon.alpha = 0;
			button.disabledIcon = decrementButtonDisabledIcon;

			button.hasLabelTextRenderer = false;
		}

		protected function setHorizontalScrollBarThumbStyles(thumb:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: this.smallControlSize,
				height: this.smallControlSize,
				textureScale: this.scale
			};

			thumb.hasLabelTextRenderer = false;
		}

		protected function setHorizontalScrollBarMinimumTrackStyles(track:Button):void
		{
			track.defaultSkin = new Quad(this.smallControlSize, this.smallControlSize, SCROLL_BAR_TRACK_COLOR);
			track.downSkin = new Quad(this.smallControlSize, this.smallControlSize, SCROLL_BAR_TRACK_DOWN_COLOR);

			track.hasLabelTextRenderer = false;
		}

		protected function setHorizontalScrollBarMaximumTrackStyles(track:Button):void
		{
			track.defaultSkin = new Quad(this.smallControlSize, this.smallControlSize, SCROLL_BAR_TRACK_COLOR);
			track.downSkin = new Quad(this.smallControlSize, this.smallControlSize, SCROLL_BAR_TRACK_DOWN_COLOR);

			track.hasLabelTextRenderer = false;
		}

		protected function setVerticalScrollBarIncrementButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.verticalScrollBarIncrementButtonUpSkinTextures;
			/*skinSelector.setValueForState(this.verticalScrollBarIncrementButtonHoverSkinTextures, Button.STATE_HOVER, false);
			skinSelector.setValueForState(this.verticalScrollBarIncrementButtonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.verticalScrollBarIncrementButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
			*/
			button.stateToSkinFunction = skinSelector.updateValue;
			skinSelector.displayObjectProperties =
			{
				width: this.smallControlSize,
				height: this.smallControlSize
			};

			button.defaultIcon = new Image(this.verticalScrollBarIncrementButtonIconTexture);
			button.disabledIcon = new Image(this.verticalScrollBarIncrementButtonDisabledIconTexture);

			var incrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
			incrementButtonDisabledIcon.alpha = 0;
			button.disabledIcon = incrementButtonDisabledIcon;

			button.hasLabelTextRenderer = false;
		}

		protected function setVerticalScrollBarDecrementButtonStyles(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.verticalScrollBarDecrementButtonUpSkinTextures;
			/*skinSelector.setValueForState(this.verticalScrollBarDecrementButtonHoverSkinTextures, Button.STATE_HOVER, false);
			skinSelector.setValueForState(this.verticalScrollBarDecrementButtonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.verticalScrollBarDecrementButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
			*/
			skinSelector.displayObjectProperties =
			{
				width: this.smallControlSize,
				height: this.smallControlSize
			};

			button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultIcon = new Image(this.verticalScrollBarDecrementButtonIconTexture);
			button.disabledIcon = new Image(this.verticalScrollBarDecrementButtonDisabledIconTexture);

			var decrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
			decrementButtonDisabledIcon.alpha = 0;
			button.disabledIcon = decrementButtonDisabledIcon;

			button.hasLabelTextRenderer = false;
		}

		protected function setVerticalScrollBarThumbStyles(thumb:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: this.smallControlSize,
				height: this.smallControlSize,
				textureScale: this.scale
			};
			thumb.stateToSkinFunction = skinSelector.updateValue;

			thumb.hasLabelTextRenderer = false;
		}

		protected function setVerticalScrollBarMinimumTrackStyles(track:Button):void
		{
			track.defaultSkin = new Quad(this.smallControlSize, this.smallControlSize, SCROLL_BAR_TRACK_COLOR);
			track.downSkin = new Quad(this.smallControlSize, this.smallControlSize, SCROLL_BAR_TRACK_DOWN_COLOR);

			track.hasLabelTextRenderer = false;
		}

		protected function setVerticalScrollBarMaximumTrackStyles(track:Button):void
		{
			track.defaultSkin = new Quad(this.smallControlSize, this.smallControlSize, SCROLL_BAR_TRACK_COLOR);
			track.downSkin = new Quad(this.smallControlSize, this.smallControlSize, SCROLL_BAR_TRACK_DOWN_COLOR);

			track.hasLabelTextRenderer = false;
		}

	//-------------------------
	// ScrollContainer
	//-------------------------

		protected function setScrollContainerStyles(container:ScrollContainer):void
		{
			this.setScrollerStyles(container);
		}

		protected function setToolbarScrollContainerStyles(container:ScrollContainer):void
		{
			this.setScrollerStyles(container);
			if(!container.layout)
			{
				var layout:HorizontalLayout = new HorizontalLayout();
				layout.padding = this.gutterSize;
				layout.gap = this.smallGutterSize;
				container.layout = layout;
			}
			container.minWidth = this.gridSize;
			container.minHeight = this.gridSize;

			var backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture, this.scale);
			backgroundSkin.width = backgroundSkin.height = this.gridSize;
			container.backgroundSkin = backgroundSkin;
		}

	//-------------------------
	// ScrollText
	//-------------------------

		protected function setScrollTextStyles(text:ScrollText):void
		{
			this.setScrollerStyles(text);

			text.textFormat = this.scrollTextTextFormat;
			text.disabledTextFormat = this.scrollTextDisabledTextFormat;
			text.padding = this.gutterSize;
		}

	//-------------------------
	// SimpleScrollBar
	//-------------------------

		protected function setSimpleScrollBarStyles(scrollBar:SimpleScrollBar):void
		{
			if(scrollBar.direction == SimpleScrollBar.DIRECTION_HORIZONTAL)
			{
				scrollBar.paddingRight = this.scrollBarGutterSize;
				scrollBar.paddingBottom = this.scrollBarGutterSize;
				scrollBar.paddingLeft = this.scrollBarGutterSize;
				scrollBar.customThumbName = THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB;
			}
			else
			{
				scrollBar.paddingTop = this.scrollBarGutterSize;
				scrollBar.paddingRight = this.scrollBarGutterSize;
				scrollBar.paddingBottom = this.scrollBarGutterSize;
				scrollBar.customThumbName = THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB;
			}
		}

		protected function setHorizontalSimpleScrollBarThumbStyles(thumb:Button):void
		{
			var defaultSkin:Scale3Image = new Scale3Image(this.horizontalSimpleScrollBarThumbSkinTextures, this.scale);
			defaultSkin.width = this.smallControlSize;
			thumb.defaultSkin = defaultSkin;

			thumb.hasLabelTextRenderer = false;
		}

		protected function setVerticalSimpleScrollBarThumbStyles(thumb:Button):void
		{
			var defaultSkin:Scale3Image = new Scale3Image(this.verticalSimpleScrollBarThumbSkinTextures, this.scale);
			defaultSkin.height = this.smallControlSize;
			thumb.defaultSkin = defaultSkin;

			thumb.hasLabelTextRenderer = false;
		}

	//-------------------------
	// Slider
	//-------------------------

		protected function setSliderStyles(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_MIN_MAX;
			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				slider.customMinimumTrackName = THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK;
				slider.customMaximumTrackName = THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK;
			}
			else
			{
				slider.customMinimumTrackName = THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK;
				slider.customMaximumTrackName = THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK;
			}
		}

		protected function setSliderThumbStyles(thumb:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: this.smallControlSize,
				height: this.smallControlSize,
				textureScale: this.scale
			};
			thumb.stateToSkinFunction = skinSelector.updateValue;

			thumb.minWidth = this.smallControlSize;
			thumb.minHeight = this.smallControlSize;

			thumb.hasLabelTextRenderer = false;
		}

		protected function setHorizontalSliderMinimumTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				textureScale: this.scale
			};
			skinSelector.displayObjectProperties.width = this.wideControlSize;
			skinSelector.displayObjectProperties.height = this.smallControlSize;
			track.stateToSkinFunction = skinSelector.updateValue;

			track.hasLabelTextRenderer = false;
		}

		protected function setHorizontalSliderMaximumTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				textureScale: this.scale
			};
			skinSelector.displayObjectProperties.width = this.wideControlSize;
			skinSelector.displayObjectProperties.height = this.smallControlSize;
			track.stateToSkinFunction = skinSelector.updateValue;

			track.hasLabelTextRenderer = false;
		}

		protected function setVerticalSliderMinimumTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				textureScale: this.scale
			};
			skinSelector.displayObjectProperties.width = this.smallControlSize;
			skinSelector.displayObjectProperties.height = this.wideControlSize;
			track.stateToSkinFunction = skinSelector.updateValue;

			track.hasLabelTextRenderer = false;
		}

		protected function setVerticalSliderMaximumTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				textureScale: this.scale
			};
			skinSelector.displayObjectProperties.width = this.smallControlSize;
			skinSelector.displayObjectProperties.height = this.wideControlSize;
			track.stateToSkinFunction = skinSelector.updateValue;

			track.hasLabelTextRenderer = false;
		}

	//-------------------------
	// TabBar
	//-------------------------

		protected function setTabBarStyles(tabBar:TabBar):void
		{
			tabBar.distributeTabSizes = false;
			tabBar.horizontalAlign = TabBar.HORIZONTAL_ALIGN_LEFT;
			tabBar.verticalAlign = TabBar.VERTICAL_ALIGN_JUSTIFY;
		}

		protected function setTabStyles(tab:ToggleButton):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.tabUpSkinTextures;
			skinSelector.defaultSelectedValue = this.tabSelectedSkinTextures;
			skinSelector.setValueForState(this.tabDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.tabDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.tabSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			tab.stateToSkinFunction = skinSelector.updateValue;

			tab.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			tab.defaultSelectedLabelProperties.elementFormat = this.darkUIElementFormat;
			tab.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			tab.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;

			tab.paddingTop = this.smallGutterSize;
			tab.paddingBottom = this.smallGutterSize;
			tab.paddingLeft = this.gutterSize;
			tab.paddingRight = this.gutterSize;
			tab.gap = this.smallGutterSize;
			tab.minWidth = tab.minHeight = this.controlSize;
		}

	//-------------------------
	// TextArea
	//-------------------------

		protected function setTextAreaStyles(textArea:TextArea):void
		{
			this.setScrollerStyles(textArea);

			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, TextArea.STATE_DISABLED);
			skinSelector.setValueForState(this.backgroundFocusedSkinTextures, TextArea.STATE_FOCUSED);
			skinSelector.displayObjectProperties =
			{
				width: this.wideControlSize * 2,
				height: this.wideControlSize,
				textureScale: this.scale
			};
			textArea.stateToSkinFunction = skinSelector.updateValue;

			textArea.padding = this.gutterSize;

			textArea.textEditorProperties.textFormat = this.scrollTextTextFormat;
			textArea.textEditorProperties.disabledTextFormat = this.scrollTextDisabledTextFormat;
		}

	//-------------------------
	// TextInput
	//-------------------------

		protected function setBaseTextInputStyles(input:TextInput):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, TextInput.STATE_DISABLED);
			skinSelector.setValueForState(this.backgroundFocusedSkinTextures, TextInput.STATE_FOCUSED);
			skinSelector.displayObjectProperties =
			{
				width: this.wideControlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			input.stateToSkinFunction = skinSelector.updateValue;

			//input.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
			//input.focusPadding = -1;

			input.minWidth = input.minHeight = this.controlSize;
			input.gap = this.smallGutterSize;
			input.paddingTop = this.smallGutterSize;
			input.paddingBottom = this.smallGutterSize;
			input.paddingLeft = this.gutterSize;
			input.paddingRight = this.gutterSize;
			input.textEditorProperties.elementFormat = this.lightElementFormat;
			input.textEditorProperties.disabledElementFormat = this.disabledElementFormat;
			input.textEditorProperties.cursorSkin = new Quad(1, 1, LIGHT_TEXT_COLOR);
			input.textEditorProperties.selectionSkin = new Quad(1, 1, TEXT_SELECTION_BACKGROUND_COLOR);

			input.promptProperties.elementFormat = this.lightElementFormat;
			input.promptProperties.disabledElementFormat = this.disabledElementFormat;
		}

		protected function setTextInputStyles(input:TextInput):void
		{
			this.setBaseTextInputStyles(input);
		}

		protected function setSearchTextInputStyles(input:TextInput):void
		{
			this.setBaseTextInputStyles(input);

			var searchIcon:ImageLoader = new ImageLoader();
			searchIcon.source = this.searchIconTexture;
			searchIcon.snapToPixels = true;
			input.defaultIcon = searchIcon;
		}

	//-------------------------
	// ToggleSwitch
	//-------------------------

		protected function setToggleSwitchStyles(toggle:ToggleSwitch):void
		{
			toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;

			toggle.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			toggle.onLabelProperties.elementFormat = this.selectedUIElementFormat;
		}

		protected function setToggleSwitchThumbStyles(thumb:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			thumb.stateToSkinFunction = skinSelector.updateValue;

			thumb.minWidth = this.controlSize;
			thumb.minHeight = this.controlSize;

			thumb.hasLabelTextRenderer = false;
		}

		protected function setToggleSwitchTrackStyles(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: Math.round(this.controlSize * 2.5),
				height: this.controlSize,
				textureScale: this.scale
			};
			track.stateToSkinFunction = skinSelector.updateValue;

			track.hasLabelTextRenderer = false;
		}

	}
}