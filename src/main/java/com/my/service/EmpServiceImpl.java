package com.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.model.EmpDAO;
import com.my.model.EmpDTO;

@Service
public class EmpServiceImpl implements EmpService {
	@Autowired
	private EmpDAO empDAO;

	@Override
	public List<EmpDTO> listAll() throws Exception {
		
		return empDAO.listAll();
	}
	
}
