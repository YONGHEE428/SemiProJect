<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>고객 관리 페이지</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f4f4f4;
        text-align: center;
      }
      .button-group {
        margin-bottom: 20px;
        text-align: center;
      }
      .button-group button {
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border: none;
        border-radius: 5px;
        background-color: #007bff;
        color: white;
        margin-right: 10px;
      }
      .button-group button:hover {
        background-color: #0056b3;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background-color: white;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      }
      th,
      td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
      }
      th {
        background-color: #e2e2e2;
      }
    </style>
  </head>
  <body>
    <h1>회원 관리</h1>
    <div class="button-group">
      <button id="customerBtn">고객</button>
      <button id="adminBtn">관리자</button>
    </div>

    <table id="memberTable">
      <thead>
        <tr>
          <th>이름</th>
          <th>아이디</th>
          <th>이메일</th>
          <th>전화번호</th>
          <th>생년월일</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <!-- 회원 데이터가 여기에 로드됩니다 -->
      </tbody>
    </table>

    <script>
      $(document).ready(function () {
        function loadMembers(role) {
          // DAO를 통해 데이터를 가져올 JSP 또는 서블릿 경로 (예: getMembers.jsp)
          $.ajax({
            url: "getMembers.jsp?role=" + role, // 이 부분은 실제 DAO 연동 로직에 따라 변경해야 합니다.
            type: "GET",
            dataType: "json",
            success: function (data) {
              console.log(data);
              var tbody = $("#memberTable tbody");
              tbody.empty(); // 기존 데이터 비우기

              if (data && data.length > 0) {
                $.each(data, function (index, member) {
                  var row =
                    "<tr>" +
                    "<td>" +
                    member.name +
                    "</td>" +
                    "<td>" +
                    member.id +
                    "</td>" +
                    "<td>" +
                    member.email +
                    "</td>" +
                    "<td>" +
                    member.hp +
                    "</td>" +
                    "<td>" +
                    member.birth +
                    "</td>" +
                    "<td><button class='delete-btn' data-num='" +
                    member.num +
                    "'>삭제</button></td>" +
                    "</tr>";
                  tbody.append(row);
                });

                // 삭제 버튼 클릭 이벤트 바인딩
                $(".delete-btn").click(function () {
                  var memberNum = $(this).data("num");
                  if (confirm("정말로 이 회원을 삭제하시겠습니까?")) {
                    deleteMember(memberNum);
                  }
                });
              } else {
                tbody.append(
                  '<tr><td colspan="6">해당 역할의 회원이 없습니다.</td></tr>'
                );
              }
            },
            error: function (xhr, status, error) {
              console.error("Error fetching members:", status, error);
              $("#memberTable tbody")
                .empty()
                .append(
                  '<tr><td colspan="6">회원 데이터를 불러오는 데 실패했습니다.</td></tr>'
                );
            },
          });
        }

        function deleteMember(num) {
          $.ajax({
            url: "deleteMember.jsp?num=" + num, // 삭제 처리할 JSP 또는 서블릿 경로
            type: "GET", // 또는 'POST'
            success: function (response) {
              console.log(response);
              if (response.status === "success") {
                alert("회원이 성공적으로 삭제되었습니다.");
                // 현재 선택된 역할에 따라 목록 다시 로드
                var currentRole = $("#customerBtn").hasClass("active")
                  ? "user"
                  : "admin"; // 'active' 클래스 확인 로직 추가 필요
                loadMembers(currentRole);
              } else {
                alert("회원 삭제에 실패했습니다: " + response.message);
              }
            },
            error: function (xhr, status, error) {
              console.error("Error deleting member:", status, error);
              alert("회원 삭제 중 오류가 발생했습니다.");
            },
          });
        }

        // 초기 로드: 고객 목록
        loadMembers("user");

        // 버튼 클릭 이벤트
        $("#customerBtn").click(function () {
          loadMembers("user");
          $(this).addClass("active").siblings().removeClass("active"); // active 클래스 토글
        });

        $("#adminBtn").click(function () {
          loadMembers("admin");
          $(this).addClass("active").siblings().removeClass("active"); // active 클래스 토글
        });

        // 초기 활성 버튼 설정 (선택 사항)
        $("#customerBtn").addClass("active");
      });
    </script>
  </body>
</html>
