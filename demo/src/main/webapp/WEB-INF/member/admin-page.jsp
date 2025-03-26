<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="/css/member-css/admin-page.css">
        <title>상품 관리</title>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />
        <div id="app">
            <!-- 관리자 페이지 전체 구조 -->
            <div class="admin-container">
                <!-- 사이드바 -->
                <div class="sidebar">
                    <h2>관리자 메뉴</h2>
                    <ul>
                        <li><a href="#" @click="showSection('dashboard')">대시보드</a></li>
                        <li><a href="#" @click="showSection('product-management')">상품 관리</a></li>
                        <li><a href="#" @click="showSection('order-management')">주문 관리</a></li>
                        <li><a href="#" @click="showSection('member-management')">회원 관리</a></li>
                    </ul>
                </div>

                <!-- 페이지 콘텐츠 영역 -->
                <div class="content">
                    <!-- 대시보드 -->
                    <div v-if="currentSection === 'dashboard'" class="section">
                        <h3>대시보드</h3>
                        <div class="card">
                            <h3>총 주문 수</h3>
                            <p>1,250</p>
                        </div>
                        <div class="card">
                            <h3>총 상품 수</h3>
                            <p>500</p>
                        </div>
                    </div>

                    <!-- 상품 관리 -->
                    <div v-if="currentSection === 'product-management'" class="section">
                        <h3>상품 관리</h3>

                        <!-- 상품 추가/수정 버튼 -->
                        <button @click="showForm('add')" @click="showForm(formType)">상품 추가</button>
                        <button @click="showForm('edit')" @click="showForm(formType)">상품 수정</button>

                        <!-- 상품 추가/수정 폼 -->
                        <div class="product-form">
                            <h4 v-if="formType === 'add'">상품 추가</h4>
                            <h4 v-if="formType === 'edit'">상품 수정</h4>
                            <form @submit.prevent="submitForm" v-if="showProductForm" :key="showProductForm">
                                <label for="name">상품 이름</label>
                                <input type="text" id="name" v-model="name" required>

                                <label for="price">가격</label>
                                <input type="number" id="price" v-model="price" required>

                                <label for="quantity">상품 개수</label>
                                <input type="number" id="quantity" v-model="quantity" required>

                                <label for="category">카테고리</label>
                                <input type="text" id="category" v-model="category" required>

                                <label for="info">정보</label>
                                <textarea id="info" v-model="info" required></textarea>

                                <label for="details">알레르기 정보</label>
                                <textarea id="details" v-model="allergens" required></textarea>

                                <label for="thumbnail">썸네일 사진</label>
                                <input type="file" id="thumbnail" @change="handleFileChange('thumbnail')" required>

                                <label for="additionalPhotos">추가 사진</label>
                                <input type="file" id="additionalPhotos" @change="handleFileChange('additionalPhotos')"
                                    multiple>

                                <button type="submit">저장</button>
                                <button type="button" @click="cancelForm">취소</button>
                            </form>
                            <div v-if="showTable">
                                <table>
                                    <tr>
                                        <th>상품 번호</th>
                                        <th>상품 이름</th>
                                        <th>가격</th>
                                        <th>재고</th>
                                        <th>등록일</th>
                                    </tr>
                                    <tr v-for="item in list">
                                        <td>{{item.itemNo}}</td>
                                        <td><a href="javascript:;" @click="fnEdit(item.itemNo)">{{item.itemName}}</a>
                                        </td>
                                        <td>{{item.price}}</td>
                                        <td>{{item.itemCount}}</td>
                                        <td>{{item.rDate}}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- 주문 관리 -->
                    <div v-if="currentSection === 'order-management'" class="section">
                        <h3>주문 관리</h3>
                        <p>주문 관리 관련 콘텐츠</p>
                    </div>

                    <!-- 회원 관리 -->
                    <div v-if="currentSection === 'member-management'" class="section">
                        <h3>회원 관리</h3>
                        <p>회원 관리 관련 콘텐츠</p>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/common/footer.jsp" />
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    currentSection: 'dashboard',
                    showProductForm: false,
                    showTable: false,
                    formType: '',
                    name: '',
                    price: '',
                    quantity: '',
                    category: '',
                    info: '',
                    allergens: '',
                    thumbnail: null,
                    additionalPhotos: [],
                    list: [],
                    item: {},
                    itemNo: ""
                };
            },
            methods: {
                showSection(section) {
                    this.currentSection = section;
                },
                showForm(type) {
                    var self = this;
                    this.formType = type;
                    if (type == 'add') {
                        this.showProductForm = true;
                        this.showTable = false;
                        self.name = "";
                        self.price = "";
                        self.quantity = "";
                        self.category = "";
                        self.info = "";
                        self.allergens = "";
                    } else {
                        this.showProductForm = false;
                        this.showTable = true;
                        self.itemList();
                    }
                },
                handleFileChange(field) {
                    const fileInput = document.getElementById(field);
                    const files = fileInput.files;
                    if (field === 'thumbnail') {
                        this.thumbnail = files[0];
                    } else if (field === 'additionalPhotos') {
                        this.additionalPhotos = Array.from(files);
                    }
                },
                submitForm() {
                    var self = this;
                    var nparmap = {
                        name: this.name,
                        price: this.price,
                        quantity: this.quantity,
                        category: this.category,
                        info: this.info,
                        allergens: this.allergens,
                    };
                    $.ajax({
                        url: "/product/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            // 파일이 존재하면 업로드 처리

                            if (self.thumbnail || self.additionalPhotos.length > 0) {
                                var form = new FormData();
                                if (self.thumbnail) {
                                    form.append("file1", self.thumbnail); // 썸네일 파일 추가
                                }
                                if (self.additionalPhotos.length > 0) {
                                    self.additionalPhotos.forEach((photo, index) => {
                                        form.append("file1", photo); // 추가 사진 파일 추가
                                    });
                                }
                                form.append("itemNo", data.itemNo); // 상품 아이디
                                self.upload(form); // 파일 업로드 함수 호출
                            }
                        }
                    });
                    this.showProductForm = false;
                },
                upload(form) {
                    var self = this;
                    $.ajax({
                        url: "/product/fileUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (response) {
                            alert("저장되었습니다!");
                            this.showProductForm = false;
                        }
                    });
                },
                cancelForm() {
                    this.showProductForm = false;
                    console.log(this.formType);
                    if (this.formType == 'edit') {
                        this.showTable = true;
                    }
                },
                fnEdit(itemNo) {
                    var self = this;

                    var nparmap = {
                        itemNo: itemNo
                    };
                    $.ajax({
                        url: "/product/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            self.item = data.info;
                            console.log(self.item);

                            self.name = self.item.itemName;
                            self.price = self.item.price;
                            self.quantity = self.item.itemCount;
                            self.category = self.item.category;
                            self.info = self.item.itemInfo;
                            self.allergens = self.item.allergens;

                            self.showProductForm = true;
                            self.showTable = false;

                        }
                    });
                },
                itemList() {
                    var self = this;
                    var nparmap = {
                    };
                    $.ajax({
                        url: "/product/list2.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            self.list = data.list
                        }
                    });
                },
            },
            mounted() {
                var self = this;
            }
        });
        app.mount('#app');
    </script>