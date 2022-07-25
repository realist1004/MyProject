package com.my.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.my.dto.BoardDTO;
import com.my.dto.SearchCriteria;



@Mapper //굳이 안붙혀도 mybatis:scan으로 찾아서 해줌(스프링레거시) // MyBatis-Spring-Boot-Starter 디펜던시로 @Mapper를 입력하면 자동으로 스캔함.
public interface BoardMapper {
	
	public List<BoardDTO> listAll(SearchCriteria scri) throws Exception;
	public int listCount(SearchCriteria scri) throws Exception;
	public void write(BoardDTO dto) throws Exception;
	public BoardDTO read(int bno) throws Exception;
	public void hitUpdate (int bno) throws Exception;
	public void update (BoardDTO dto) throws Exception;
	public void delete (int bno) throws Exception;
	public void insertFile(Map<String, Object> map) throws Exception;
	
}
