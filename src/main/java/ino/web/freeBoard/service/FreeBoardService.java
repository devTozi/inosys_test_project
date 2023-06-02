package ino.web.freeBoard.service;

import ino.web.freeBoard.dto.FreeBoardDto;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<FreeBoardDto> freeBoardList(Map<String, Object> searchInfo){
		return sqlSessionTemplate.selectList("freeBoardGetList", searchInfo);
	}

	public int freeBoardInsertPro(FreeBoardDto dto){
		return sqlSessionTemplate.insert("freeBoardInsertPro",dto);
	}

	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}

	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}

	public void freeBoardModify(FreeBoardDto dto){
		sqlSessionTemplate.update("freeBoardModify", dto);
	}

	public void FreeBoardDelete (int num) {
		sqlSessionTemplate.delete("freeBoardDelete", num);

	}
	
	public void FreeBoardDelete (int[] checkArr) {
		sqlSessionTemplate.delete("freeBoardDeletes", checkArr);
		
	}
	
	public int freeBoardTotalCount (Map<String, Object> selectInfo) {
		return sqlSessionTemplate.selectOne("freeBoardTotalCount", selectInfo);
	}

}
