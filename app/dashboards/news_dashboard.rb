require "administrate/base_dashboard"

class NewsDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    provider: Field::BelongsTo,
    user: Field::BelongsTo,
    category: Field::BelongsTo,
    rss_provider: Field::BelongsTo,
    # question: Field::HasOne,
    media: Field::ActiveStorage.with_options(
      destroy_url: proc do |namespace, resource, attachment|
        [:destroy_avatar_admin_news, { attachment_id: attachment.id }]
      end
      ),
    id: Field::Number,
    summary: Field::String,
    media_url: Field::String,
    media_credit: Field::String,
    published_on: Field::DateTime,
    title: Field::String,
    url: Field::String,
    question: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    news_type: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    title
    provider
    category
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  id
  provider
  category
  summary
  published_on
  title
  url
  media
  media_url
  media_credit                                            
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  title
  category
  provider
  summary
  url
  media
  media_url
  media_credit
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how news are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(news)
    "#{news.title}"
  end
end
