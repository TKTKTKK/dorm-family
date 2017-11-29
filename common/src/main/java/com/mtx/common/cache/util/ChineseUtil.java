package com.mtx.common.cache.util;

/**
 * @author
 */
public class ChineseUtil {

    /**
     * Chinese character to unicode
     *
     * @param str
     * @return
     */
    public static String toUnicode(String str) {
        String result = "";
        for (int i = 0; i < str.length(); i++) {
            int chr = str.charAt(i);
            if (chr >= 19968 && chr <= 171941) {//汉字范围 \u4e00-\u9fa5 (中文)
                result += "\\u" + Integer.toHexString(chr);
            } else {
                result += str.charAt(i);
            }
        }
        return result;
    }

    /**
     * check if is chinese
     *
     * @param c
     * @return
     */
    public static boolean isChinese(char c) {
        Character.UnicodeBlock ub = Character.UnicodeBlock.of(c);
        return ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS
                || ub == Character.UnicodeBlock.CJK_COMPATIBILITY_IDEOGRAPHS
                || ub == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A
                || ub == Character.UnicodeBlock.GENERAL_PUNCTUATION
                || ub == Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION
                || ub == Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS;
    }

    public static void main(String[] args) {
        String str = "100kV你好";
        String result = ChineseUtil.toUnicode(str);
        System.out.println(result);
    }
}
