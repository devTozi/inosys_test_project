package ino.web.freeBoard.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nexacro17.xapi.data.PlatformData;
import com.nexacro17.xapi.data.VariableList;
import com.nexacro17.xapi.tx.HttpPlatformResponse;
import com.nexacro17.xapi.tx.PlatformType;

import ino.web.freeBoard.common.util.Pagination;
import ino.web.freeBoard.service.FreeBoardService;

@Controller
public class NexaController {
	
	@Autowired
	private FreeBoardService freeBoardService;
	
	private static String searchUrl = "/search.ino";
	
	@RequestMapping(value="/nexa.ino", produces="application/xml; charset=UTF8", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public void getServerInfo(HttpServletResponse response,
							  HttpServletRequest request,
							  Pagination pagination) throws Exception {
		// 검색값 세팅
		Map<String, Object> selectInfo = new HashMap<>();
		// 페이지네이션 세팅
		int totalCount = freeBoardService.freeBoardTotalCount(selectInfo);
		pagination.setEndPage(totalCount);
		pagination.setUrl(request.getContextPath() + searchUrl + 
				"?searchType=" + "searchType" + 
				"&searchDetail=" + "searchDetail" +
				"&beginDate=" + "beginDate" +
				"&endDate=" + "endDate");
		selectInfo.put("pagination", pagination);
		selectInfo.put("list", freeBoardService.freeBoardList(selectInfo));

		// Response 생성
		PlatformData out_pData = new PlatformData();

		VariableList out_varList = out_pData.getVariableList();
		out_varList.add("ErrorCode", 0);
		out_varList.add("ErrorMsg", "성공");
		out_varList.add("pagination", pagination);
		out_varList.add("data", freeBoardService.freeBoardList(selectInfo));

		HttpPlatformResponse pRes = new HttpPlatformResponse(response, PlatformType.CONTENT_TYPE_XML, "UTF-8");
		pRes.setData(out_pData);

		pRes.sendData();
	}
	
	
}
