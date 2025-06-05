package data.dao;

import java.io.*;
import java.nio.file.Paths;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import data.dto.ReviewDTO;

@WebServlet("/SubmitReviewServlet.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 업로드 디렉토리 설정
        String savePath = getServletContext().getRealPath("/upload/review");
        File uploadDir = new File(savePath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // 파일 처리
        Part filePart = request.getPart("photo");
        String fileName = "";
        String filePath = "";

        if (filePart != null && filePart.getSize() > 0) {
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (!fileName.contains("..") && !fileName.contains("/") && !fileName.contains("\\")) {
                filePath = "upload/review/" + fileName;
                filePart.write(savePath + File.separator + fileName);
            }
        }

        // ★ 폼에서 전달된 파라미터 값 추출
        String memberName = request.getParameter("member_name");
        String purchaseOption = request.getParameter("purchase_option");
        String content = request.getParameter("content");
        String satisfactionText = request.getParameter("satisfaction_text");
        String sizeFit = request.getParameter("size_fit");
        String sizeComment = request.getParameter("size_comment");
        String height = request.getParameter("height");
        String weight = request.getParameter("weight");
        String usualSize = request.getParameter("usual_size");

        // ★ DTO 생성 및 저장 (DAO 사용)
        ReviewDTO dto = new ReviewDTO();
        dto.setMemberName(memberName);
        dto.setPurchaseOption(purchaseOption);
        dto.setContent(content);
        dto.setSatisfactionText(satisfactionText);
        dto.setSizeFit(sizeFit);
        dto.setSizeComment(sizeComment);
        dto.setHeight(height);
        dto.setWeight(weight);
        dto.setUsualSize(usualSize);
        dto.setPhotoPath(filePath);

        ReviewDAO dao = new ReviewDAO();
        dao.insertReview(dto);  // ★ 반드시 insertReview 메서드가 구현되어 있어야 함

        // 완료 후 페이지 이동 또는 메시지 출력
        response.sendRedirect(request.getContextPath() + "/shop/reviewlist.jsp");
    }
}