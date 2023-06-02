package ino.web.freeBoard.controller;

import ino.web.freeBoard.common.util.Pagination;
import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;
	
	private static String searchUrl = "/search.ino";

	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request,
							 String searchType,
							 String searchDetail,
							 String beginDate,
							 String endDate,
							 Pagination pagination){
		// 검색값 세팅
		Map<String, Object> selectInfo = new HashMap<>();
		selectInfo.put("searchType", searchType);
		selectInfo.put("searchDetail", searchDetail);
		selectInfo.put("beginDate", beginDate);
		selectInfo.put("endDate", endDate);
		selectInfo.put("pagination", pagination);
		
		// 페이지네이션 세팅
		int totalCount = freeBoardService.freeBoardTotalCount(selectInfo);
		pagination.setEndPage(totalCount);
		pagination.setUrl(request.getContextPath() + searchUrl + 
						  "?searchType=" + searchType + 
						  "&searchDetail=" + searchDetail +
						  "&beginDate=" + beginDate +
						  "&endDate=" + endDate);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("freeBoardMain");
		mav.addObject("freeBoardList", freeBoardService.freeBoardList(selectInfo));
		mav.addObject("pagination", pagination);
		mav.addObject("searchType", searchType);
		mav.addObject("searchDetail", searchDetail);
		mav.addObject("beginDate", beginDate);
		mav.addObject("endDate", endDate);
		
		return mav;
	}
	// List<FreeBoardDto> list = freeBoardService.freeBoardList(); 새로만들지않는다. 수정할것.
	// 기간검색할때 값을 더해주거나 붙여주지않는다.
	@RequestMapping("/search.ino")
	@ResponseBody
	public Map<String, Object> search(HttpServletRequest request,
									 String searchType,
									 String searchDetail,
									 String beginDate,
									 String endDate,
									 Pagination pagination){ 
		// 검색값 세팅
		Map<String, Object> selectInfo = new HashMap<>();
		selectInfo.put("searchType", searchType);
		selectInfo.put("searchDetail", searchDetail);
		selectInfo.put("beginDate", beginDate);
		selectInfo.put("endDate", endDate);
		// 페이지네이션 세팅
		int totalCount = freeBoardService.freeBoardTotalCount(selectInfo);
		pagination.setEndPage(totalCount);
		pagination.setUrl(request.getContextPath() + searchUrl + 
						  "?searchType=" + searchType + 
						  "&searchDetail=" + searchDetail +
						  "&beginDate=" + beginDate +
						  "&endDate=" + endDate);
		selectInfo.put("pagination", pagination);
		selectInfo.put("list", freeBoardService.freeBoardList(selectInfo));
		
		return selectInfo;
	}
	
	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(){
		return "freeBoardInsert";
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardInsertPro.ino")
	public Map<String, Object> freeBoardInsertPro(@RequestBody FreeBoardDto dto,
	                                 HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
	    try {
	    	freeBoardService.freeBoardInsertPro(dto);
	    	result.put("dto", dto);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", e.getMessage());
		}
	    return result;
	}
 
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request,
										@RequestParam("num") int num){
		return new ModelAndView("freeBoardDetail", "freeBoardDto", freeBoardService.getDetailByNum(num));
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardModify.ino")
	public Map<String, Object> freeBoardModify(@RequestBody FreeBoardDto dto,
			                      HttpServletRequest request){
		Map<String, Object> result = new HashMap<>();
		try {
	    	freeBoardService.freeBoardModify(dto);
	    	result.put("dto", dto);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", e.getMessage());
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardDelete.ino")
	public Map<String, Object> FreeBoardDelete(@RequestBody FreeBoardDto dto){
		Map<String, Object> result = new HashMap<>();
		try {
	    	freeBoardService.FreeBoardDelete(dto.getNum());
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", e.getMessage());
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardDeletes.ino")
	public Map<String, Object> FreeBoardDelete(@RequestBody int[] checkArr){
		Map<String, Object> result = new HashMap<>();
		try {
			freeBoardService.FreeBoardDelete(checkArr);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("err", e.getMessage());
		}
		return result;
	}
}