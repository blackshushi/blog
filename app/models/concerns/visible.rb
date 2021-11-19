module Visible
  extend ActiveSupport::Concern

  VALID_STATUSES = ['public', 'private', 'archived', 'deleted']
  
  included do 
    validates :status, inclusion: {in: VALID_STATUSES}
    scope :active, -> {where.not(status: 'deleted')}
    scope :deleted, ->{where(status: 'deleted')}
  end
  
  class_methods do 
    def public_count
      where(status: 'public').count
    end
  end

  def archived?
    status == 'archived'
  end

  def destroy
    self.update(status: 'deleted')
  end
end

