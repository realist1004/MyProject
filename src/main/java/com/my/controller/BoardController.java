package com.my.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.my.dto.BoardDTO;
import com.my.dto.Criteria;
import com.my.dto.PageMaker;
import com.my.dto.ReplyDTO;
import com.my.dto.SearchCriteria;
import com.my.mapper.ReplyMapper;
import com.my.service.BoardService;
import com.my.service.ReplyService;
// jsp페이지에 파리미터 값이 제대로 담겨있는지 log나 디버깅으로 확인하는 방법 알아보기
// 참고 사이트 보면서 만들기 댓글먼저하고, 회원가입, 로그인, 파일첨부 등.. (로그인 네이버API 기능도 넣기)
@Controller
public class BoardController {

	private static final Logger logger= LoggerFactory.getLogger(BoardController.class);
	@Autowired
	private BoardService boardService;
	@Autowired
	private	ReplyService replyService;
	@RequestMapping("/board") // "Board_list.do"를 모두 /로 바꿔줌.
	public String list(Model model,@ModelAttribute("scri") SearchCriteria scri ) throws Exception {// https://galid1.tistory.com/769 참고
		logger.info("list");
		model.addAttribute("list", boardService.listAll(scri)); //scri는 dto랑 비슷한 개념이라고 생각하면 이해하기쉬움. 
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri); // 현재 페이지에 보여지는 기능
		pageMaker.setTotalCount(boardService.listCount(scri)); // 카운트하여 페이징처리
		
		model.addAttribute("pageMaker", pageMaker);
		return "board_list";
	}

	@RequestMapping("/board_write.do")
	public String insert() {
		logger.info("insert");
		return "board_insert";
	}

	@RequestMapping("/board_writeOk.do")
	public String insetOk(BoardDTO dto, MultipartHttpServletRequest boardRequest) throws Exception {
		logger.info("insertOk");
		boardService.write(dto, boardRequest);		
		return "redirect:/board";//"redirect:Board_list.do";
	}
	// 게시판 조회
	@RequestMapping("/board_cont.do")
	public String cont(BoardDTO dto, @ModelAttribute("scri") SearchCriteria scri , Model model) throws Exception {
		logger.info("read????");
		boardService.hitUpdate(dto.getBoard_no());
		model.addAttribute("cont", boardService.read(dto.getBoard_no()));
		model.addAttribute("scri", scri);
		
		List<ReplyDTO> replyList = replyService.readReply(dto.getBoard_no());
		model.addAttribute("replyList", replyList);
		
		List<Map<String, Object>> fileList = boardService.selectFileList(dto.getBoard_no());
		model.addAttribute("file", fileList);
		return "board_cont";

	}

	@RequestMapping("board_update.do")
	public String update(BoardDTO dto,@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
		logger.info("updateView");
		model.addAttribute("modify", boardService.read(dto.getBoard_no()));
		model.addAttribute("scri", scri);
		return "board_update";
	}

	@RequestMapping("updateOk.do")
	public String updateOk(BoardDTO dto, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("updateOk");
		boardService.update(dto);
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		return "redirect:/board";

	}

	@RequestMapping("board_delete.do")
	public String delete(BoardDTO dto, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("delete");
		boardService.delete(dto.getBoard_no());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		return "redirect:/board";
	}
	
	//댓글 작성
		@RequestMapping("replyWrite")
		public String replyWrite(ReplyDTO dto, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
			logger.info("reply Write");
			
			replyService.writeReply(dto);
			
			rttr.addAttribute("board_no", dto.getBoard_no());//bno로 입력하면 dto의 이름과 달라 해당 게시글을 못불러옴
			rttr.addAttribute("page", scri.getPage());
			rttr.addAttribute("perPageNum", scri.getPerPageNum());
			rttr.addAttribute("searchType", scri.getSearchType());
			rttr.addAttribute("keyword", scri.getKeyword());
			
			return "redirect:board_cont.do";
		}
		//댓글 수정 GET
		@RequestMapping(value="/replyUpdateView", method = RequestMethod.GET) // 굳이 get,post를 안써도된다. 생략하면 jsp에 method="post" 으로 작성하면 적용됨
		public String replyUpdateView(ReplyDTO dto, SearchCriteria scri, Model model) throws Exception {
			logger.info("reply Write");
			
			model.addAttribute("replyUpdate", replyService.selectReply(dto.getRno()));
			model.addAttribute("scri", scri);
			
			return "replyUpdateView";
		}
		
		//댓글 수정 POST
		@RequestMapping(value="/replyUpdate", method = RequestMethod.POST)
		public String replyUpdate(ReplyDTO dto, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
			logger.info("reply Write");
			
			replyService.updateReply(dto);
			
			rttr.addAttribute("board_no", dto.getBoard_no());
			rttr.addAttribute("page", scri.getPage());
			rttr.addAttribute("perPageNum", scri.getPerPageNum());
			rttr.addAttribute("searchType", scri.getSearchType());
			rttr.addAttribute("keyword", scri.getKeyword());
			
			return "redirect:board_cont.do";
		}
		//댓글 삭제 GET
		@RequestMapping(value="/replyDeleteView", method = RequestMethod.GET)
		public String replyDeleteView(ReplyDTO dto, SearchCriteria scri, Model model) throws Exception {
			logger.info("reply Write");
			
			model.addAttribute("replyDelete", replyService.selectReply(dto.getRno()));
			model.addAttribute("scri", scri);
			

			return "replyDeleteView";
		}
		
		//댓글 삭제
		@RequestMapping(value="/replyDelete", method = RequestMethod.POST)
		public String replyDelete(ReplyDTO dto, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
			logger.info("reply Write");
			
			replyService.deleteReply(dto);
			
			rttr.addAttribute("board_no", dto.getBoard_no());
			rttr.addAttribute("page", scri.getPage());
			rttr.addAttribute("perPageNum", scri.getPerPageNum());
			rttr.addAttribute("searchType", scri.getSearchType());
			rttr.addAttribute("keyword", scri.getKeyword());
			
			return "redirect:board_cont.do";
		}
		
		//첨부파일 다운
		@RequestMapping("/fileDown")
		public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception	{
			Map<String, Object> resultMap = boardService.selectFileInfo(map);
			String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
			String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
			
			// 파일 저장했던 위치에서 첨부파일을 읽어 byte[] 형식으로 변환한다.
			byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\board\\file\\" + storedFileName));
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush(); //전송하고 데이터를 비워줌
			response.getOutputStream().close(); // 닫음
		}
}
