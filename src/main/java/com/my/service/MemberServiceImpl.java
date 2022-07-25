package com.my.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dto.MemberDTO;
import com.my.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	MemberMapper mapper;
	@Override
	public void register(MemberDTO dto) throws Exception {
		mapper.register(dto);
		
	}
	@Override
	public MemberDTO login(MemberDTO dto) throws Exception {
		return mapper.login(dto);
	}
	@Override
	public void memberUpdate(MemberDTO dto) throws Exception {
		mapper.memberUpdate(dto);
		
	}
	@Override
	public void memberDelete(MemberDTO dto) throws Exception {
		mapper.memberDelete(dto);
		
	}
	@Override
	public int passChk(MemberDTO dto) throws Exception {
		int result = mapper.passChk(dto);
		return result;
	}
	@Override
	public int idChk(MemberDTO dto) throws Exception {
		int result = mapper.idChk(dto);
		return result;
	}

}
