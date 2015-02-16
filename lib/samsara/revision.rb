require 'active_record'

class Samsara::Revision < ActiveRecord::Base

  include Samsara::RevisionConcern

end
