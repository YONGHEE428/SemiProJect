package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import data.dao.CartListDao;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/cart/update")
public class UpdateCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartListDao CartListDao = new CartListDao(); // CartDao 경로에 따라 조정하세요

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        int idx = Integer.parseInt(request.getParameter("idx"));
        int cnt = Integer.parseInt(request.getParameter("cnt"));

        // 기존 void 메서드 사용
        CartListDao.updateCnt(idx, cnt);


        // 성공한 것으로 가정하고 단순 응답 (boolean 쓰고 싶으면 CartDao 수정 필요)
        PrintWriter out = response.getWriter();
        out.print("{\"success\": true}");
        out.flush();
    }
}