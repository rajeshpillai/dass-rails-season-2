class Post < ApplicationRecord
   belongs_to :category

   has_many :taggings # join table
   has_many :tags, through: :taggings

   scope :published, lambda { where(published: true)}
   scope :unpublished, -> { where(published: false)}

   scope :limit_5, -> { limit(5)}
   scope :order_by_latest_first, -> { order(created_at: :desc)}

   # tag_ids

   def all_tags=(names) 
      if names.blank? 
         return 
      end
      # ruby, rails
      self.tags = names.split(",").map do |name| 
         unless name.blank?  
            Tag.where(name: name.strip).first_or_create!
         end
      end
   end

   def all_tags 
      tags.map(&:name).join(", ")
   end

end

