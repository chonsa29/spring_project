<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/vue@3.5.13/dist/vue.global.min.js"></script>

        <link rel="stylesheet" href="/css/product-css/product-list.css">
        <script src="/js/pageChange.js"></script>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />

        <div id="app">
            <div id="rootname">
                <a href="/home.do">HOME</a> > <a href="/product.do">PRODUCT</a> > {{ selectedCategory }}
            </div>
            <div id="name">
                <div class="custom-dropdown">
                    <button class="dropdown-btn" @click="toggleDropdown">{{ selectedCategory }}</button>
                    <ul class="dropdown-menu" v-show="isDropdownOpen">
                        <li v-for="category in allCategory" @click="selectOption(category.category)">
                            {{ category.category }}
                        </li>
                    </ul>
                </div>
            </div>
            <div>
                <input type="text" placeholder="검색하기" id="product-search" v-model="keyword"
                    @keyup.enter="fnProductList">
            </div>
            <div id="product-count">
                <span id="selectproduct">전체개수</span>
                <span>{{productcount}}개</span>
            </div>
            <div id="product-menu">
                <div id="sort-menu" class="sort-custom-dropdown">
                    <button class="sort-dropdown-btn" @click="toggleDropdown">{{ sortOption }}</button>
                    <ul class="sort-dropdown-menu" v-show="isSortDropdownOpen">
                        <li @click="changeSortOption('newest')">최신순</li>
                        <li @click="changeSortOption('popularity')">인기순</li>
                        <li @click="changeSortOption('priceLowToHigh')">낮은가격순</li>
                        <li @click="changeSortOption('priceHighToLow')">높은가격순</li>
                    </ul>
                </div>
            </div>

            <div class="product-list">
                <div class="product" v-for="item in list">
                    <div class="product-image" @click="fnInfo(item.itemNo)">
                        <img class="product-image" :src="item.filePath" alt="item.itemName" />
                    </div>
                    <div @click="fnInfo(item.itemNo)">
                        <p class="product-info">{{item.itemInfo}}</p>
                        <h4 class="product-name">{{item.itemName}}</h4>
                        <p class="product-discount-style">{{formatPrice(item.price * 3) }}</p>
                        <p class="product-discount">30%</p>
                        <p class="product-price">{{formatPrice(item.price)}}원</p>
                    </div>
                    <div id="reaction-menu">
                        <!-- 좋아요 -->
                        <button class="product-like" :class="{ active: likedItems.has(item.itemNo) }"
                            @click="fnLike(item.itemNo)">❤</button>
                        <div v-if="showLikePopup" class="like-popup-overlay">
                            <div class="like-popup">좋아요 항목에 추가되었습니다</div>
                        </div>
                        <div v-if="!showLikePopup" class="like-popup-overlay">
                            <div class="like-popup">좋아요 항목에서 취소되었습니다.</div>
                        </div>

                        <!-- 장바구니 -->
                        <button class="product-cart" @click="fnCart(item.itemNo, userId)">🛒</button>
                        <div v-if="showCartPopup" class="popup-overlay">
                            <div class="popup">장바구니에 추가되었습니다</div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="indexnum">
                <a v-if="page !=1" id="index" href="javascript:;" class="color-black" @click="fnPageMove('prev')">
                    < </a>
                        <a id="index" href="javascript:;" v-for="num in index" @click="fnPage(num)">
                            <span v-if="page == num">
                                {{num}}
                            </span>
                            <span v-else class="color-black">
                                {{num}}
                            </span>
                        </a>
                        <a v-if="page!=index" id="index" href="javascript:;" class="color-black"
                            @click="fnPageMove('next')"> >
                        </a>
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
                    list: [],
                    pageSize: 9,
                    productcount: 0,
                    index: 0,
                    page: 1,
                    price: 0,
                    keyword: "",
                    userId: "${sessionId}",
                    likedItems: new Set(),
                    showLikePopup: false, // 좋아요 표시

                    showCartPopup: false, // 장바구니 표시

                    selectedCategory: "전체메뉴", // 선택된 카테고리 기본값
                    allCategory: [],
                    isDropdownOpen: false, // 카테고리 드롭다운 상태


                    sortOption: "인기순", // 기본 정렬 기준
                    isSortDropdownOpen: false, // 정렬기준 드롭다운 상태

                };
            },
            methods: {
                fnProductList() {
                    var self = this;
                    var nparmap = {
                        keyword: self.keyword,
                        pageSize: self.pageSize,
                        page: (self.page - 1) * self.pageSize,
                        searchOption: self.selectedCategory, // 선택된 카테고리 추가
                        sortOption: self.sortOption, // 선택된 정렬 기준 추가

                    };
                    $.ajax({
                        url: "/product/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            if (data.result == "success") {
                                console.log(data);
                                self.list = data.list;
                                self.productcount = data.count;

                                self.allCategory = [{ category: "전체메뉴" }, ...data.category];
                                console.log(self.allCategory);
                                self.index = Math.ceil(data.count / self.pageSize);
                            } else {
                                console.log("실패");
                            }
                        }
                    });
                },

                selectOption(category) {
                    this.selectedCategory = category; // 버튼 텍스트 변경
                    this.isDropdownOpen = false; // 드롭다운 닫기
                    this.fnProductList();
                },

                toggleDropdown() {
                    this.isDropdownOpen = !this.isDropdownOpen; // 드롭다운 상태 토글
                },

                changeSortOption(option) {
                    this.sortOption = option;
                    this.isSortDropdownOpen = false; // 드롭다운 닫기
                    this.fnProductList(); // 정렬 기준 변경 후 상품 목록 갱신
                },

                // 정렬기준 드롭다운 토글
                toggleSortDropdown() {
                    this.isSortDropdownOpen = !this.isSortDropdownOpen;
                },

                fnInfo(itemNo) {
                    pageChange("/product/info.do", { itemNo: itemNo });
                },

                fnPage: function (num) {
                    let self = this;
                    self.page = num;
                    self.fnProductList();
                },

                fnPageMove: function (direction) {
                    let self = this;
                    let next = document.querySelector(".next");
                    let prev = document.querySelector(".prev");
                    if (direction == "next") {
                        self.page++;
                    } else {
                        self.page--;
                    }
                    self.fnProductList();
                },
                formatPrice(value) {
                    return value ? parseInt(value).toLocaleString() : "0";
                },

                // 좋아요 버튼 활성화/비활성화
                fnLike(itemNo) {
                    var self = this;
                    var nparmap = {
                        itemNo: itemNo,
                        userId: self.userId
                    };
                    console.log(itemNo);
                    console.log(self.userId);

                    // 서버에 요청 보내기 (좋아요 추가 또는 취소)
                    $.ajax({
                        url: "/product/likeToggle.dox",  // 서버의 엔드포인트 (좋아요 추가/취소 처리)
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            if (data.result == "a") {  // 좋아요 추가
                                if (!self.likedItems.has(itemNo)) {
                                    self.likedItems.add(itemNo);  // 좋아요 추가
                                    self.showLikePopup = true;
                                    setTimeout(() => {
                                        self.showLikePopup = false;
                                    }, 2000);
                                }
                            } else if (data.result == "c") {  // 좋아요 취소
                                if (self.likedItems.has(itemNo)) {
                                    self.likedItems.delete(itemNo);  // 좋아요 취소
                                    self.showLikePopup = false;
                                }
                            } else {
                                console.error("좋아요 처리 실패", data.message);
                            }
                        },
                        error: function () {
                            console.error("AJAX 요청 실패");
                        }
                    });
                },

                fetchLikedItems() {
                    var self = this;
                    var nparmap = {
                        userId: self.userId
                    };
                    console.log("fetchLikedItems: " + self.userId);
                    $.ajax({
                        url: "/product/getLikedItems.dox", // userId별 좋아요한 상품을 가져오는 API
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            if (data.result == "success") {
                                console.log("좋아요 목록 (Wish 객체): ", data.wish);

                                // Wish 객체 리스트에서 itemNo만 추출하여 Set으로 변환
                                self.likedItems = new Set(data.wish.map(wish => wish.itemNo));
                            }
                        }
                    });
                },


                fnCart(itemNo, userId) {
                    //ajax로 보내주기
                    // console.log(itemNo);
                    // console.log(userId);
                    this.showCartPopup = true;
                    setTimeout(() => {
                        this.showCartPopup = false;
                    }, 2000);
                },

            },
            mounted() {
                var self = this;
                self.fnProductList();
                self.fetchLikedItems();
            }
        });
        app.mount('#app');
    </script>