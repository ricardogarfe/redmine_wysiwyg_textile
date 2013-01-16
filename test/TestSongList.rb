require 'test/unit'
require 'rubygems'
require 'SongList'
require 'Song'

class TestSongList < Test::Unit::TestCase

    def test_delete
        list = SongList.new
        s1 = Song.new('title1','artist1',1)
        s2 = Song.new('title2','artist2',2)
        s3 = Song.new('title3','artist3',3)
        s4 = Song.new('title4','artist4',4)
        list.append(s1).append(s2).append(s3).append(s4)

        assert_equal(s1, list.songs.at(1), list.songs.each {|x| print x, " -- " })

    end
end
