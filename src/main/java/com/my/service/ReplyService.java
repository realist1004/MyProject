package com.my.service;

import java.util.List;

import com.my.dto.ReplyDTO;

public interface ReplyService {
	public List<ReplyDTO> readReply(int bno) throws Exception;
	public void writeReply(ReplyDTO dto) throws	Exception;
	public void updateReply(ReplyDTO dto) throws Exception;
	public void deleteReply(ReplyDTO dto) throws Exception;
	public ReplyDTO selectReply(int rno) throws Exception;
}
