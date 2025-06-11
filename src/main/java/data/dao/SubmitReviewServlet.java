package data.dao;

import java.io.*;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import data.dto.ReviewDTO;

@WebServlet("/SubmitReviewServlet.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024) // 5MB
public class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        ReviewDTO dto = new ReviewDTO();
        dto.setMemberName(request.getParameter("member_name"));
        dto.setPurchaseOption(request.getParameter("purchase_option"));
        dto.setSatisfactionText(request.getParameter("satisfaction_text"));
        dto.setContent(request.getParameter("content"));
        dto.setSizeFit(request.getParameter("size_fit"));
        dto.setSizeComment(request.getParameter("size_comment"));
        dto.setHeight(parseIntOrZero(request.getParameter("height")));
        dto.setWeight(parseIntOrZero(request.getParameter("weight")));
        dto.setUsualSize(request.getParameter("usual_size"));

        // product_id도 받아야 함 (파라미터든 hidden input이든)
        int productId = Integer.parseInt(request.getParameter("product_id"));
        dto.setProductId(productId);

        // 파일 업로드 처리
        Part filePart = request.getPart("photo");
        String uploadPath = getServletContext().getRealPath("/review_photos");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String photoPath = null;
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID() + "_" + filePart.getSubmittedFileName();
            filePart.write(uploadPath + File.separator + fileName);
            photoPath = "review_photos/" + fileName;
        }
        dto.setPhotoPath(photoPath);

        ReviewDAO dao = new ReviewDAO();
        dao.insertReview(dto);

        // 저장 후 리디렉션
        response.sendRedirect("../shop/sangpumpage.jsp?product_id=" + productId + "#reviews");
    }

    private int parseIntOrZero(String val) {
        try {
            return Integer.parseInt(val);
        } catch (Exception e) {
            return 0;
        }
    }
}