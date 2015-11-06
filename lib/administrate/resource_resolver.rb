require "administrate/namespace"

module Administrate
  class ResourceResolver
    def initialize(controller_path, namespace_part = nil)
      puts controller_path
      @controller_path = controller_path
      @namespace_part = namespace_part
    end

    def dashboard_class
      Object.const_get(resource_class_name + "Dashboard")
    end

    def resource_class
      Object.const_get(resource_class_name)
    end

    def resource_name
      model_path_parts.map(&:underscore).join("__").to_sym
    end

    def resource_title
      model_path_parts.join(" ")
    end

    private

    def resource_class_name
      rcn = model_path_parts.join("::")
      rcn = "#{namespace_part}::#{rcn}" unless namespace_part.nil?
      rcn
    end

    def model_path_parts
      controller_path_parts.map(&:camelize)
    end

    def controller_path_parts
      controller_path.singularize.split("/") - [Administrate::NAMESPACE.to_s]
    end

    attr_reader :controller_path
    attr_reader :namespace_part
  end
end
