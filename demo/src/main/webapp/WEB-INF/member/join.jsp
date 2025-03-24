<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <!-- 카카오 주소검색 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <title>회원가입</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: linear-gradient(135deg, #eee, #ddd);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .signup-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
        }

        .input-box {
            text-align: left;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            position: relative;
            flex-direction: column;
        }

        .input-box input,
        .input-box select {
            width: 100%;
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 8px;
            outline: none;
            font-size: 16px;
        }

        .input-box button {
            margin-top: 5px;
            padding: 10px 15px;
            border: none;
            background: #007bff;
            color: white;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            white-space: nowrap;
        }

        .input-box button:hover {
            background: #0056b3;
        }

        .message {
            font-size: 12px;
            margin-top: 5px;
        }

        .message.error {
            color: red;
        }

        .message.success {
            color: blue;
        }

        .address-container {
            display: flex;
            gap: 5px;
            width: 100%;
        }

        .address-container input {
            flex: 1;
        }
    </style>
</head>
<body>
    <div id="app" class="signup-container">
        <h2>회원가입</h2>
        <div class="input-box">
            <input type="text" v-model="user.userId" placeholder="아이디 (영문 또는 영문+숫자, 6자 이상)" maxlength="20" @input="fnIdCheck">
            <p v-if="idError" :class="{'message': true, 'error': idError !== '사용 가능한 아이디입니다.', 'success': idError === '사용 가능한 아이디입니다.'}">{{ idError }}</p>
        </div>
        <div class="input-box">
            <input type="email" v-model="user.email" placeholder="이메일 주소">
        </div>
        <div class="input-box">
            <input type="password" v-model="user.pwd" placeholder="비밀번호" maxlength="30" @input="fnPwdCheck">
            <p v-if="pwdError" :class="{'message': true, 'error': true}">{{ pwdError }}</p>
        </div>
        <div class="input-box">
            <input type="password" v-model="user.confirmPwd" placeholder="비밀번호 확인" maxlength="30" @input="fnPwdMatch">
            <p v-if="confirmPwdError" :class="{'message': true, 'error': true}">{{ confirmPwdError }}</p>
        </div>
        <div class="input-box">
            <input type="text" v-model="user.userName" placeholder="이름">
        </div>
        <div class="input-box">
            <select v-model="user.gender">
                <option value="" disabled>성별</option>
                <option value="남성">남성</option>
                <option value="여성">여성</option>
            </select>
        </div>
        <div class="input-box">
            <div class="address-container">
                <input type="text" v-model="user.address" placeholder="주소">
                <button @click="fnSearchAddr">주소검색</button>
            </div>
            <p v-if="addressError" class="message error">{{ addressError }}</p>
        </div>
        <div class="input-box">
            <input type="text" v-model="user.detailedAddress" placeholder="상세주소">
        </div>
        <div class="input-box">
            <input type="date" v-model="user.birth">
        </div>
        <div class="input-box">
            <input type="text" v-model="user.phoneNum" placeholder="휴대폰 번호">
            <button @click="fnSmsAuth">본인 인증</button>
        </div>
        <button @click="fnJoin">가입하기</button>
    </div>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    user: {
                        userId: "",
                        email: "",
                        pwd: "",
                        confirmPwd: "",
                        userName: "",
                        gender: "",
                        address: "",
                        detailedAddress: "",
                        birth: "",
                        phoneNum: ""
                    },
                    idError: "",  // 아이디 검증 오류 메시지
                    pwdError: "",  // 비밀번호 검증 오류 메시지
                    confirmPwdError: "", // 비밀번호 확인 오류 메시지
                    addressError: "",
                    selectedAddress: "",
                };
            },
            methods: {
                fnIdCheck() {
                    const userId = this.user.userId;
                    const idPattern = /^[a-zA-Z][a-zA-Z0-9]{5,19}$/; // 영문으로 시작, 영문 또는 숫자 포함, 6~20자

                    if (!userId) {
                        this.idError = "";
                        return;
                    }

                    if (!idPattern.test(userId)) {
                        this.idError = "사용 불가능 합니다.";
                        return;
                    }

                    $.ajax({
                        url: "/member/check.dox",
                        dataType: "json",
                        type: "POST",
                        data: { userId },
                        success: (data) => {
                            this.idError = data.result === "check" ? "중복된 아이디입니다." : "사용 가능한 아이디입니다.";
                        }
                    });
                },
                fnPwdCheck() {
                    const pwd = this.user.pwd;
                    const pwdPattern = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+={}\[\]:;"'<>,.?/\\|`~])[a-zA-Z0-9!@#$%^&*()_+={}\[\]:;"'<>,.?/\\|`~]{10,}$/;

                    if (!pwd) {
                        this.pwdError = "";
                        return;
                    }

                    if (!pwdPattern.test(pwd)) {
                        this.pwdError = "비밀번호는 영문, 숫자, 특수문자를 포함한 10자 이상이어야 합니다.";
                        return;
                    }

                    this.pwdError = "";
                },
                fnPwdMatch() {
                    const confirmPwd = this.user.confirmPwd;
                    if (confirmPwd !== this.user.pwd) {
                        this.confirmPwdError = "비밀번호가 일치하지 않습니다.";
                    } else {
                        this.confirmPwdError = "";
                    }
                },
                fnSearchAddr() {

                    const _this = this;
                    new daum.Postcode({
                        oncomplete: function(data) {
                            _this.user.address = data.address;
                            _this.addressError = ""; // 주소 오류 메시지 초기화
                        }
                    }).open();
                },
                fnSmsAuth() {
                    alert("본인 인증 코드가 전송되었습니다!");
                },
                fnJoin() {
                    if (this.idError && this.idError !== "사용 가능한 아이디입니다.") {
                        alert("아이디를 올바르게 입력해주세요.");
                        return;
                    }

                    if (this.pwdError) {
                        alert("비밀번호를 올바르게 입력해주세요.");
                        return;
                    }

                    if (this.confirmPwdError) {
                        alert("비밀번호 확인을 올바르게 입력해주세요.");
                        return;
                    }

                    $.post('/signup', this.user, (response) => {
                        alert(response.message);
                    });
                }
            }
        });
        app.mount('#app');
    </script>

</body>

</html>