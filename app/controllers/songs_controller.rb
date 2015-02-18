class SongsController < ApplicationController
  
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
    @playlist = Playlist.find(params[:playlist_id])
    @playlist.songs.create(params[:song])
    
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
    @playlist = Playlist.find(params[:playlist_id])
    client = Grooveshark::Client.new({session: session[:groove_session]})
    results = client.search_songs(params[:songs][:search])
    @interpreted_results = results.map {|song| Song.new_from_grooveshark(client, song)}
  end

  def song_search_by(query_type, input)
    client = Grooveshark::Client.new({session: groove_session})
    @search_results = client.search(query_type, input)
  end
end
