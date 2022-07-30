# frozen_string_literal: true

module Scripts
  class List
    extend LightService::Action
    PAGE_SIZE = 10

    expects :filters, :page
    promises :scripts
    executed do |context|
      scripts = Script.public_visibility
      if context.filters[:q].present?
        scripts = scripts.search_for(context.filters[:q])
      end

      context.scripts = scripts.page(context.page).per(PAGE_SIZE)
    end
  end
end
