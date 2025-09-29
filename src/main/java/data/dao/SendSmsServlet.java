package data.dao;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@WebServlet("/SendSmsServlet")
public class SendSmsServlet extends HttpServlet {
    private static final String API_KEY = "";
    private static final String API_SECRET = "";
    private static final String FROM_PHONE = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String toPhone = request.getParameter("hp");
        
        HttpSession session = request.getSession(); // 기존 세션 가져오거나 새로 생성

        // 6자리 인증번호 생성
        String verificationCode = String.valueOf((int)(Math.random() * 900000) + 100000);

        // 문자 발송 준비
        Message coolsms = new Message(API_KEY, API_SECRET);
        HashMap<String, String> params = new HashMap<>();
        params.put("to", toPhone);
        params.put("from", FROM_PHONE);
        params.put("type", "SMS");
        params.put("text", "[SSY.COM] 인증번호는 " + verificationCode + " 입니다.");
        params.put("app_version", "SSY 1.0");

        response.setContentType("application/json;charset=UTF-8");

        try {
            coolsms.send(params);

            // 기존 세션에 인증번호 갱신
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("phoneForVerification", toPhone);

            // JSON 형식으로 인증번호 보내기 (테스트용)
            String json = "{\"verificationCode\":\"" + verificationCode + "\"}";
            response.getWriter().write(json);
        } catch (CoolsmsException e) {
            e.printStackTrace();
            String json = "{\"error\":\"문자 발송에 실패했습니다. 다시 시도해주세요.\"}";
            response.getWriter().write(json);
        }
    }
}
