package com.my.service;

import com.my.dto.MemberDTO;

public interface MemberService {
	public void register(MemberDTO dto) throws Exception;
	public MemberDTO login(MemberDTO dto) throws Exception;
	public void memberUpdate(MemberDTO dto) throws Exception;
	public void memberDelete(MemberDTO dto) throws Exception;
	public int passChk(MemberDTO dto) throws Exception;
	public int idChk(MemberDTO dto) throws Exception;
}
