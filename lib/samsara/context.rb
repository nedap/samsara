require 'active_record'

class Samsara::Context < ActiveRecord::Base

  include Samsara::ContextConcern

end
