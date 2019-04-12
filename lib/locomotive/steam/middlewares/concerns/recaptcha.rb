module Locomotive::Steam
  module Middlewares
    module Concerns
      module Recaptcha

        def recaptcha_content_entry_valid?(slug, response)
          recaptcha_content_entry_required?(slug) || recaptcha_valid?(response)
        end

        def recaptcha_content_entry_required?(slug)
          type = services.content_entry.get_type(slug)
          type.nil? && type.recaptcha_required
        end

        def recaptcha_valid?(response)
          valid = recaptcha.verify(response)
          liquid_assigns['recaptcha_invalid'] = !valid
          valid
        end

        def recaptcha
          services.recaptcha
        end

      end
    end
  end
end
