package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.model.BoardMapper;
import com.my.model.Criteria;
import com.my.model.SearchCriteria;
import com.my.model.BoardDTO;

@Service
public class  BoardServiceImpl implements BoardService{
	@Autowired
	private BoardMapper boardMapper;
	@Override
	public List<BoardDTO> listAll(SearchCriteria scri) throws Exception {
		
		return boardMapper.listAll(scri);
	}
	
	@Override
	public BoardDTO read(int bno) throws Exception {
			
		return boardMapper.read(bno);
	}
	@Override
	public void update(BoardDTO dto) throws Exception {
		
		boardMapper.update(dto);
	}
	@Override
	public void delete(int bno) throws Exception {
		
		boardMapper.delete(bno);
	}
	@Override
	public void hitUpdate(int bno) throws Exception {
		boardMapper.hitUpdate(bno);
		
	}

	@Override
	public void write(BoardDTO dto) throws Exception {
		boardMapper.write(dto);
		
	}

	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		
		return boardMapper.listCount(scri);
	}
	
	
	
	

	
	
	
}
