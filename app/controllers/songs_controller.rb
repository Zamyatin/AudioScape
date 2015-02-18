class SongsController < ApplicationController
  
  STOCK_IMG = '/images/devil_horns.jpg'
  
  
  def index

  end

  def new

  end

  def show
    client = Grooveshark::Client.new({session: session[:groove_session]})
    @groove_song = Song.find(params[:id])
    @groove_url = client.get_song_url_by_id(@groove_song.link)
  end

  def create
    song = Song.new(title: params[:song_name], artist: params[:song_artist], link: params[:song_id], playlist_id: params[:playlist_id], coverart: params[:coverart])

    if song.coverart != ''
      song.coverart = "http://images.gs-cdn.net/static/albums/#{params[:coverart]}"
      song.save
    else
      song.coverart = STOCK_IMG
      song.save
    end

    redirect_to "/playlists/#{params[:playlist_id]}/"
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
    results = groove_session.search_songs(params[:songs][:title])
    @g
  end

  def song_search_by(query_type, input)
    client = Grooveshark::Client.new({session: session[:groove_session]})
    @search_results = client.search(query_type, input)
  end
end
