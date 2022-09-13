package com.shoeper.shoeperApp.member.exception;

public class MemberException extends RuntimeException {
									// runtime 바꿔주기 

	public MemberException(String message) {
		super("회원 ERROR :: " + message);
	}

}
