package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.example.demo.dao.ReviewService;

@Controller
public class ReviewController {
	@Autowired
	ReviewService reviewService;
}
