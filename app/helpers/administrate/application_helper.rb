module Administrate
  module ApplicationHelper
    def render_field(field, locals = {})
      locals.merge!(field: field)
      render locals: locals, partial: field.to_partial_path
    end

    def collection_partial_path(field)
      if File.exist?("#{field.resources[0].class.to_s.underscore}/collection")
        "#{field.resources[0].class.to_s.underscore}/collection"
      else
        'administrate/application/collection'
      end
    end
  end
end
