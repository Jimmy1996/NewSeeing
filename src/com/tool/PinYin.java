package com.tool;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

public class PinYin {  
      
    /** 
    * 汉字转拼音的方法 
    * @param name 汉字 
    * @return 拼音 
    */  
    public String HanyuToPinyin(String input){  
        
        StringBuilder pinyin = new StringBuilder();
        for (int i = 0; i < input.length(); i++) {
	        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
	        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
	        defaultFormat.setVCharType(HanyuPinyinVCharType.WITH_V);
	        char c = input.charAt(i);
	        String[] pinyinArray = null;
	         try {
	        	 pinyinArray = PinyinHelper.toHanyuPinyinStringArray(c, defaultFormat);
	          } catch (BadHanyuPinyinOutputFormatCombination e) {
	             e.printStackTrace();
	         }
	         if (pinyinArray != null) {
	            pinyin.append(pinyinArray[0]);
	          } else if (c != ' ') {
	              pinyin.append(input.charAt(i));
	          }
          }
      
           return pinyin.toString().trim().toLowerCase();
    }  
   
//    public static void main(String[] args) {  
//        System.out.println(new PinYin().HanyuToPinyin("testw我的野蛮女友"));  
//    }      
}  