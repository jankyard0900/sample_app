class ListsController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = List.new
  end

  #ここから記述
  def create
    #1.& 2. データを受け取り新規登録するためのインスタンス作成
     @list = List.new(list_params)
    #3. データをデータベースに保存するためのsaveメソッド実行
    if @list.save
      redirect_to list_path(@list.id)
    else
      render :new
    end
  end

  def index
    puts "作成したキー#{ENV['SECRET_KEY']}"
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    #データを更新する・保存できるかパラメータで絞り込む
    list.update(list_params)
    #詳細画面に移動します
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id])  # データ（レコード）を1件取得
    list.destroy  # データ（レコード）を削除
    redirect_to '/lists'  # 投稿一覧画面へリダイレクト
  end


  private
  #ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
