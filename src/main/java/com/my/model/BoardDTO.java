package com.my.model;



import lombok.Data;

@Data
public class BoardDTO {
	
	private int board_no;
	private String board_writer;
	private String board_title;
	private String board_cont;
	private String board_pwd;
	private int board_hit;
	private String board_regdate;
	
	
}
