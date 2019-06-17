class Identity < ApplicationRecord
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider


  def self.from_oauth(auth)
    p auth
    find_or_create_by(uid: auth[:email], provider: auth[:provider])
  end

end
