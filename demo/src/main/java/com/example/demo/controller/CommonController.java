package com.example.demo.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dao.CommonService;
import com.example.demo.dao.CommunityService;
import com.google.gson.Gson;

@Controller
public class CommonController {

	@Autowired
	CommonService commonService;

	@RequestMapping("/home.do")
	public String home(Model model) throws Exception {
		
		return "/home";
	}

	@RequestMapping("/brand.do")
	public String brand(Model model) throws Exception {
		return "/brand";
	}

	@RequestMapping(value = "/main/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String newProductList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap = commonService.getNewProductList(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/main/bestlist.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bestProductList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap = commonService.getBestProductList(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/main/monthlylist.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String monthlyProductList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap = commonService.getMonthlyProductList(map);
		return new Gson().toJson(resultMap);
	}

}
