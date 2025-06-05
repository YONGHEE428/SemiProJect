package data.dao;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import data.dto.Q_ADto;

@WebServlet("/InsertInquiryServlet")
	public class InsertInquiryServlet extends HttpServlet {
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        request.setCharacterEncoding("UTF-8");

	        HttpSession session = request.getSession();
	        String userId = (String) session.getAttribute("userId");

	        if (userId == null) {
	            response.sendRedirect("login.jsp");
	            return;
	        }

	        Q_ADto dto = new  Q_ADto();
	        dto.setProductId(Integer.parseInt(request.getParameter("product_id")));
	        dto.setUserId(userId);
	        dto.setTitle(request.getParameter("title"));
	        dto.setContent(request.getParameter("content"));
	        dto.setPrivate(Boolean.parseBoolean(request.getParameter("is_private")));
	        dto.setPassword(request.getParameter("password"));

	        Q_ADao dao = new   Q_ADao();
	        int result = dao.insertInquiry(dto);

	        if (result > 0) {
	            response.sendRedirect("product_detail.jsp?product_id=" + dto.getProductId());
	        } else {
	            response.getWriter().println("<script>alert('등록 실패');history.back();</script>");
	        }
	    }	
	
}
