class MoviesController < ApplicationController

  def index
    @movies = Movie.all

    case params[:duration]
    when '<90' then @movies = @movies.where(runtime_in_minutes: 0..89)
    when '90..120' then @movies = @movies.where(runtime_in_minutes: 90..120)
    when '>120' then @movies = @movies.where(runtime_in_minutes: 121..1000)
    end

    @movies = @movies.where('title like ? OR director like ?', "%#{params[:search]}%", "%#{params[:search]}%") if params[:search]

    #Movie.where(sql)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
    )
  end

end