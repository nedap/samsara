class Samsara::HttpRequest
  attr_accessor :attributes

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

  # def user=(user)
  #   @user_id = user.try(:id)
  #   @user = user
  # end

  # def user
  #   return @user if instance_variable_defined?(:@user)
  #   @user = @user_id ? User.find(@user_id) : nil
  # end

  # def real_user=(user)
  #   @real_user_id = user.try(:id)
  #   @real_user = user
  # end

  # def real_user
  #   return @real_user if instance_variable_defined?(:@real_user)
  #   @real_user = @real_user_id ? User.find(@real_user_id) : nil
  # end

end
