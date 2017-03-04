class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: { scope: [:release_year, :artist_name] }
  validates :released, inclusion: { in: [true, false] }
  validates :artist_name, presence: true
  validate :released?
  validate :future?

  def released?
    if self.released && !self.release_year
      errors.add(:release_year, "This album wasn't released outside the space-time continuum, you fucking Einstein motherfucker!!")
    end
  end

  def future?
    t = Time.now
    if self.release_year && self.release_year > t.year
      errors.add(:release_year, "That year hasn't happened yet, you glimmering fucking time wizard!!")
    end
  end
end
