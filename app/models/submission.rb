class Submission < ActiveRecord::Base
    belongs_to :user
    has_attached_file :image
    validates_attachment_content_type :image, :content_type => [/\Aimage/, 'application/octet-stream']
end
