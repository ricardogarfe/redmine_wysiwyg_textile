class SongList

    attr :songs, true
    
    def initialize
        @songs = Array.new
    end

    def append(song)
        @songs.push(song)
        self
    end
end
