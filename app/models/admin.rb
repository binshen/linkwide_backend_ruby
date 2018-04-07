class Admin < ActiveRecord::Base

  self.table_name = 'admin'

  def authenticate(password)
    self.password == password
  end

end