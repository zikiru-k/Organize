# Organize

## サイト概要
### サイトテーマ

発注・在庫管理をする業務アプリ
​
### テーマを選んだ理由

前職は化学系の業務を行っていた中で一番苦労し、ミスが多かったのが、発注と在庫管理業務でした。

私が所属していた部署は歴史が古く、最近までタブレット等を使用していなかった為、基本的に紙で記録し、種類によってはExcelでも記録していました。

発注・在庫管理作業時は、以下の手順で行っていました。

1. 購入する商品を紙にメモする
2. 発注願いメールを作成して送信する又は、メモを発注者に渡す
3. 発注願いメールやメモを受け取った発注者が発注をする
4. 到着した商品の情報を在庫管理シートに記載する
5. 使用開始日や終了日等を記載する
6. 量が少なくなってきたら、1に戻り、発注する

しかし、この手順だと業務効率が悪く、ミスが多かったです。

よくあったミスや困っていた事が以下の通りでした。

1. 発注メールが別のメール等に埋もれてしまい、過去に購入した商品の確認がやりづらい。
2. 別の人が発注しているか、現状が分からずに発注が被ったり、発注していなかった等のミスがあった。
3. リストやサイト等の情報を一部の人しか把握出来ていない等があり、配属後や通常業務中、引継ぎの時に分かりづらかった。
4. 化学薬品は消防法等で保管できる量が決まっている為、大量に商品を発注が出来ず、少量で何度も発注していたが、それだと、紙ベースで作業していたのでExcelで管理したくても更新ペースが早すぎて間に合わない。
5. 化学薬品を保管する時は、記載しなくてはいけない内容が多い在庫管理は業務の負担が大きかった。

これらを解消するために業務に関する情報を1つにまとめて効率的に出来るようにしたいと思い、このテーマを選びました。

### ターゲットユーザ

- 発注・在庫管理の業務を簡単にしたい人
- チーム内の発注・在庫管理業務のやり取りを1つのアプリだけで終わらせたい人
- 新入社員等に仕事内容を教える時間があまり取れない人
​
### 主な利用シーン

- 在庫管理の情報を1つにまとめたい時
- 発注関係で手間が多くて困っている時
- 発注・在庫管理業務のやり取りを簡潔にし、探しやすくしたい時
- 発注・在庫管理の仕事内容を新入社員等に教える時
​
## 設計書
- ER図
![PF_ER](https://github.com/zikiru-k/Organize/assets/149685941/2cdf9609-b1e6-4726-893b-28e78a802a4f)

- アプリケーション詳細設計
https://docs.google.com/spreadsheets/d/14CYPBsEEOgwJj4of6aoT74TSi7QxxYo4C-gYVr4eCVQ/edit#gid=0

- テーブル定義書
https://docs.google.com/spreadsheets/d/1VOfQ_Oylv4SC3OzqT7ROiSkT89VfAPwxGGNfyVM92lA/edit#gid=1432769366


## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
​
## 使用素材
 <!-- 外部サービスの画像素材・音声素材を使用した場合は、必ずサービス名とURLを明記してください。
 アプリケーションの実装に使用したgem/bootstrapのリファレンスなどの記載は不要です。
 使用しない場合は、使用素材の項目をREADMEから削除してください。 -->

現在は使用予定なし