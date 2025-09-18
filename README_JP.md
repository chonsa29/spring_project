#japanese readme file
# 🥗 MEALPICK

MEALPICKは、ユーザーに合わせた献立をおすすめし、手軽に注文できるミールキットショッピングモールのウェブサービスです。
専門家が設計した健康的な献立と新鮮な材料、オーダーメード型推薦システムを通じて忙しい現代人のためのスマートな食生活を支援します。


### 📌 プロジェクト概要
[プロジェクト発表.pdf](https://github.com/user-attachments/files/20277596/default.pdf)

● プロジェクト名: MEALPICK

● 目標: ユーザーの健康情報と好みに基づいたオーダーメイド型献立おすすめ+ミールキット注文サービス

● 企画意図:健康、低速老化、持続可能な食生活をサポートする献立推薦基盤ショッピングモール構築


### 🔑 主要機能

🍱 ミールキット販売

● アレルギーおよび非人気食品のお知らせ

● 会員別おすすめミールキット


🏅 会員ランク及び特典

● 等級:ニューピック→ライトピック→グッドピック→トップピック→VVIPICK(5段階)

● 特典:割引率、ポイント積立率、クーポン、無料試食提供など


👨‍👩‍👧‍👦 グループ会員システム

● グループ単位購入金額の共有

● グループメンバー全員の特典共有

● グループ登録/チャット機能


💳 決済及びポイント

● ポイント·ペイバック·システム

● お支払いの際、会員レベル別ポイント積立

● ポイントを決済に使用可能


🗣 コミュニティー機能

● ユーザー間の献立/健康情報の共有

---


## 📆 開発期間

● 25.03.10 ~ 25.04.14


## チーム紹介
|名前|役割|担当機能|ギッハブ|
|------|---|---|---|
|チョン·サンウク|チーム長、フロントエンド、バックエンド|マイページ、管理者ページ、紹介ページ|https://github.com/chonsa29 |
|ユン·スビン|フロントエンド、バックエンド|買い物かご、メインページ、コミュニティ(レシピ、グループ)、グループシステム(チャット)||https://github.com/sbsssb |
|ジョナギョン|フロントエンド、バックエンド||単品商品ページ、詳細表示ページ|https://github.com/jonagyeong |
|ナ·イェリン|フロントエンド、バックエンド|お問い合わせ、決済システム|https://github.com/nerongnyr |
|イ·フンヨル|フロントエンド、バックエンド|会員登録、ログイン|https://github.com/LHY950626 |

## 🛠️技術スタック
|区分||技術|
|------|---|
|Frontend|Vue 3, JavaScript, HTML, CSS|
|Backend|Java (Spring MVC), MyBatis|
|Database|Oracle|
|その他||JSP、AJAX(jQuery)、LocalStorage使用など|

## 📂　プロジェクト構造

```bash
mealpick/
├── pom.xml
├── README.md
├── schema。sql
├── src/
│ ├── main/
│ │ ├── java/
│ │ │ └── com/example/demo/
│ │ │ ├-- common/ # 共通設定及びユーティリティ
│ │ │ ├-- config/ # セキュリティと環境設定
│ │ │ ├-- controller/ # コントローラー (ウェブ要請処理)
│ │ │ ├-- dao/ # サービスロジック
│ │ │ ├-- mapper/ # MyBatis マッパーインターフェース
│ │ │ └-- model/ # VO/DTOクラス
│ │ ├── resources/
│ │ │ ├---application.properties #環境設定
│ │ │ └── mybatis-mapper/ # XML 매퍼 (sql-*.xml)
│ │ └── webapp/
│ │ ├-- css/ # 全域 CSS ファイル
│ │ ├── js/ # JavaScript 파일
│ │ ├-- img/ # イメージリソース
│ │ └── WEB-INF/
│ │ ├-- common/ # ヘッダー/フッター JSP
│ │ ├-- cart/ #買い物かご/決済 JSP
│ │ ├-- chatting/ # チャット JSP
│ │ ├--community/#コミュニティ関連JSP
│ │ ├-- help/ # お知らせ、お問い合わせ関連 JSP
│ │ ├-- member/ # 会員登録/ マイページ JSP
│ │ └-- product/ # 商品情報 JSP
└── test/
└── java/com/example/demo/ # JUnit テスト
```

---
## 📸デモンストレーション映像
https://www.youtube.com/watch?v=F9O0MT5TcLo&feature=youtu.be

