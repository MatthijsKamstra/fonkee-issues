package util;

using StringTools;

/**
 * using IntTools
 *
 * trace(0.lpadNr()); // '00'
 */
class IntTools {
	/**
	 * add an extra zero to the nr (if needed)
	 *
	 * in: 2
	 * out: '02'
	 *
	 * @param nr
	 */
	public static function lpadNr(nr:Int):String {
		return '${nr}'.lpad('0', 2);
	}
}
