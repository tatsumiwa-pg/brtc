<h1 align="center">ﾈｺと和解せよ<br>
-BeReconciledToCat-</h1>

![nekotowakaiseyo-title](https://user-images.githubusercontent.com/91407881/151696574-a4bdbe4c-1750-4e5a-9210-c03542124952.png)


<br>

___

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)

<br>
<br>



# 概要

このアプリは、我々と 約9,500年もの付き合いがありながら、未だ謎だらけの存在「ﾈｺ」に関する日常のあれやこれやから真髄にいたる高次元なものまで、あなたが抱える悩みをざっくばらんと、そして包括的に相談できる総合相談サイトです！
きっとﾈｺの使徒達が、あなたの悩みに答え、ﾈｺを和解へと導いていくことでしょう。

<br>
<br>

# 本番環境
https://nekoto-wakaiseyo.herokuapp.com/

Basic認証が必要です。サイト訪問時に出現するフォームに以下を入力してください
- 認証ID: miwa
- PASS : 2078

<br>

## テスト用アカウント

相談投稿者用アカウント
- アドレス  : test@test.com
- パスワード : 11111q

回答者用アカウント
- アドレス : test4@test.com
- パスワード : 11111q

<br>
<br>

# 制作背景

<h3><strong>その人に寄り添った猫の相談を、迅速に、より具体的に解決したい</strong></h3>

<br>

&nbsp;現在、猫はペットとして国内において約900万頭もの数が飼育されています。しかし、これだけの飼育頭数がいるとなると、そこで発生する問題は様々です。大抵の場合、健康のことであれば近くの動物病院に、飼育に関する基礎知識であれば、購入時にペットショップ等で情報を得ることができます。しかし、実際に起こりうる問題は個体や飼育環境により千差万別。<strong>「こんなはずじゃなかった」</strong>と、最終的には自ら保健所へ猫を引き渡したり、遺棄したりするケースが後を経ちません。

&nbsp;一方、相談する場としてWeb上には専門家による相談サイトが存在しますが、運営側の都合、時間がかかるケースが多くあまり認知もされていません。また、大手掲示板のようなサイトで相談することも考えられますが、あくまで全体のカテゴリーの一つとしてあまり専門性はありません。さらに、現在のネットユーザーの多くはTwitterのようなSNSを相談や情報収集の場に利用していますが、こちらは１４０文字（全角）という文字数制限があり、より具体的な相談はしにくい状況となっております。相談者が求める回答と閲覧者が想像する回答に齟齬が発生する可能性が高く、それが元に余計な言い争いや誹謗中傷が発生するケースが散見されます。

&nbsp;<strong>そこで、今回私は完全に猫に特化し、かつ包括的な話題に対して具体的な相談ができる相談サイトを制作しようと考えました。フォームの入力により、問題に至るまでの背景や状況を「前提」として表示することにより、なぜその人が困っているのか、その人に寄り添った回答を求めることができるのではないかと考えました。</strong>

<br>

<h2 align="center">ﾈｺと和解せよ</h2>

<br>

<p align="center">それが今、人類に課せられた課題であり、私に与えられた使命なのです。</p>


<br>
<br>

# 機能一覧

### アカウント関連
- アカウント登録
- アカウント編集
- アカウント削除（論理削除）
- ログイン/ログアウト

### 相談関連
- 相談投稿
- 相談編集
- 相談削除
- 相談一覧参照
- 相談詳細参照
- コメント機能(Ajax / ActionCable)
- 回答締め切り

### 回答関連
- 回答作成
- 回答一覧参照
- 回答詳細参照
- コメント機能(Ajax / ActionCable)
- レビュー機能(Ajax)

### プロフィール関連
- プロフィール作成
- プロフィール編集
- プロフィール詳細参照


<br>
<br>

# では、実際に見ていきましょう

### トップページ

