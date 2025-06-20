package data.dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.dao.Q_ADao;
import data.dto.Q_ADto;

@WebServlet(name = "InsertInquiry", urlPatterns = { "/InsertInquiryServlet" })
public class InsertInquiryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String title   = request.getParameter("title");
            String content = request.getParameter("content");

            // ★ 라디오 버튼 값을 Boolean으로 파싱 ★
            boolean isPrivate = Boolean.parseBoolean(request.getParameter("is_private"));
            System.out.println("[InsertInquiry] parsed isPrivate → " + isPrivate);

            String password = request.getParameter("password");
            if (isPrivate && (password == null || password.isEmpty())) {
                request.setAttribute("errorMessage", "비밀글 비밀번호를 입력해주세요.");
                request.getRequestDispatcher("/shop/error.jsp")
                       .forward(request, response);
                return;
            }

            // 로그인 체크
            String userId = (String) request.getSession().getAttribute("myid");
            if (userId == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요합니다.");
                return;
            }

            // DTO 세팅
            Q_ADto dto = new Q_ADto();
            dto.setProductId(productId);
            dto.setUserId(userId);
            dto.setTitle(title);
            dto.setContent(content);
            dto.setPrivate(isPrivate);
            dto.setPassword(password != null ? password : "");

            // DAO 호출
            Q_ADao dao = new Q_ADao();
            boolean success = dao.addInquiry(dto);
            System.out.println("[InsertInquiry] dao.addInquiry → " + success);

            if (success) {
                response.sendRedirect(request.getContextPath()
                        + "/index.jsp?main=shop/sangpumpage.jsp&product_id=" + productId + "#qna");
            } else {
                request.setAttribute("errorMessage", "문의 등록에 실패했습니다.");
                request.getRequestDispatcher("/shop/error.jsp")
                       .forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "서버 오류: " + e.getMessage());
            request.getRequestDispatcher("/shop/error.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
