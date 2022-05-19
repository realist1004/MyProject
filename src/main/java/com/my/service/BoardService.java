package com.my.service;

import java.util.List;

import com.my.model.BoardDTO;
import com.my.model.Criteria;
import com.my.model.SearchCriteria;

public interface BoardService {
	
	public List<BoardDTO> listAll(SearchCriteria scri) throws Exception;
	public int listCount(SearchCriteria scri) throws Exception;
	public void write(BoardDTO dto) throws Exception;
	public BoardDTO read(int bno) throws Exception;
	public void update (BoardDTO dto) throws Exception;
	public void delete (int bno) throws Exception;
	public void hitUpdate (int bno) throws Exception;
}
