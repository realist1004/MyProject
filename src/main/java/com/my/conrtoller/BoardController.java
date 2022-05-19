package com.my.conrtoller;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.my.model.BoardDTO;
import com.my.model.Criteria;
import com.my.model.PageMaker;
import com.my.model.SearchCriteria;
import com.my.service.BoardService;
// index 화면 헤더, 풋터를 따로 만들러어 incluod?로 만들고 조회,수정, 글쓰기에도 똑같이 화면나오게 적용
@Controller
public class BoardController {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Autowired
	private BoardService boardService;

	@RequestMapping("/")
	public String list(Model model,@ModelAttribute("scri") SearchCriteria scri ) throws Exception {// https://galid1.tistory.com/769 참고
		logger.info("list");
		model.addAttribute("list", boardService.listAll(scri)); //scri는 dto랑 비슷한 개념이라고 생각하면 이해하기쉬움. 
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri); // 현재 페이지에 보여지는 기능
		pageMaker.setTotalCount(boardService.listCount(scri)); // 카운트하여 페이징처리
		
		model.addAttribute("pageMaker", pageMaker);
		return "index";
	}

	@RequestMapping("/board_write.do")
	public String insert() {
		logger.info("insert");
		return "board_insert";
	}

	@RequestMapping("/board_writeOk.do")
	public String insetOk(BoardDTO dto) throws Exception {
		logger.info("insertOk");
		boardService.write(dto);		
		return "redirect:Board_list.do";
	}

	@RequestMapping("/board_cont.do")
	public String cont(BoardDTO dto, @ModelAttribute("scri") SearchCriteria scri , Model model) throws Exception {
		logger.info("read????");
		boardService.hitUpdate(dto.getBoard_no());
		model.addAttribute("cont", boardService.read(dto.getBoard_no()));
		model.addAttribute("scri", scri);
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
		return "redirect:Board_list.do";

	}

	@RequestMapping("board_delete.do")
	public String delete(BoardDTO dto, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("delete");
		boardService.delete(dto.getBoard_no());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		return "redirect:Board_list.do";
	}

}
