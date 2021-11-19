class Comment < ApplicationRecord
  include Visible
  belongs_to :article
  before_create :assign_status

  private
  def assign_status
    self.status = 'public'
  end
end

