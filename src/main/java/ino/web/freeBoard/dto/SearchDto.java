package ino.web.freeBoard.dto;

import org.apache.ibatis.type.Alias;

@Alias("searchDto")
public class SearchDto {
	
	private String searchType;
	private String searchDetail;
	private String begin;
	private String end;
	
	public SearchDto() {}
	
	public String getBegin() {
		return begin;
	}

	public void setBegin(String begin) {
		this.begin = begin;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchDetail() {
		return searchDetail;
	}
	public void setSearchDetail(String searchDetail) {
		this.searchDetail = searchDetail;
	}
	@Override
	public String toString() {
		return "SearchDto [searchType=" + searchType + ", searchDetail=" + searchDetail + ", begin=" + begin + ", end="
				+ end + "]";
	}
	
}
