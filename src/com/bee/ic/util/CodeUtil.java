package com.bee.ic.util;

import junit.framework.Assert;

public class CodeUtil {

	static char[] letterCode = { 'a', 'b', 'c', 'd', 'r', 'f', 'g', 'h', 'i' , 'j',
			'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
			'y', 'z' };

	static char[] numberCode = { '0', '1', '2', '3', '4', '5', '6', '7', '8',
			'9' };

	public static String makeCode(int letter, int number) {
		StringBuilder sb = new StringBuilder();
		Assert.assertTrue(letter >= 0);
		Assert.assertTrue(number >= 0);
		for (int i = 0; i < letter; i++) {
			int index = (int) (Math.random() * letterCode.length);
			sb.append(letterCode[index]);
		}
		for (int i = 0; i < number; i++) {
			int index = (int) (Math.random() * numberCode.length);
			sb.append(numberCode[index]);
		}
		return sb.toString();
	}

	public static void main(String[] args) {
		for (int k = 0; k < 10; k++) {
			System.out.println(makeCode(1, 5));
		}
	}

}
