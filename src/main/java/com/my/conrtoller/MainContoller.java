package com.my.conrtoller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.my.service.EmpService;

@Controller
public class MainContoller {

	@Autowired
	private EmpService empService;

	@RequestMapping("/emp_list.do")
	public String list(Model model) throws Exception {
		model.addAttribute("List", empService.listAll());
		return "emp_list" ;
	}

	

	  
	 
}
