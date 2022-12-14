package com.shoeper.shoeperApp.member.model.service;

import java.util.HashMap;

import com.shoeper.shoeperApp.member.model.vo.Member;

public interface MemberService {
	
	Member selectOneMember(String memberId);
	
	int insertMember(Member member);
	
	int insertBrandMember(Member member);
	
	int updateMember(Member member);
	
	void deleteMember(String memberId,int memberNo);

	Member selectMemberID(Member member);

	int updateNewPass(Member member);

	// 아이디 중복확인
	int checkIdDuplicate(String memberId);

	String selectEmailCount(String email);

}
