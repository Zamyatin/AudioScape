class SongsController < ApplicationController
  
  STOCK_IMG = '/images/devil_horns.jpg'
  
  
  def index

  end

  def new

    render 'new', layout: false

  end

  def show
    client = Grooveshark::Client.new({session: session[:groove_session]})
    @groove_song = Song.find(params[:id])
    @groove_url = client.get_song_url_by_id(@groove_song.link)
  end

  def create
    playlist = Playlist.find(params[:playlist_id])
    playlist.songs.new(params[:interpreted_result])
    
    redirect_to playlist
  end

  def destroy
    playlist = Playlist.find(params[:playlist_id])
    song = playlist.songs.find(params[:id])
    song.destroy

    redirect_to playlist
  end

  def update

  end

  def search
    client = Grooveshark::Client.new({session: session[:groove_session]})
    results = client.search_songs(params[:songs][:title])
    @interpreted_results = results.each {|song| Song.new_from_grooveshark(song)}
      
  end

  def song_search_by(query_type, input)
    client = Grooveshark::Client.new({session: groove_session})
    @search_results = client.search(query_type, input)
  end
end
