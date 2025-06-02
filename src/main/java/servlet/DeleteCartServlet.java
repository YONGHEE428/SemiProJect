package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.simple.JSONObject;

import data.dao.CartListDao;

@WebServlet("/cart/deleteItem")
public class DeleteCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 요청 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        // 응답 JSON 및 문자셋 설정
        response.setContentType("application/json; charset=UTF-8");

        // idx 파라미터 받기
        String idxStr = request.getParameter("idx");
        JSONObject json = new JSONObject();

        if (idxStr == null || idxStr.trim().isEmpty()) {
            json.put("status", "fail");
            json.put("message", "idx 파라미터가 없습니다.");
            response.getWriter().write(json.toString());

            return;
        }

        try {
            int idx = Integer.parseInt(idxStr);
            CartListDao dao = new CartListDao();
            boolean success = dao.deleteCartItem(idx);

            if (success) {
                json.put("status", "success");
                json.put("message", "상품이 삭제되었습니다.");
            } else {
                json.put("status", "fail");
                json.put("message", "삭제에 실패했습니다.");
            }
        } catch (NumberFormatException e) {
            json.put("status", "fail");
            json.put("message", "잘못된 idx 값입니다.");
        } catch (Exception e) {
            json.put("status", "error");
            json.put("message", "서버 오류가 발생했습니다.");
            e.printStackTrace();
        }

        response.getWriter().write(json.toString());

    }
}
