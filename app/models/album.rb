require 'open-uri'

class Album
  def initialize(post)
    @url = post.cover_image
    @post = post
  end

  def update
    new_url = @url
    new_url << ' ' + id
    new_url << ' ' + title
    @post.update_columns(cover_image: new_url)
  end

  private

  def id
    parse_content.css("meta[property='og:video']")[0]['content'].match(/album=\K\d+/)[0]
  end

  def title
    parse_content.css("meta[name='title']")[0]['content']
  end

  def parse_content
    @content ||= Nokogiri::HTML(open(@url))
  end
end