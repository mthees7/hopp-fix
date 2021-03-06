class ContentController < ApplicationController

  def new
  end

  def create
  end

  def show
    duration = params[:id].to_i

    content_type = ['video', 'music', 'article']
    random_number = [0, 1, 2]
    i = random_number.shuffle.first
    @show = content_type[i]

    soundcloud_id = Source.find_by_source_name('soundcloud').id
    youtube_id = Source.find_by_source_name('youtube').id
    medium_id = Source.find_by_source_name('medium').id

    if @show == content_type[0] #video
      video = Content.acquire_youtube_content(@current_user.interests.where(:source_id => youtube_id).shuffle.first.interest_name, duration).shuffle.first
      @youtube_content = video.html
      @url = video.url

    elsif @show == content_type[1] #music
      song = Content.acquire_soundcloud_content(@current_user.interests.where(:source_id => soundcloud_id).shuffle.first.interest_name, duration).shuffle.first
      @soundcloud_content = song.html
      @url = song.url

    elsif @show == content_type[2] #article
      article = Content.acquire_medium_content(@current_user.interests.where(:source_id => medium_id).shuffle.first.interest_name).shuffle.first
      @medium_content = article.html
      @url = article.url

    end
    render 'show'
  end

end

  #############
  # Youtube
  #############

      # raise params.inspect
      # client = YouTubeIt::Client.new(:username => "nick.doherty", :password =>  "dingolover1888", :dev_key => "AIzaSyBcOSkLmd0kFk3zKyWP5hu3i_vo4XSz05E")

      # interest = @current_user.interests.where(:source_id => Source.find_by_source_name('youtube').id ).sample.interest_name
      # random_youtube_interest = ":" + interest
      # n = (1 + rand(9))

      # @video = client.videos_by(:categories => [random_youtube_interest], :per_page => 50, :page => n, :fields => {:view_count => "5000"}).videos.shuffle.first


  #############
  # Soundcloud
  #############


      # raise params.inspect
      #client = Soundcloud.new(:client_id => '2807db7b829c81b57f6eff2c8d862e2a')

      # @random_soundcloud_interest = @current_user.interests.where(:source_id => Source.find_by_source_name('soundcloud').id ).shuffle.first.interest_name

      # track_url = client.get('/tracks', :genres => @random_soundcloud_interest.downcase).sample.uri
      #@embed_info = client.get('/oembed', :url => @check)


      # elsif @show = content_type[2]
      #   use filter to get rss content based on ('interest')


