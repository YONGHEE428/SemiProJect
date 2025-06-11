package data.dao;

import  java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.dto.Q_ADto;

@WebServlet(name="InsertInquiry", urlPatterns={"/InsertInquiryServlet"})
public class InsertInquiryServlet extends HttpServlet {
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");

    try {
      // 1) 파라미터
      int productId   = Integer.parseInt(req.getParameter("product_id"));
      String title    = req.getParameter("title");
      String content  = req.getParameter("content");
      boolean isPrivate = Boolean.parseBoolean(req.getParameter("is_private"));
      String password = req.getParameter("password");

      // 2) 로그인한 사용자 아이디 세션에서 꺼내기
      String userId = (String) req.getSession().getAttribute("myid");
      if (userId == null) {
        // 로그인 안 된 상태라면 에러 처리
        resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요합니다.");
        return;
      }

      // 3) DTO 세팅
      Q_ADto dto = new Q_ADto();
      dto.setProductId(productId);
      dto.setUserId(userId);
      dto.setTitle(title);
      dto.setContent(content);
      dto.setPrivate(isPrivate);   // or dto.setIsPrivate(isPrivate);
      dto.setPassword(password);

      // 4) DAO 호출 — 여기서 addInquiry 호출
      Q_ADao dao = new Q_ADao();
      boolean success = dao.addInquiry(dto);

      // 5) 결과에 따라 리다이렉트 혹은 에러 페이지
      if (success) {
        resp.sendRedirect(req.getContextPath() + "/../shop/sangpumpage.jsp?product_id=" + productId);
      } else {
        req.setAttribute("errorMessage", "문의 등록에 실패했습니다.");
        req.getRequestDispatcher("/error.jsp").forward(req, resp);
      }

    } catch (Exception e) {
      e.printStackTrace();
      req.setAttribute("errorMessage", e.getMessage());
      req.getRequestDispatcher("/error.jsp").forward(req, resp);
    }
  }
}
