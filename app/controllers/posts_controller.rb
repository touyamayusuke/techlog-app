class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create] # ログインしているかどうかを判断

  def index
    @posts = Post.limit(10).order(created_at: :desc) # 新しい順に10件取得
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new # 新規投稿用のインスタンス変数を用意
  end

  def create
    @post = Post.new(post_params) # ストロングパラメータを使ってフォームから受け取ったパラメータを許可
    @post.user_id = current_user.id # ログインユーザのIDを代入して関連付け

    if @post.save
      flash[:notice] = t('.success') # 成功時のフラッシュメッセージ
      redirect_to posts_path # 一時的にトップページへリダイレクト(後に修正)
    else
      flash[:alert] = t('.failure') # 失敗時のフラッシュメッセージ
      render :new # 投稿画面を再表示
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])

    if post.user == current_user
      post.destroy
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.failure')
    end
    redirect_to posts_path
  end

  private

  # ストロングパラメータで許可するカラムを指定
  def post_params
    params.require(:post).permit(:title, :content) # title と content のみ許可
  end
end
