package com.spring.mvc.board.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mvc.board.model.BoardVO;
import com.spring.mvc.board.repository.IBoardMapper;
import com.spring.mvc.commons.PageVO;
import com.spring.mvc.commons.SearchVO;

@Service
public class BoardService implements IBoardService {

	@Autowired
	private IBoardMapper mapper;
	
	@Override
	public void insert(BoardVO article) {
		mapper.insert(article);

	}

	@Override
	public BoardVO getArticle(Integer boardNo) {
		mapper.updateViewCnt(boardNo);
		return mapper.getArticle(boardNo);
	}

	@Override
	public void update(BoardVO article) {
		mapper.update(article);

	}

	@Override
	public void delete(Integer boardNo) {
		mapper.delete(boardNo);

	}

	@Override
	public List<BoardVO> getArticleList(SearchVO search) {
		List<BoardVO> list = mapper.getArticleList(search);
		
		//1일 이내 신규글 new 마크 처리 로직
		for(BoardVO article : list) {
			//현재시간 읽어오기
			long now = System.currentTimeMillis(); //밀리초로 현재시간 읽기
			Date regDate = article.getRegDate();
			//각 게시물들의 작성 시간 밀리초로 읽어오기
			long regTime = regDate.getTime(); // getTime(): Returns the number of milliseconds since January 1, 1970, 00:00:00 GMT represented by this Date object.
			//혹은 long regTime = article.getRegDate().getTime();
			if(now - regTime < 60 * 60 * 24 * 3 * 1000) {
				article.setNewMark(true);
			}
		}
		
		return list;
	}

	@Override
	public Integer countArticles(SearchVO search) {
		
		return mapper.countArticles(search);
	}

	
	
}
