package com.my.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface EmpDAO {
	public List<EmpDTO> listAll() throws Exception;

}
