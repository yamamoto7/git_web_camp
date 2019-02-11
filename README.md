# git勉強会 2/10


* バージョンとは
* ブランチの意味
* ブランチ戦略パターン
* 有名リポジトリの戦略パターン
* コンフリクトはgithub上で行わない
* マージで解消する手順（演習）
* リベースで解消する手順（演習）

* コミットメッセージの書き方パターン

* gitオブジェクト図
* オブジェクトの意味



## バージョンとは
Gitにおけるバージョンとは、ファイルの変更履歴のことを指している。
身近なところでいうとDocbaseやGoogleのドキュメント、スプレッドシートでもバージョン（変更履歴）を管理するシステムを持っています。
<img src="./README/b42f64a4914082b4653d3a9600d7f319.png width="250px">



## ブランチの意味
大きく分けるとマスターブランチ（統合ブランチ）と他のブランチ（トピックブランチ）に分類できる。
マスターブランチはどのバージョンをとってもエラーなく動くことが望ましい。
トピックブランチは機能追加、バグ修正などの目的を持って切る。→目的を果たしたら削除
・ローカルでの削除
` $ git branch -d ブランチ名 `
・リモート（画像はgithub）での削除
↓マージが完了したら右の方にすぐ削除ボタンが出てくる
<img src="README/3a4e4387799a5c96510d9cacf7a62cfe.png width="250px">


## ブランチ戦略パターン
ブランチ戦略とは（[ブランチ戦略とは - Qiita](https://qiita.com/pi-su/items/01837215ed230f7507f2)）
有名なリポジトリ（例は後で）を見てもgitflowで開発しているところがほとんど。

リリースされているアプリケーションをgitで管理しているとき、リリース済みのものはマスターブランチ、開発中の統合ブランチはdevelopとして切ることがある。
↓デフォルトブランチの変更を行うとgithub上でdevelopにマージするように設定できる。
<img src="README/e6785ad23400ffc58c4ed407c36e938e.png width="250px">

DWC2ヶ月目の開発においてはリリース済みとかそういうのはないのでdevelopブランチは必要ないと思える。

## 有名リポジトリの戦略パターン
マストドン（Railsの学習にピッタリと噂されるやつ。チケット駆動のテスト駆動開発をしています。）
[GitHub - tootsuite/mastodon: Your self-hosted, globally interconnected microblogging community](https://github.com/tootsuite/mastodon)
コミット時に ` -m ` をつけずに、詳細入力でチケット番号（issueの番号）を関連付けている。
<img src="README/0358c71dce45685fe423dd13d1b41fc6.png width="250px">

GitFlowのブランチ戦略
<img src="README/36a3c2ff24891092f7bac882b5115110.png width="250px">

CIを回して、ブランチごとに単体テストを行うテスト駆動開発
（説明は省略）
<img src="README/147044515baad9c2f898b539f30cccbd.png width="250px">

## コンフリクト
コンフリクトはgithub上で行わない。マスターブランチにマージしていくのは良くないから。（詳しくは省略）
手元のブランチにマスターブランチをmergeかrebaseする。

## マージで解消する手順
便利でよく使うコマンドを適当に織り交ぜるので、見慣れないコマンドが出るかと思いますが頑張ってください。コマンドの説明は下の画像１枚目にまとめてあります。

### マスターブランチ

<img src="README/b31951a2d4aedf03e616607d8bf0f8d5.png width="250px">

一行だけ文が入っている` sample.txt `というものを用意して、commitする。
ココから２つブランチを切り、同じ行を編集することでコンフリクトを起こす。２つのブランチで２行目に文章を追加する。
<img src="README/96e5deda48a933f7638cdbc2f47da59f.png width="250px">

### firstブランチ

`sample.txt`の２行目に
`first`と追加。
<img src="README/b586fe093e102f58abc279a42de74ebf.png width="250px">


masterにマージ

<img src="README/f46db2ead656384301b2d1edb84db840.png width="250px">

### secondブランチ

`sample.txt`の２行目に
`second`と追加。
<img src="README/13fbddc2a7662267876bdc3b2c29f1d4.png width="250px">

ここで、２行目の変更に対してコンフリクトが起こっているためマスターにマージしてしまうと動くか確認していないバージョンが含まれてしまうことになる。
（本来コンフリクトに気づくタイミングはgithubにプッシュしてマージしようとしたとき。）

### コンフリクト発生
まずマスターをマージしてくる。
<img src="README/7d64fd7828f7133eee61e8b8c926d954.png width="250px">
↑コンフリクトしていると言われている。

ステータスを見るとこの後の作業は全て乗っている。
  (fix conflicts and run "git commit")
→コンフリクト直してコミットしてください。
  (use "git merge --abort" to abort the merge)
→マージ取り消すには`git merge --abort`を。

赤く表示されている `both modified`（お互いに変更が加えられている）のファイルを治す。
<img src="README/56acd8471ef56d9409e87f87abe177f8.png width="250px">

### 解消２通り
##### ①テキストエディタで治す
<img src="README/2e6bfefbb06bc642d1a33d374a9b4127.png width="250px">
↓
<img src="README/d936776c1a2c8f385b23b46ee576a974.png width="250px">

直しただけではまだ終わっていない。
コミットしてコンフリクトが解消される
今回コミットメッセージははじめから用意されているのを使っているため、`-m`は使っていない。

<img src="README/b2e37b05aeef9f0e546f954889f89b93.png width="250px">

解消されたらプッシュしましょう

##### ②マージツールを使う（こっちのほうが見やすそう）
これを使うと①で言うとaddのとこまでやってくれる
<img src="README/291cd613846bdcfdf40676dcadaef6ee.png width="250px">
エンター押す
<img src="README/ef33070b1424a6517a29b53a107c45f9%20(1).png width="250px">
セーブ（Ctrl+S）して閉じる
（画像みたいにGUIが開かれる場合とVimなどのエディタが開かれる場合があるが、設定でかえれる。正直自分は使ったことがないため気になる人は調べてみてください。）

するとaddまで行われている。
.origとかいうファイルが生成されて、コンフリクト解消前の情報を残しておいてくれる。無事解消したら消せばいい。
<img src="README/86fa4d7b61d88fdef0ab8f10d95a2386.png width="250px">

All conflicts….と書いてあるとおり、`git commit`を行う。
<img src="README/db7c429e90300ac680f735d65f7b6664.png width="250px">

### トピックブランチ上での解消を終えたら
最後はマスターにマージして終了。

<img src="./README/a55d95ead7d85f73f71f526e2ccabf9a.png width="250px">


## リベースでのコンフリクト解消手順
先ほどとかぶるところは省略
##### secondブランチにてコンフリクト発生
<img src="README/48dad2d6b8ea553c4b1f71123c87e513.png width="250px">
マージのときより長い文で何かが書いてあるが、書いてあることは解消の手順。わからなくなってもこの出力を見返せばオッケ

解消の手順はstatusにも書いてある。
<img src="README/bc06de3534ea34fcfd6aedbdc3713e26.png width="250px">

##### 解消２通り
マージのときとaddするまでは同じ。
<img src="README/c6f2fdd83080793efc7046dc668a2fdc.png width="250px">

マージではaddのあとcommitしたが、リベースではaddのあと
`git rebase —continue` で終了する。

<img src="README/ae8533d698fd1050b08af1b88f16978f.png" width="250px">

リモートにpushしてある場合はコミットの順番などが書き換わっているためforce push（強制プッシュ）しなければならない。
（`git push -f ブランチ名`）

##### 解消後
マスターにマージして終了（マージでコンフリクト解消のときと同じ）。







#webcamp
