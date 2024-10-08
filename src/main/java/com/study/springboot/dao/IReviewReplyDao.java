package com.study.springboot.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IReviewReplyDao
{
	public int insertReply(int pr_reviewId, String rrp_id, String rrp_content);
}
