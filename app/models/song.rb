class Song < ActiveRecord::Base
  include GrooveSharkSong
  
  belongs_to :playlist  
end

