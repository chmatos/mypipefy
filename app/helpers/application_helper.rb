# frozen_string_literal: true

module ApplicationHelper

  def safe_url(url)
    return '' if url.blank?
    url[0..3] == 'http' ? url : url.prepend('http://')
  end
end
