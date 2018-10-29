# frozen_string_literal: true

class CategoryDecorator < ApplicationDecorator
  delegate_all

  def parent_name
    object.parent ? object.parent.nome : object.nome
  end

  def parent_categories
    parent_categories = object.parent ? object.parent.child_categories : object.child_categories
    @parent_categories ||= parent_categories.order(:nome)
  end
end
