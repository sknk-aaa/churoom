# chuRoomサービス概要

中央大学後楽園キャンパスの空き教室を簡単に検索できる Web アプリです。  
「時間から探す」「教室から探す」の 2 つの検索モードで、学生の自習学習、プレゼン練習等の教室探しを楽にすることを目的としています。

- 公開サイト: https://churoom.com

## アプリを作成した理由

私自身がキャンパスで過ごしている際、**授業の合間で「いま使える教室」を素早く見つけたい**、と感じることが多くありました。  
図書館やラウンジが満席のとき、教室の空き状況はシラバスや PDF、掲示など**点在した情報を自分で突き合わせる必要**があります。
結果として「探すコスト」が高く、せっかくのスキマ時間が確認作業に消えてしまうという課題がありました。

そこで、以下の方針で**10 秒で答えに辿り着くUI**を目指しました。
- **「現在の空き教室」を表示**
  講義が行われている時間に、そのときの空き教室を一覧で表示。
- **認証なし・即利用**：  
  ログイン不要、個人情報は扱わない設計で心理的ハードルを下げる。
- **モバイルファースト・軽量**：  
  9割スマホ想定。無駄なアニメーションや重いライブラリを避け、レスポンス優先。
- **PWA/ホーム追加**：  
  よく使う人がワンタップで開けるようにアイコンやマニフェストを整備。


## 主な機能

- **時間から探す**：曜日・時限を指定 → 空き教室を一覧表示  
- **教室から探す**：教室番号を指定 → 空き時間を時間割形式で表示。
<img width="2360" height="885" alt="Image" src="https://github.com/user-attachments/assets/012d9c67-f816-4bfa-a70b-9c2cc368ed45" />


## 使い方

1. トップで **「時間から探す」** または **「教室から探す」** を選択  
2. 条件（曜日・時限／教室番号）を入力 もしくは **「現在の空き教室一覧」** から検索
3. 結果から用途に合う教室を選択 

## 画面遷移図
<img width="577" height="577" alt="Image" src="https://github.com/user-attachments/assets/28c4575d-8fd4-4a56-8b83-66103abd7aba" />

## お問い合わせ

- フォーム: `/contact`（アプリ内の「お問い合わせ」からアクセス）
- 目的: 不具合報告、改善要望、問い合わせの受付
- 取り扱い: 入力いただいた内容は **運用メールアドレス宛に送信** されます（**DBには保存しません**）  
  ※返信が必要な場合のみメールアドレスを使用します。それ以外の目的では利用しません。


# 技術

## 技術スタック
- 言語：Ruby 3.2.2 / HTML / CSS / JavaScript
- フレームワーク：Rails 8系, Stimulus
- デプロイ：Render（Git連携）
- データ：CSV（`db/data/timetableYYYY.csv`）
- PWA：Web App Manifest + 透過アイコン（ホーム追加対応）  

## データモデル / CSV 仕様
- 文字コード：`SJIS -> UTF-8` に変換して格納
- 必須カラム例：

  | column | type   | example |
  |--------|--------|---------|
  | day    | String | "Mon"   |
  | time   | Int    | 1       |
  | number | String | "5334"  |

- 内部表現：
  - `occupied_rows = @table.select { |row| row[:day] == day && row[:time] == time }`
  - `occupied_rooms = occupied_rows.map { |row| row[:number].to_s }`
  - `available_rooms = @all_rooms - occupied_rooms`
- 学期始め（前期/後期）更新：`db/data/timetableYYYY.csv` を差し替え
- `app/controllers/searches_controller.rb` の `CSV_PATH = Rails.root.join("db", "data", "timetable2025.csv")` 部分の更新


## 技術メモ（お問い合わせフォーム）
- フレームワーク: Rails **Action Mailer**
- 送信方式:
  - **SMTP** で運用アドレスから送信
- 環境変数（Renderで設定）:
  - `SMTP_USER`
  - `SMTP_PASS`
  - `CONTACT_TO`
  - `CONTACT_FROM`


## 今後の予定
- 他キャンパス対応
- お気に入り教室の保存

