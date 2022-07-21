class Script < ApplicationRecord
  include Graphql::Assignable
  GRAPHQL_ATTRIBUTES = %i[title description code visibility slug]
  validates_presence_of :title
  validates_presence_of :visibility
  validates_presence_of :slug
  validates_uniqueness_of :slug

  belongs_to :user, optional: true
  enum visibility: {
    public: 0,
    private: 1,
  }, _suffix: true

  after_initialize :create_slug

  def create_slug
    if slug.blank?
      self.slug = SecureRandom.uuid
    end
  end
end
