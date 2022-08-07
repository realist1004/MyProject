package com.my.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.my.dto.BoardDTO;
import com.my.dto.SearchCriteria;

public interface BoardService {
	
	public List<BoardDTO> listAll(SearchCriteria scri) throws Exception;
	public int listCount(SearchCriteria scri) throws Exception;
	public void write(BoardDTO dto, MultipartHttpServletRequest boardRequest) throws Exception;
	public BoardDTO read(int bno) throws Exception;
	public void update (BoardDTO dto, String[] files, String[] fileNames, MultipartHttpServletRequest boardRequest) throws Exception;
	public void delete (int bno) throws Exception;
	public List<Map<String, Object>> selectFileList(int bno) throws Exception; // 첨부파일 조회
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception; // 첨부파일 다운로드	
}
