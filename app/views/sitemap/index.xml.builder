base_url = "http://#{request.host_with_port}"
xml.instruct! :xml, :version=>'1.0'
xml.tag! 'urlset', "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc base_url
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc categorias_url
    xml.lastmod Time.current.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  @products.each do |product|
    xml.url do
      xml.loc produto_url(product.custom_name)
      xml.priority 0.9
    end
  end

  @categories.each do |category|
    xml.url do
      xml.loc categoria_url(category.custom_name)
      xml.priority 0.9
    end
  end
end
