package com.my.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.my.dto.BoardDTO;
import com.my.dto.SearchCriteria;
import com.my.mapper.BoardMapper;
import com.my.util.FileUtils;

@Service
public class  BoardServiceImpl implements BoardService{
	@Resource(name = "fileUtils")
	private FileUtils fileUtils;
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
	public void update(BoardDTO dto, String[] files, String[] fileNames, MultipartHttpServletRequest boardRequest) throws Exception {
		boardMapper.update(dto);
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(dto, files, fileNames, boardRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for(int i=0; i<size; i++) {
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) { // 추가 첨부파일이 있을경우.
				boardMapper.insertFile(tempMap);
			}else { // 파일 삭제 할 경우
				boardMapper.updateFile(tempMap);
			}
		}
	}
	@Override
	public void delete(int bno) throws Exception {
		
		boardMapper.delete(bno);
	}
	@Override
	public void hitUpdate(int bno) throws Exception {
		boardMapper.hitUpdate(bno);
		
	}
	// 게시글 작성
	@Override
	public void write(BoardDTO dto, MultipartHttpServletRequest boardRequest) throws Exception {
		boardMapper.write(dto);
		
		List<Map<String, Object>> list = fileUtils.parselnertFileInfo(dto, boardRequest);
		int size = list.size();
		for(int i=0; i<size; i++) {
			boardMapper.insertFile(list.get(i));
		}
	}

	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		
		return boardMapper.listCount(scri);
	}
	// 첨부파일 조회
	@Override
	public List<Map<String, Object>> selectFileList(int bno) throws Exception {
		
		return boardMapper.selectFileList(bno);
	}
	// 첨부파일 다운로드
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		
		return boardMapper.selectFileInfo(map);
	}

	
	
	
	
	

	
	
	
}
