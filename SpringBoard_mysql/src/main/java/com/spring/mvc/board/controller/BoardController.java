package com.spring.mvc.board.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.mvc.board.model.BoardVO;
import com.spring.mvc.board.service.IBoardService;
import com.spring.mvc.commons.PageCreator;
import com.spring.mvc.commons.PageVO;
import com.spring.mvc.commons.SearchVO;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Inject
	private IBoardService service;
	
//	//게시글 목록 불러오기 요청
//	@GetMapping("/list")
//	public String list(Model model) {
//		List<BoardVO> list = service.getArticleList();
//		
//		System.out.println("URL: /board/list GET -> result: " + list.size());
//		//list.forEach(article -> System.out.println(article));
//		//System.out.println("됬나?");
//		model.addAttribute("articles" , list);
//		
//		return "board/list";
//	}
//	

	//게시글 작성페이지 요청
	//어떻게 board/wrtie.jsp의 위치를 찾는거지??
	@GetMapping("/write")
	public void write() {
		System.out.println("URL: /board/write 글쓰기 Get요청!");
	}
	
	
	//게시글 DB등록 요청 --> write.jsp에서 name값이 전달 된다. post요청
	@PostMapping("/write")
	public String write(BoardVO article, RedirectAttributes ra) {
		
		System.out.println("/board/write -> Post");
		System.out.println("post article이 넘어오는가?" + article);
		service.insert(article);
		ra.addFlashAttribute("msg","regSuccess"); // 이 구문을 아래
		
		return "redirect:/board/list"; //여기로 보낸다.
	}
	
	
		//게시물 상세 조회 요청
		@GetMapping("/content/{boardNo}")
		public String content(@PathVariable Integer boardNo, Model model
				, @ModelAttribute("p") SearchVO paging) {
			System.out.println("URL: /board/content => GET");
			System.out.println("parameter(글 번호): " + boardNo);
			BoardVO vo = service.getArticle(boardNo);
			System.out.println("Result Data: " + vo);
			model.addAttribute("article", vo);
			return "board/content";
		}
		
		//게시물 삭제 처리 요청
		@PostMapping("/delete")
		public String remove(Integer boardNo, PageVO paging,
				RedirectAttributes ra) {

			System.out.println("URL: /board/delete => POST");
			System.out.println("parameter(글 번호): " + boardNo);
			service.delete(boardNo);
			ra.addFlashAttribute("msg", "delSuccess")
			  .addAttribute("page",paging.getPage()) //페이지에 대한 정보를 "page"에 셋팅
			  .addAttribute("countPerPage", paging.getCountPerPage()); //페이지가 보여질 갯수를 "countPerPage"에 셋팅	
			
			return "redirect:/board/list";
		}
		
		
		//게시물 수정 페이지 요청
		@GetMapping("/modify") //수정전 정보를 불러와야 수정을 할 수 있다.
		public String modify(Integer boardNo, Model model
				,@ModelAttribute("p") PageVO paging) { //수정 전 정보를 받아오기위해 Integer boardNo를 받았다.
			System.out.println("URL: /board/modify => GET");
			System.out.println("parameter(글 번호): " + boardNo);
			
			BoardVO vo = service.getArticle(boardNo); //boardNo를 DB에 주어서, 수정전 게시글 정보를 가져온다.
			System.out.println("Result Data: " + vo);
			model.addAttribute("article", vo);
			
			return "board/modify";
		}
		
		//게시물 수정 요청
		@PostMapping("/modify") 
		public String modify(BoardVO article, RedirectAttributes ra) { //modify.jsp에서 BoardVO가 넘어온다.
			System.out.println("URL: /board/modify => POST");
			System.out.println("parameter(게시글): " + article);
			service.update(article);
			
			ra.addFlashAttribute("msg", "modSuccess");
												//=={boardNo}
			return "redirect:/board/content/" + article.getBoardNo();
		}
		
	/*
	 * @GetMapping("/list") public String list(PageVO paging, Model model) {
	 * 
	 * List<BoardVO> list = service.getArticleListPaging(paging);
	 * 
	 * System.out.println("URL: /board/list GET -> result: " + list.size());
	 * System.out.println("parameter(페이지번호):" + paging.getPage() +"번" );
	 * //list.forEach(article -> System.out.println(article));
	 * //System.out.println("됬나?");
	 * 
	 * PageCreator pc = new PageCreator(); pc.setPaging(paging); //기본값은 1로 셋팅 되어있는거
	 * 알지? pc.setArticleTotalCount(service.countArticles()); System.out.println(pc);
	 * 
	 * model.addAttribute("articles" , list); model.addAttribute("pc",pc);
	 * 
	 * return "board/list";
	 * 
	 * 
	 * }
	 */
	
		//검색기능 추가
		@GetMapping("/list")
		public String list(SearchVO search, Model model) {
			
			String condition = search.getCondition();
			
			//List<BoardVO> list = service.getArticleListByTitle(search);
		
			//System.out.println("URL: /board/list GET -> result: " + list.size());
			System.out.println("parameter(페이지번호):" + search.getPage() +"번" ); //SeaerchVO는 PageVO를 상속받았기 때문에, PageVO의 getter 메서드를 호출 할 수 있다.(중요)
			System.out.println("검색조건: " + condition);
			System.out.println("검색어: " + search.getKeyword());
			//list.forEach(article -> System.out.println(article));
			//System.out.println("됬나?");
			
			PageCreator pc = new PageCreator();
			pc.setPaging(search); //기본값은 1로 셋팅 되어있는거 알지?
			//pc.setArticleTotalCount(service.countArticlesByTitle(search));
			//System.out.println(pc);
			
			List<BoardVO> list = service.getArticleList(search);
			pc.setArticleTotalCount(service.countArticles(search));
			
			
			model.addAttribute("articles" , list);
			model.addAttribute("pc",pc);
		
			return "board/list";
		
			
		}
		
		@GetMapping("/addMember")
		public String addMember() {
			
			return "users/login_modal";
		}
		
	
}
