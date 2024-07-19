class Page < ApplicationRecord
    # Define ransackable attributes for search functionality
    def self.ransackable_attributes(auth_object = nil)
      %w[content created_at id title updated_at]
    end
  end
  