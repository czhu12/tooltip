# == Schema Information
#
# Table name: scripts
#
#  id          :bigint           not null, primary key
#  code        :text
#  description :string
#  run_count   :integer          default(0), not null
#  slug        :string           not null
#  title       :string           not null
#  visibility  :integer          default("public")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_scripts_on_slug  (slug) UNIQUE
#
class Script < ApplicationRecord
  include Graphql::Assignable
  include PgSearch::Model
  pg_search_scope :search_for, against: [:title, :description]

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
