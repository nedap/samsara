class Samsara::HttpRequest
  attr_accessor :user_id
  attr_accessor :real_user_id
  attr_accessor :url
  attr_accessor :method
  attr_accessor :params

  def initialize(attributes = {})
    attributes.each do |key,value|
      self.send("#{key}=", value)
    end
  end

  def attributes
    [:user_id, :real_user_id, :url, :method, :params].each_with_object({}) do |attrib, hash|
      hash[attrib] = self.send(attrib)
    end
  end

  def user=(user)
    @user_id = user.try(:id)
    @user = user
  end

  def user
    return @user if instance_variable_defined?(:@user)
    @user = @user_id ? User.find(@user_id) : nil
  end

  def real_user=(user)
    @real_user_id = user.try(:id)
    @real_user = user
  end

  def real_user
    return @real_user if instance_variable_defined?(:@real_user)
    @real_user = @real_user_id ? User.find(@real_user_id) : nil
  end

end
