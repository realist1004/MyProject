package com.my.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;



@Mapper //굳이 안붙혀도 mybatis:scan으로 찾아서 해줌 // MyBatis-Spring-Boot-Starter 디펜던시로 @Mapper를 입력하면 자동으로 스캔함.
public interface BoardMapper {
	
	public List<BoardDTO> listAll(SearchCriteria scri) throws Exception;
	public int listCount(SearchCriteria scri) throws Exception;
	public void write(BoardDTO dto) throws Exception;
	public BoardDTO read(int bno) throws Exception;
	public void hitUpdate (int bno) throws Exception;
	public void update (BoardDTO dto) throws Exception;
	public void delete (int bno) throws Exception;
	
	
}
