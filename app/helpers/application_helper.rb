module ApplicationHelper
  # Railsの環境名を返す
  # @return [String] productionではない場合に環境名を返す
  def rails_env
    Rails.env.production? ? '' : "[#{Rails.env.upcase}] "
  end

  # パンくずリストのHTMLを返す
  # @param [Array] path パンくず [[ラベル, リンク先], [ラベル, リンク先], ..., ラベル]
  # @return [String] パンくずリストのHTML
  def breadcrumbs(path)
    html = '<ol class="breadcrumb">'
    path.each do |p|
      if p.kind_of?(Array)
        html += '<li>' + link_to(p[0], p[1]) + '</li>'
      else
        html += "<li class=\"active\">#{p}</li>"
      end
    end
    html += '</ol>'
    html.html_safe
  end

  # 改行を <br> に変換して返す
  # @param [String] str
  def lf2br(str)
    str.gsub(/\n/, '<br>').html_safe
  end

  # image_tagの代わりにlazy-loadingタグを使うためのヘルパー
  def lazy_image_tag source, options = {}
    options['data-original'] = source
    if options[:class].blank?
      options[:class] = "lazy"
    else
      options[:class] = options[:class].to_s + " lazy"
    end
    image_tag 'image_dummy.jpg', options
  end

end
