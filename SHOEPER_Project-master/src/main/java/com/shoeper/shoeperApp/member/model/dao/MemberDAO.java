package com.shoeper.shoeperApp.member.model.dao;

import com.shoeper.shoeperApp.member.model.vo.Member;

public interface MemberDAO {

	Member selectOneMember(String memberId);
	
	int insertMember(Member member);
	
	int insertBrandMember(Member member);
	
	int updateMember(Member member);
	
	void deleteMember(String memberId, int memberNo );

	Member selectMemberID(Member member);

	int updateNewPass(Member member);

	// 중고회원 아이디 중복 체크
	int checkIdDuplicate(String memberId);

	String selectEmailCount(String email);
	
	
	
}

	