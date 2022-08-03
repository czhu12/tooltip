# frozen_string_literal: true

module Scripts
  class Assign
    extend LightService::Action

    expects :user
    expects :script_slug, default: false

    executed do |context|
      if context.script_slug.present?
        script = Script.find_by(user: nil, slug: context.script_slug)
        if script.present?
          script.user = context.user
          script.save
        end
      end
    end
  end
end
