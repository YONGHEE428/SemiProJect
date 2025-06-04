package data.dao;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import data.dto.ReviewsDto;

@WebServlet("/submitReview.do")
public class ubmitReviewServlet extends HttpServlet {  
	 private static final long serialVersionUID = 1L;

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	            throws ServletException, IOException {

	        request.setCharacterEncoding("UTF-8");

	        HttpSession session = request.getSession(false);
	        if (session == null || session.getAttribute("member_id") == null) {
	            response.sendRedirect(request.getContextPath() + "/login/loginform.jsp");
	            return;
	        }

	        String memberId = (String) session.getAttribute("member_id");
	        String memberNum = (String) session.getAttribute("member_num");

	        String productNum = request.getParameter("product_num");
	        String rating = request.getParameter("rating");
	        String content = request.getParameter("content");
	        String height = request.getParameter("height");
	        String weight = request.getParameter("weight");
	        String usualSize = request.getParameter("usual_size");
	        String sizeFit = request.getParameter("size_fit");
	        String sizeComment = request.getParameter("size_comment");

	        ReviewsDto dto = new ReviewsDto();
	        dto.setProduct_num(productNum);
	        dto.setMember_num(memberNum);
	        dto.setMember_id(memberId);
	        dto.setRating(rating);
	        dto.setContent(content);
	        dto.setHeight(height);
	        dto.setWeight(weight);
	        dto.setUsual_size(usualSize);
	        dto.setSize_fit(sizeFit);
	        dto.setSize_comment(sizeComment);

	        ReviewsDao dao = new ReviewsDao();
	        dao.insertReview(dto);

	        response.sendRedirect(request.getContextPath() + "/productDetail.jsp?product_num=" + productNum + "#tab-review");
	    }
	}

    