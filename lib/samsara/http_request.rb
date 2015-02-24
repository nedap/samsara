class Samsara::HttpRequest
  attr_accessor :attributes

  def self.build_from(controller)
    self.new(extract_attributes_from controller)
  end

  def self.extract_attributes_from(controller)
    {
      url:       controller.request.filtered_path,
      params:    controller.request.filtered_parameters,
      method:    controller.request.method
    }
  end

  def initialize(attributes = {})
    @attributes = attributes
  end

  def method
    attributes[:method]
  end

  def url
    attributes[:url]
  end

  def params
    attributes[:params]
  end

end
