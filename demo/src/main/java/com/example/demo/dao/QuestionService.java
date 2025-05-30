package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.NoticeMapper;
import com.example.demo.mapper.QuestionMapper;
import com.example.demo.model.Notice;
import com.example.demo.model.Question;
import com.example.demo.model.QuestionReply;

@Service
public class QuestionService {
	
	@Autowired
	QuestionMapper questionMapper;
	
	@Autowired
	NoticeMapper noticeMapper;

	public HashMap<String, Object> questionQna(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			if (!map.containsKey("category") || map.get("category") == null) {
	            map.put("category", "all"); 
	        } 
			
			List<Question> inquiryList = questionMapper.qnaInquire(map);
			resultMap.put("inquiryList", inquiryList);
			
			int inquiryCount = questionMapper.selectQna(map);
			resultMap.put("inquiryCount", inquiryCount);
			
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> questionAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			String contents = (String) map.get("qsContents");
	        String qsCategory = "기타";  // 기본값을 기타로 설정

	        if (contents != null) {
	            if (contents.contains("환불")) {
	                qsCategory = "환불";
	            } else if (contents.contains("배송")) {
	                qsCategory = "배송";
	            } else if (contents.contains("결제")) {
	                qsCategory = "결제";
	            } else if (contents.contains("회원")) {
	                qsCategory = "회원";
	            } else if (contents.contains("제품") || contents.contains("상품")) {
	                qsCategory = "제품";
	            }
	        }
	        
	        map.put("qsCategory", qsCategory);
		    
			questionMapper.qnaInsert(map);
			System.out.println("key =>" + map.get("qsNo"));
			resultMap.put("qsNo", map.get("qsNo"));
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> questionView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			if(map.get("option").equals("SELECT")) {
				questionMapper.updateCnt(map);
			}
			Question info = questionMapper.qnaSelect(map);
			QuestionReply reply = questionMapper.qnaReply(map);
			resultMap.put("reply", reply);
			resultMap.put("info", info);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> questionEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			questionMapper.qnaUpdate(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> questionRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			questionMapper.qnaDelete(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> questionUpdateStatus(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<>();
	    try {
	        System.out.println("questionUpdateStatus 실행, map: " + map);

	        int updatedRows = questionMapper.qnaStatusUpdate(map);
	        System.out.println("변경된 행 개수: " + updatedRows);

	        if (updatedRows > 0) {
	            resultMap.put("result", "success");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "업데이트된 행이 없습니다.");
	        }
	    } catch (Exception e) {
	        System.out.println("❌ 오류 발생: " + e.getMessage());
	        resultMap.put("result", "fail");
	    }
	    
	    return resultMap;
	}

	public HashMap<String, Object> questionNotice(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Notice> noticeList = noticeMapper.qnaNotice(map);
			resultMap.put("noticeList", noticeList);
			
			int noticeCount = noticeMapper.selectNotice(map);
			resultMap.put("noticeCount", noticeCount);
			
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> noticeView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			if(map.get("option").equals("SELECT")) {
				noticeMapper.updateNoticeCnt(map);
			}
			Notice info = noticeMapper.noticeSelect(map);
			resultMap.put("info", info);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> noticeEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			noticeMapper.noticeUpdate(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> noticeRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			noticeMapper.noticeDelete(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> noticeAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			noticeMapper.noticeInsert(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> questionReplySave(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			questionMapper.qnaSaveReply(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> noticeViewMode(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Notice notice = noticeMapper.noticeViewMode(map);
			resultMap.put("notice", notice);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> noticePrev(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int noticeNo = Integer.parseInt(map.get("noticeNo").toString());
			map.put("noticeNo", noticeNo);
			
			Notice notice = noticeMapper.noticePrev(map);
			if (notice != null) {
				HashMap<String, Object> tempMap = new HashMap<>();
				tempMap.put("noticeNo", notice.getNoticeNo());

				// 이전글의 이전글 = prevNotice
				Notice prev = noticeMapper.noticePrev(tempMap);
				// 이전글의 다음글 = nextNotice
				Notice next = noticeMapper.noticeNext(tempMap);

				// 현재 Notice에 추가 정보 삽입
				notice.setPrevNoticeNo(prev != null ? prev.getNoticeNo() : null);
				notice.setPrevTitle(prev != null ? prev.getNoticeTitle() : null);
				notice.setNextNoticeNo(next != null ? next.getNoticeNo() : null);
				notice.setNextTitle(next != null ? next.getNoticeTitle() : null);
			}
			resultMap.put("notice", notice);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	public HashMap<String, Object> noticeNext(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int noticeNo = Integer.parseInt(map.get("noticeNo").toString());
			map.put("noticeNo", noticeNo);
			
			Notice notice = noticeMapper.noticeNext(map);
			if (notice != null) {
				HashMap<String, Object> tempMap = new HashMap<>();
				tempMap.put("noticeNo", notice.getNoticeNo());

				// 다음글의 이전글
				Notice prev = noticeMapper.noticePrev(tempMap);
				// 다음글의 다음글
				Notice next = noticeMapper.noticeNext(tempMap);

				// 현재 Notice에 이전/다음 정보 삽입
				notice.setPrevNoticeNo(prev != null ? prev.getNoticeNo() : null);
				notice.setPrevTitle(prev != null ? prev.getNoticeTitle() : null);
				notice.setNextNoticeNo(next != null ? next.getNoticeNo() : null);
				notice.setNextTitle(next != null ? next.getNoticeTitle() : null);
			}
			resultMap.put("notice", notice);
			resultMap.put("result", "success");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

}
