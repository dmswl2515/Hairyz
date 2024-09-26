package com.study.springboot.dto;

import java.sql.Timestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Data
@Entity(name = "P2member")
public class PDto
{	
	@Id
    @Column(nullable = false, unique = true)
    private String id;

	@Column(name = "pw", nullable = false)
    private String password;

    private String name;
    private String nick;
    private String gender;
    private String phone;
    private String birth;
    private String email;
    private String address;
    private int rate;
    private Timestamp jdate;
    private String black;
}
