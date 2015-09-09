/**
 * 
 */
package com.bee.ic.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

/**
 * 请求校验工具类
 * 
 * @author BloodLee
 *
 */
public class SignUtil {

	private static String token = "beexbee_cjb";
	
	/**
	 * 校验签名
	 * 
	 * @param signature
	 * @param timestamp
	 * @param nonce
	 * @return
	 */
	public static boolean checkSignature(String signature, String timestamp, String nonce) {
		String[] paramArr = new String[] { token, timestamp, nonce };
		Arrays.sort(paramArr);
		
		String content = paramArr[0].concat(paramArr[1]).concat(paramArr[2]);
		
		String ciphertext = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			byte[] digest = md.digest(content.toString().getBytes());
			ciphertext = byteToStr(digest);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return ciphertext != null ? ciphertext.equals(signature.toUpperCase()) : false;
	}
	
	/**
	 * 将数组转换为十六进制字符串
	 * 
	 * @param byteArray
	 * @return
	 */
	private static String byteToStr(byte[] byteArray) {
		String strDigest = "";
		for (int i = 0; i < byteArray.length; i++) {
			strDigest += byteToHexStr(byteArray[i]);
		}
		return strDigest;
	}
	
	/**
	 * 将字节转换为十六进制字符串
	 * 
	 * @param mByte
	 * @return
	 */
	private static String byteToHexStr(byte mByte) {
		char[] Digit = { '0', '1', '2', '3', '4', '5','6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		
		char[] tempArr = new char[2];
		tempArr[0] = Digit[(mByte >>> 4) & 0x0f];
		tempArr[1] = Digit[mByte & 0x0f];
		
		String s = new String(tempArr);
		return s;
	}
}