[![Image from Gyazo](https://i.gyazo.com/5a7ffd5a7bad5fd5ac7877b01676ef53.png)](https://gyazo.com/5a7ffd5a7bad5fd5ac7877b01676ef53)

<br>

### ヘッダーからは新規登録やログインページに遷移できます
ログイン状態では以下のメニューが表示されます
1. 「マイページへ」 ・・・プロフィール詳細ページへ
2. 「アカウント編集」・・最初に登録したアカウント情報を修正するページへ
3. 「ログアウト」・・・・文字通りログアウトします

[![Image from Gyazo](https://i.gyazo.com/5b5468ed06d0f6b9289157600438b42a.gif)](https://gyazo.com/5b5468ed06d0f6b9289157600438b42a)

<br>

### アカウント登録がすむとプロフィール作成画面に移ります！

[![Image from Gyazo](https://i.gyazo.com/08289844145e79106994f075e312c3d8.gif)](https://gyazo.com/08289844145e79106994f075e312c3d8)

<br>

### 私、身バレ怖い… →安心してください！スキップできますよ！
- 全部の項目が初期値のまま「保存」ボタンを押してもスキップになります
- どれか一つでも入力したり選択するとあなたのプロフィールが完成です
- ユーザーアイコンを変更したい方は画像をアップロードしてくださいね！

[![Image from Gyazo](https://i.gyazo.com/c6d947c6bb07633af200ce16870b985b.gif)](https://gyazo.com/c6d947c6bb07633af200ce16870b985b)

<br>

### では、早速相談を投稿してみましょう！
- ヘッダーメニューから「相談する」をクリック！
- 全ての項目を埋めると相談を投稿できます（画像は任意です）

[![Image from Gyazo](https://i.gyazo.com/3c7f82518451138c740d8e300d58d8d5.gif)](https://gyazo.com/3c7f82518451138c740d8e300d58d8d5)

<br>

### 投稿された相談はトップページに表示されます
- 表示された相談のタイトルをクリックするとその相談の詳細ページに遷移します
- 詳細画面では自身が投稿した相談に対して編集や削除ができます
- ただし、コメントや回答が寄せられた場合、削除はできなくなりますのでご注意ください

[![Image from Gyazo](https://i.gyazo.com/3054b281b8497ab6951d76a3bdddaaab.gif)](https://gyazo.com/3054b281b8497ab6951d76a3bdddaaab)

<br>

### 回答を投稿しましょう！
- 他の人が投稿した相談の詳細ページから、回答作成ページに遷移できます

[![Image from Gyazo](https://i.gyazo.com/22b19bdd1959430e0288c4a271e374bb.gif)](https://gyazo.com/22b19bdd1959430e0288c4a271e374bb)


<br>

### 回答を投稿すると相談の詳細ページに投稿した回答が表示されます
- 回答情報はすべて埋める必要があります（画像は任意です）
- 表示された回答のタイトルをクリックすると、回答の詳細ページへ遷移できます

[![Image from Gyazo](https://i.gyazo.com/4fef7adb59dd1af284051a77d2ac8d36.gif)](https://gyazo.com/4fef7adb59dd1af284051a77d2ac8d36)

<br>

### 相談にはコメントがつけられます！

[![Image from Gyazo](https://i.gyazo.com/401f6deb732dcaf5127ce45edb6a884b.gif)](https://gyazo.com/401f6deb732dcaf5127ce45edb6a884b)

<br>

### もちろん、回答にもコメントがつけられます！

[![Image from Gyazo](https://i.gyazo.com/569e870d2082b68f2d550ca849c3d1ef.gif)](https://gyazo.com/569e870d2082b68f2d550ca849c3d1ef)

<br>

### 相談者は、回答に対して評価をつけることができます！

[![Image from Gyazo](https://i.gyazo.com/1c4d6201b3da2d5b9872adaa1812050b.gif)](https://gyazo.com/1c4d6201b3da2d5b9872adaa1812050b)

<br>

### 回答が得られた相談は、解決済みの状態にすることができます

[![Image from Gyazo](https://i.gyazo.com/1ee14ffcf54e7fdd6adb2619e9a331a2.gif)](https://gyazo.com/1ee14ffcf54e7fdd6adb2619e9a331a2)

<br>

### 自信の投稿した相談や回答、回答につけられた評価は、プロフィール画面で確認できます！

[![Image from Gyazo](https://i.gyazo.com/1a4aa07cd963f2ac4cba6b71e9805614.gif)](https://gyazo.com/1a4aa07cd963f2ac4cba6b71e9805614)

<br>
<br>

# こだわり

### 1. 結合テスト
<br>
正直な話、プログラムを書いていた時間以上にテストに時間をかけていたように思います。そのおかげもあって、テストでは特定の要素や値を取得する方法についての見識はかなり深まったように感じます。また、環境により同じコードでも失敗する可能性があることも学びました

- できるだけ再現性の高いテストを実施（`sleep`の極力排除）<br>
- `within`でテストのスコープ（範囲）を限定し、同じ要素の重複によるエラーを排除

<br>
<br>

### 2. 親要素と子要素、孫要素をどのように取得するか
<br>
アソシエーションを組んだ要素をどのようにDBから抽出するか、という点については強く意識しました。

- 不安定な挙動をする`includes`メソッドではなく、`joins`や`preload`メソッドを用いて必要最低限なクエリの発行を意識
- 一度定義した変数を活用したクエリの発行

<br>
<br>

### 3. Turbolinksを同居させたままAjax通信を実装
<br>
JavaScriptファイルが読み込まれない可能性があるためひとまずTurbolinksをoffにするという手法をこれまで取ってきましたが、今回はそのTurbolinksの利点を殺さずに導入できないかと模索した結果、なんとか同居させることに成功しました。<br>
↓ その時のQiita記事です

[【Rails6】Turbolinksを同居させたままActionCableで非同期通信コメント機能を実装したい！](https://qiita.com/tatsumiwa/items/3ca1e2d034e5ae36bc43)

<br>
<br>

### 4. ユーザー登録機能をウィザード形式「ふう」に実装
<br>
ウィザード形式のユーザー登録を考えた場合、フォームの情報をセッションに一時保存して、次のページでのフォーム送信時に別々のテーブルに登録するという方法が考えられますが、途中のページでURL入力により途中離脱された場合のセッションをどのようにするかという考えに至りました。<br>
そこで今回の実装では、プロフィール登録のページは一旦表示させつつ、任意で、という形式をとることにより、セッションを利用せずともウィザード形式を装いつつ、独立させた形でユーザー情報を作成することを可能としました。
この方式を取ることにより、プロフィールを作成したくないユーザーの分だけデータレコードを削減することができ、DB容量の圧迫を防ぐことに一役買っていると考えます。


<br>
<br>

___

## こだわりたかった話

<br>

### 1. DBの無駄を省きたかった<br>
<br>
とにかく <strong>DBの設計に無駄がないように!</strong> を心がけました。
アソシエーションによってできることを最大限に活用すべく、テーブルの中に余分なカラムを作らないことを意識しました。<br>

- コメントテーブルを２つに分割
- 文章のカラム型をtextとstringに分割。それぞれの許容量を知る
- 改めてDB設計とSQLを学ぶ意欲が向上
- 「null」が入るカラムを極力無くすように設計。SQLでクエリ発行時に意図しない挙動を起こさないように配慮
- 一方、userモデルに論理削除を実装するのであれば、usersテーブルにdeleted_atカラムを追加するのではなく、別に削除されたことを記録するテーブルを作成すればよかったのでは…？

<br>
<br>

### 2. 完全レスポンシブ対応にしたかった
<br>
全ページ、水平方向に対してレイアウトが変更されるように実装しました
今回は初めてscss(sass)を使用し、記述量が減るようにと意識したところでしたが、まだまだ改良の余地があります。<br>
<br>

### 加えて、本番環境のスマートフォンのブラウザからではJavaScriptが作動しません

<br>
※現在原因究明中です

<br>
<br>


<br>

# 今後の実装予定

- カテゴリー別相談一覧表示機能
- ページネーション機能
- タグ機能
- 検索機能
- レスポンシブ対応（スマホ版ブラウザでのJsファイルの作動）
- 通知機能
- ユーザーテーブル論理削除の見直し

<br>
<br>

# 実装環境

- ruby `2.6.5`
- rails `6.0.4.4`
- activestorage `6.0.4.4`
- actioncable `6.0.4.4`
- mysql2 `0.4.4`
- sass-rails `5.2.1`
- webpacker `4.3.0`
- turbolinks `5`
- rspec-rails `4.0.0`
- active_hash `3.1.0`
- aws-sdk-s3 `1.112.0`


<br>
<br>

<h1 align="center">DB</h1>

## ER図

[![Image from Gyazo](https://i.gyazo.com/a2efb3889614e4c40196d8e4599bf8bd.png)](https://gyazo.com/a2efb3889614e4c40196d8e4599bf8bd)



# *user-related*

## users
| Column             | Type     | Options                   |
|--------------------|----------|---------------------------|
| nickname           | string   | null: false, unique: true |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| deleted_at         | datetime |                           |


### Association
- has_many :consultations
- has_many :answers
- has_many :cons_comments
- has_many :ans_comments
- has_one  :profile
- has_many :reviews, through: :answers

<br>

---

<br>

## profiles
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| age          | integer    | null: false                    |
| job          | string     | null: false                    |
| skills       | string     | null: false                    |
| address      | string     | null: false                    |
| cat_exp      | string     | null: false                    |
| family_type  | integer    | null: false                    |
| house_env    | integer    | null: false                    |
| my_cats      | text       | null: false                    |
| introduction | text       | null: false                    |
| user         | references | null: false, foreign_key: true |

<br>

---

<br>

# *consultation-related*

## consultations
| Column      | Type       | Options                        |
|-------------|------------|--------------------------------|
| cons_title  | string     | null: false                    |
| category_id | integer    | null: false                    |
| summary     | string     | null: false                    |
| situation   | text       | null: false                    |
| problem     | text       | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many   :answers
- has_one    :reconciliation
- has_many   :cons_comments

---

<br>

## reconciliation
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| rec_text     | string     | null: false                    |
| consultation | references | null: false, foreign_key: true |

### Association
- belongs_to :consultation

<br>

---

<br>

## cons_comments
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| cons_c_text  | string     | null: false                    |
| user         | references | null: false, foreign_key: true |
| consultation | references | null: false, foreign_key: true |

### Association
- belongs_to :consultation

<br>

---

<br>

# *answer-related*

## answers
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| ans_title    | string     | null: false                    |
| ans_text     | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| consultation | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :consultation
- has_one    :review
- has_many   :ans_comments

<br>

---

<br>

## reviews
| Column  | Type       | Options                        |
|---------|------------|--------------------------------|
| point   | integer    | null: false                    |
| answer  | references | null: false, foreign_key: true |

### Association
- belongs_to :answer

<br>

---

<br>

## ans_comments
| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| ans_c_text | string     | null: false                    |
| user       | references | null: false, foreign_key: true |
| answer     | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :answer 

<br>

---

<br>

# *tag-related*

## tags
| Column   | Type   | Options                        |
|----------|--------|--------------------------------|
| tag_name | string | null: false                    |

### Association
- has_many :consultation_tags
- has_many :consultations, through: :consultation_tags 

<br>

---

<br>

## consultation_tags
| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| consultation | references | null: false, foreign_key: true |
| tag          | references | null: false, foreign_key: true |

### Association
- belongs_to :consultation
- belongs_to :tag
