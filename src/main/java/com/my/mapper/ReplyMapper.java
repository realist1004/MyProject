package com.my.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.my.dto.ReplyDTO;

@Mapper
public interface ReplyMapper {
	public List<ReplyDTO> readReply(int bno) throws Exception;
	public void writeReply(ReplyDTO dto) throws	Exception;
	public void updateReply(ReplyDTO dto) throws Exception;
	public void deleteReply(ReplyDTO dto) throws Exception;
	public ReplyDTO selectReply(int rno) throws Exception;
	
}
