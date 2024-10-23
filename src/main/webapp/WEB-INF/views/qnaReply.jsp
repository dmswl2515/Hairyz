<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 답변</title>
<!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .popup-header {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 10px;
            font-weight: bold;
        }
        .popup-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ced4da;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        .popup-content {
            margin-bottom: 15px;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
        }
        .form-control {
            resize: none;
        }
    </style>
</head>
<body>

    <div class="popup-container">
        <div class="popup-header">QnA 답변하기</div>

        <!-- 파라미터로 전달된 값 출력 -->
        <div class="popup-content">
            <p><strong>번호:</strong>&nbsp;${number}</p>
            <p><strong>작성일:</strong>&nbsp;${qnaDate}</p>
            <p><strong>작성자:</strong>&nbsp;${qnaName}</p>
        </div>

        <div class="popup-content">
            <label><strong>QnA 내용</strong></label>
            <textarea class="form-control" rows="5" readonly>${qnaContent}</textarea>
        </div>

        <div class="popup-content">
            <label><strong>답변 내용</strong></label>
            <textarea id="qnaText" class="form-control" rows="3" placeholder="답변하실 내용을 입력하세요."></textarea>
        </div>

        <div class="btn-group">
            <button type="button" class="btn btn-secondary" onclick="hideQnA()">숨기기</button>&nbsp;&nbsp;
            <button type="button" class="btn btn-primary" onclick="submitQnA()" >답변 등록</button>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
     <script type="text/javascript">
        function hideQnA() {
            const qnaNo = '${qnaNo}';
            var basePath = '${pageContext.request.contextPath}'; 
            $.ajax({
                url: basePath + '/hideQna.do',
                type: 'POST',
                data: {
                    qnaNo: qnaNo
                },
                success: function(response) {
                    alert('QnA가 숨겨졌습니다.');
                    opener.location.reload();
                    window.close();  // 팝업창 닫기
                },
                error: function(xhr, status, error) {
                    alert('QnA 숨기기 실패: ' + error);
                }
            });
        }

        function submitQnA() {
            const qnaNo = '${qnaNo}';
            const qnaText = document.getElementById('qnaText').value;
            var basePath = '${pageContext.request.contextPath}'; 
            
            $.ajax({
                url: basePath + '/submitQnaReply.do',
                type: 'POST',
                data: {
                	qnaNo: qnaNo,
                	qnaText: qnaText
                },
                success: function(response) {
                    alert('답변이 등록되었습니다.');
                    opener.location.reload();
                    window.close();  // 팝업창 닫기
                },
                error: function(xhr, status, error) {
                    alert('답변 등록 실패: ' + error);
                }
            });
        }
    </script>
</body>
</html>