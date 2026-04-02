# GitHub に push する手順（このフォルダは既に Git 初期化済み）

ローカルでは **`main` ブランチ**に初回コミットまで完了しています。あとは **GitHub 上に空のリポジトリを作り**、次を実行してください。

## 1. GitHub でリポジトリを作成

1. [github.com](https://github.com) にログイン  
2. **Repositories** → **New**  
3. Repository name: 例 `homon-kensu-app`（任意）  
4. **Public** または **Private** を選択  
5. **Add a README** は **チェックしない**（既にローカルにあるため）  
6. **Create repository**

## 2. リモートを追加して push

画面に表示される URL（HTTPS）をコピーし、**自分のユーザー名とリポジトリ名**に置き換えて PowerShell で実行します。

```powershell
cd "訪問件数仕分けアプリのパス"
git remote add origin https://github.com/あなたのユーザー名/リポジトリ名.git
git push -u origin main
```

初回はブラウザまたはトークンで GitHub 認証を求められます。

- **HTTPS:** Personal Access Token（Classic）がパスワード欄に必要な場合があります。  
- **SSH** を使う場合は、GitHub の SSH URL で `git remote add origin git@github.com:...` としてください。

## 3. 確認

GitHub のリポジトリページに `app.py` や `requirements.txt` が見えれば成功です。  
Streamlit Cloud ではこのリポジトリを選び、**Main file path** に `app.py` を指定してデプロイできます（`docs/DEPLOY.md`）。
