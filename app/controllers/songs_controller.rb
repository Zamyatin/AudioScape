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
    results = client.search_songs(params[:songs][:title])
    @interpreted_results = results.map {|song| Song.new_from_grooveshark(client, song)}
  end

  def song_search_by(query_type, input)
    client = Grooveshark::Client.new({session: session[:groove_session]})
    @artist_search_results = client.search_songs(params[:songs][:title])
    render 'search', layout: false

    #@search_results = client.search(query_type, input)
  end
  
  private
    
    def song_params
      params.require(:song).permit.(:title, :artist, :link, :source, :coverart)
    end

end
