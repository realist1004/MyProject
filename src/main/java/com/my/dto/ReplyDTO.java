package com.my.dto;

import java.util.Date;

import lombok.Data;
@Data
public class ReplyDTO {
	private int board_no;
	private int rno;
	private String content;
	private String writer;
	private Date regdate;
}
