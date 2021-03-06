class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    if params[:query].present?
      @movies = Movie.global_search(params[:query])
    # raise
    else
      @movies = @list.movies
    end
    respond_to do |format|
      format.html
      format.text { render partial: 'list.html', locals: { movies: @movies } }
    end
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to list_path(@list), notice: 'List was successfully created.'
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
