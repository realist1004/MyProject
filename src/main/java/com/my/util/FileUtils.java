package com.my.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.my.dto.BoardDTO;

@Component("fileUtils") // FileUtils은 첨부파일의 정보를 이용하여 여러가지 조작을 할 클래스입니다.
public class FileUtils {
	
	private static final String filePath = "C:\\board\\file\\";
	
	public List<Map<String, Object>> parselnertFileInfo(BoardDTO boardDTO,
			MultipartHttpServletRequest boardRequest) throws Exception{
		/*
		Iterator은 데이터들의 집합체? 에서 컬렉션으로부터 정보를 얻어올 수 있는 인터페이스입니다.
		List나 배열은 순차적으로 데이터의 접근이 가능하지만, Map등의 클래스들은 순차적으로 접근할 수가 없습니다.
		Iterator을 이용하여 Map에 있는 데이터들을 while문을 이용하여 순차적으로 접근합니다.
	*/
		
		Iterator<String> iterator = boardRequest.getFileNames();
		
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null;
		
		int board_no = boardDTO.getBoard_no();
		
		File file = new File(filePath);
		if(file.exists()== false) { // "C:\\board\\file\\";  이 경로에 있는지 확인 후 같은 폴더가 없으면 
			file.mkdirs(); // 자동생성됨
		}
		//hasNext() : 읽어올 요소가 남아있는지 확인하는 메서드, 요소가 있으면 true, 없으면 false
		//next() : 다음 데이터를 반환
		while(iterator.hasNext()) { 
			multipartFile = boardRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false) { // 파일이 있을 경우
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")); // lastIndexOf(".") 는 .이 있는 문자열까지
				storedFileName = getRandomString() + originalFileExtension; // getRandomString() 메서드는 32글자의 랜덤한 문자열(숫자포함)을 만들어서 반환해주는 기능을 합니다.
				
				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);
				listMap = new HashMap<String, Object>();
				listMap.put("BOARD_NO", board_no);
				listMap.put("ORG_FILE_NAME", originalFileName);
				listMap.put("STORED_FILE_NAME", storedFileName);
				listMap.put("FILE_SIZE", multipartFile.getSize());
				list.add(listMap);
			
			}
		}
		return list;		
	}
	public static String getRandomString() {
		return UUID.randomUUID().toString().replace("-", ""); // replace("-", "") -를 공백으로 바꿈
	}
}
