package util;

using StringTools;

/**
	* using StrTools
	*

 */
class StrTools {
	public static function removeDoubleSpace(str:String):String {
		return str.replace(' ', ' ');
	}

	public static function removeSpace(str:String):String {
		return str.replace(' ', '');
	}

	public static function removeTab(str:String):String {
		return str.replace('\t', '');
	}

	public static function removeEnter(str:String):String {
		return str.replace('\r\n', '').replace('\n', '').replace('\r', '');
	}

	public static function removeHidden(str:String):String {
		return str.replace(' ', '').replace('\t', '').replace('\r\n', '').replace('\n', '').replace('\r', ''); // remove number, remove spaces, returns
	}
}
