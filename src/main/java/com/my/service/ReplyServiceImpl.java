package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dto.ReplyDTO;
import com.my.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private	ReplyMapper mapper;

	@Override
	public List<ReplyDTO> readReply(int bno) throws Exception {
		
		return mapper.readReply(bno);
	}

	@Override
	public void writeReply(ReplyDTO dto) throws Exception {
		mapper.writeReply(dto);
		
	}

	@Override
	public void updateReply(ReplyDTO dto) throws Exception {
		mapper.updateReply(dto);
		
	}

	@Override
	public void deleteReply(ReplyDTO dto) throws Exception {
		mapper.deleteReply(dto);
		
	}

	@Override
	public ReplyDTO selectReply(int rno) throws Exception {
		
		return mapper.selectReply(rno);
	}

}
