AutoHtml.add_filter(:slideshare).with(:width => 427, :height => 356) do |text, options|
  require 'nokogiri'
  require 'open-uri'

  text.gsub(/http:\/\/(www.)?slideshare\.net\/[A-Za-z0-9._%-]*\/([A-Za-z0-9._%-]*)[&\w;=\+_\-]*/) do |s|
    begin
      doc = Nokogiri::HTML(open(s))
      meta = doc.css('meta[name="twitter:player"]').first
      if meta
        src = meta.attr(:value)
        %{<iframe src="#{src}" width="#{options[:width]}" height="#{options[:height]}" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px 1px 0; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe>}
      else
        text
      end
    rescue
      text
    end
  end
end
