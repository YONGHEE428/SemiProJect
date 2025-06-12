package data.dao;



import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import data.dao.Q_ADao;
import data.dto.Q_ADto;

@WebServlet("/CheckInquiryServlet")
public class CheckInquiryServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 1) 파라미터 검사
        String idStr = req.getParameter("inquiryId");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "문의 ID가 없습니다.");
            return;
        }
        int inquiryId = Integer.parseInt(idStr);
        String inputPw = req.getParameter("password");

        // 2) 비밀번호 검증
        Q_ADao dao = new Q_ADao();
        boolean ok = dao.checkPassword(inquiryId, inputPw);

        if (ok) {
            // 3) 상세 데이터 조회
            Q_ADto inquiry = dao.getInquiryById(inquiryId);

            // 4) request에 담아서 JSP로 포워드
            req.setAttribute("inquiry", inquiry);
            req.getRequestDispatcher("/shop/inquiryDetail.jsp")
               .forward(req, resp);
        } else {
            req.setAttribute("errorMessage", "잘못된 비밀번호입니다.");
            req.getRequestDispatcher("/shop/error.jsp")
               .forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }
}